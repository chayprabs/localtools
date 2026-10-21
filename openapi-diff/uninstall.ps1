# localtools uninstaller for OpenAPI Diff (openapi-diff). Windows PowerShell 5.1+, no admin.
# Usage: irm https://raw.githubusercontent.com/chayprabs/localtools/main/openapi-diff/uninstall.ps1 | iex
& {
$ErrorActionPreference = 'Stop'
$Slug = 'openapi-diff'; $Name = 'OpenAPI Diff'; $Kind = 'bin'; $Image = ''
$Cmd = "localtools-$Slug"
$Root = if ($env:LOCALTOOLS_HOME) { $env:LOCALTOOLS_HOME } else { Join-Path $env:USERPROFILE '.localtools' }
$Dir = Join-Path $Root $Slug
$Bin = Join-Path $Root 'bin'

Get-Process -ErrorAction SilentlyContinue | Where-Object { $_.Path -and $_.Path.StartsWith($Dir + '\', [StringComparison]::OrdinalIgnoreCase) } | Stop-Process -Force -ErrorAction SilentlyContinue
if ($Kind -eq 'docker' -and (Get-Command docker -ErrorAction SilentlyContinue)) {
  & { $ErrorActionPreference = 'Continue'; docker ps -aq --filter "label=localtools.install=$Dir" | ForEach-Object { docker rm -f $_ }; docker images -q $Image | ForEach-Object { docker rmi -f $_ } } 2>&1 | Out-Null
}
# A just-stopped exe can stay locked for a moment.
for ($i = 0; $i -lt 10 -and (Test-Path $Dir); $i++) {
  try { Remove-Item -Recurse -Force $Dir } catch { Start-Sleep -Milliseconds 500 }
}
if (Test-Path $Dir) { throw "Could not remove $Dir (is $Cmd still running?)" }
Remove-Item -Force -ErrorAction SilentlyContinue (Join-Path $Bin "$Cmd.cmd"), (Join-Path $Root "$Slug-install.log")
Get-ChildItem -Directory -Path $Root -Filter "$Slug.*-*" -ErrorAction SilentlyContinue | Where-Object { $_.Name -match '^.+[.](new|old)-[0-9]+$' } | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue

$menu = Join-Path ([Environment]::GetFolderPath('Programs')) 'localtools'
Remove-Item -Force -ErrorAction SilentlyContinue (Join-Path $menu "$Name.lnk")
if ((Test-Path $menu) -and -not (Get-ChildItem $menu)) { Remove-Item -Force $menu }

# Last localtools tool gone: drop bin dir and the PATH entry.
$others = @(Get-ChildItem -Directory -ErrorAction SilentlyContinue $Root | Where-Object { $_.Name -ne 'bin' })
if ($others.Count -eq 0) {
  $key = Get-Item 'HKCU:\Environment'
  $cur = [string]$key.GetValue('Path', '', 'DoNotExpandEnvironmentNames')
  $keep = @($cur -split ';' | Where-Object { $_ -and ($_.TrimEnd('\') -ine $Bin) })
  if ($keep.Count -ne @($cur -split ';' | Where-Object { $_ }).Count) {
    New-ItemProperty -Path 'HKCU:\Environment' -Name Path -PropertyType ExpandString -Value ($keep -join ';') -Force | Out-Null
  }
  Remove-Item -Recurse -Force -ErrorAction SilentlyContinue $Bin
  if ((Test-Path $Root) -and -not (Get-ChildItem -Force $Root)) { Remove-Item -Force $Root }
}
Write-Host "localtools: uninstalled $Name"
}
