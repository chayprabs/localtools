# localtools installer for Typst Editor (typst-editor 1.0.1). Windows PowerShell 5.1+, no admin.
# Usage: irm https://raw.githubusercontent.com/chayprabs/localtools/main/typst-editor/install.ps1 | iex
# Re-running updates. Set $env:LOCALTOOLS_NO_OPEN='1' to skip launching the tool afterwards.
# Wrapped in a script block so `irm | iex` never leaks settings into, or exits, the caller's session.
& {
$ErrorActionPreference = 'Stop'
$ProgressPreference = 'SilentlyContinue'
[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12

$Slug = 'typst-editor'; $Name = 'Typst Editor'; $Version = '1.0.1'; $Port = 47131; $Kind = 'bin'
$Url = 'https://github.com/chayprabs/localtools/releases/download/typst-editor-v1.0.1/typst-editor-1.0.1-windows-x64.zip'; $Sha = '7a7c457fee6d342876b092b95f0d83a4ca3eb0be43217963bfb2ae3c88d94618'; $Image = ''
$Cmd = "localtools-$Slug"
$Root = if ($env:LOCALTOOLS_HOME) { $env:LOCALTOOLS_HOME } else { Join-Path $env:USERPROFILE '.localtools' }
$Dir = Join-Path $Root $Slug
$Bin = Join-Path $Root 'bin'
$Base = 'https://raw.githubusercontent.com/chayprabs/localtools/main/' + $Slug

function Say($m) { Write-Host "localtools: $m" }
# PS 5.1 turns native stderr into terminating errors under 'Stop'; docker failures are handled via exit codes.
function Invoke-Docker { $ErrorActionPreference = 'Continue'; & docker @args }

if ($Kind -eq 'docker') {
  if (-not (Get-Command docker -ErrorAction SilentlyContinue)) {
    throw "$Name needs Docker. Install Docker Desktop (https://docs.docker.com/desktop/setup/install/windows-install/), start it, then run this command again."
  }
  $os = (Invoke-Docker info --format '{{.OSType}}' 2>$null)
  if ($LASTEXITCODE -ne 0) { throw "Docker is installed but not running. Start Docker Desktop, wait until it says 'running', then run this command again." }
  if ("$os".Trim() -ne 'linux') { throw "Docker is running Windows containers. Right-click the Docker tray icon > 'Switch to Linux containers...', then run this command again." }
}

New-Item -ItemType Directory -Force -Path $Root, $Bin | Out-Null
# Build the new copy in a staging dir next to the install dir; the current install stays untouched until it is ready.
$Stage = "$Dir.new-$PID"; $Old = "$Dir.old-$PID"
Get-ChildItem -Directory -Path $Root -Filter "$Slug.*-*" -ErrorAction SilentlyContinue | Where-Object { $_.Name -match '^.+\.(new|old)-\d+$' } | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue
$zip = Join-Path $env:TEMP "$Slug-$Version-$PID.zip"
try {
  New-Item -ItemType Directory -Force -Path $Stage | Out-Null
  if ($Kind -eq 'docker') {
    $ref = "$Image`:$Version"
    Say "pulling $ref"
    Invoke-Docker pull $ref
    if ($LASTEXITCODE -ne 0) { throw "docker pull $ref failed" }
    # Entry wrapper: serve (default) runs the container and opens the browser; anything else is passed to the tool CLI.
    $ps = @"
`$ErrorActionPreference = 'Continue'
`$a = @(`$args)
`$first = if (`$a.Count) { [string]`$a[0] } else { 'serve' }
switch -regex (`$first) {
  '^update$'    { `$env:LOCALTOOLS_NO_OPEN = '1'; irm '$Base/install.ps1' | iex; return }
  '^uninstall$' { irm '$Base/uninstall.ps1' | iex; return }
  '^(serve|--no-open|--port)$' {
    if (-not (`$a -contains '--no-open') -and `$env:LOCALTOOLS_NO_OPEN -ne '1') {
      Start-Job { for (`$i = 0; `$i -lt 60; `$i++) { try { Invoke-WebRequest -UseBasicParsing 'http://127.0.0.1:$Port/api/health' | Out-Null; Start-Process 'http://127.0.0.1:$Port/'; return } catch { Start-Sleep 1 } } } | Out-Null
    }
    Write-Host "$Cmd $Version running at http://127.0.0.1:$Port  (Ctrl+C to stop)"
    & docker run --rm --name $Cmd -p 127.0.0.1:${Port}:$Port $ref serve --no-open
    exit `$LASTEXITCODE
  }
  default { & docker run --rm -i -v "`${PWD}:/work" -w /work $ref @a; exit `$LASTEXITCODE }
}
"@
    Set-Content -Encoding ASCII -Path (Join-Path $Stage 'run.ps1') -Value $ps
    Set-Content -Encoding ASCII -Path (Join-Path $Stage "$Cmd.cmd") -Value "@powershell -NoProfile -ExecutionPolicy Bypass -File `"%~dp0run.ps1`" %*"
  } else {
    Say "downloading $Name $Version"
    try { Invoke-WebRequest -UseBasicParsing -Uri $Url -OutFile $zip } catch { throw "download of $Url failed: $($_.Exception.Message)" }
    $got = (Get-FileHash -Algorithm SHA256 -Path $zip).Hash.ToLower()
    if ($got -ne $Sha) { throw "checksum mismatch for $Url (expected $Sha, got $got)" }
    Expand-Archive -Path $zip -DestinationPath $Stage -Force
  }
  if (-not ((Test-Path (Join-Path $Stage "$Cmd.exe")) -or (Test-Path (Join-Path $Stage "$Cmd.cmd")))) { throw "release has no $Cmd.exe or $Cmd.cmd at its root" }
  Set-Content -Encoding ASCII -Path (Join-Path $Stage 'installed.txt') -Value "$Version $(Get-Date -Format o)"
} catch {
  Remove-Item -Recurse -Force -ErrorAction SilentlyContinue $Stage
  $was = if (Test-Path $Dir) { "your current install in $Dir was left unchanged" } else { 'nothing was installed' }
  throw "localtools: error: $($_.Exception.Message); $was."
} finally {
  Remove-Item -Force -ErrorAction SilentlyContinue $zip
}

# Swap: stop the running copy, move the old install aside, move the new one in, then delete the old one.
Get-Process -ErrorAction SilentlyContinue | Where-Object { $_.Path -and $_.Path.StartsWith($Dir + [IO.Path]::DirectorySeparatorChar, [StringComparison]::OrdinalIgnoreCase) } | Stop-Process -Force -ErrorAction SilentlyContinue
if ($Kind -eq 'docker') { Invoke-Docker rm -f $Cmd 2>&1 | Out-Null }
function Move-Retry($from, $to) {
  # A just-stopped exe can keep its folder locked for a moment.
  for ($i = 0; ; $i++) { try { Rename-Item -Path $from -NewName (Split-Path -Leaf $to); return } catch { if ($i -ge 20) { throw }; Start-Sleep -Milliseconds 500 } }
}
$hadOld = Test-Path $Dir
try {
  if ($hadOld) { Move-Retry $Dir $Old }
  Move-Retry $Stage $Dir
} catch {
  $err = $_.Exception.Message
  if ($hadOld -and -not (Test-Path $Dir) -and (Test-Path $Old)) { Rename-Item -Path $Old -NewName (Split-Path -Leaf $Dir) }
  Remove-Item -Recurse -Force -ErrorAction SilentlyContinue $Stage
  throw "localtools: error: could not replace $Dir ($err); the previous install was kept. Close $Name and run this command again."
}
if ($hadOld) { Remove-Item -Recurse -Force -ErrorAction SilentlyContinue $Old }

$Entry = Join-Path $Dir "$Cmd.exe"
if (-not (Test-Path $Entry)) { $Entry = Join-Path $Dir "$Cmd.cmd" }

# Shim on PATH.
Set-Content -Encoding ASCII -Path (Join-Path $Bin "$Cmd.cmd") -Value "@call `"$Entry`" %*"

# User PATH (HKCU), no duplicates, keeping REG_EXPAND_SZ entries intact.
$key = Get-Item 'HKCU:\Environment'
$cur = [string]$key.GetValue('Path', '', 'DoNotExpandEnvironmentNames')
$parts = @($cur -split ';' | Where-Object { $_ })
if (-not ($parts | Where-Object { $_.TrimEnd('\') -ieq $Bin })) {
  New-ItemProperty -Path 'HKCU:\Environment' -Name Path -PropertyType ExpandString -Value (($parts + $Bin) -join ';') -Force | Out-Null
  Say "added $Bin to your user PATH"
}
if (-not (($env:Path -split ';') -contains $Bin)) { $env:Path = "$env:Path;$Bin" }

# Start Menu shortcut.
$menu = Join-Path ([Environment]::GetFolderPath('Programs')) 'localtools'
New-Item -ItemType Directory -Force -Path $menu | Out-Null
$lnk = (New-Object -ComObject WScript.Shell).CreateShortcut((Join-Path $menu "$Name.lnk"))
$lnk.TargetPath = $Entry
$lnk.WorkingDirectory = $Dir
$lnk.WindowStyle = 7
$lnk.Description = "$Name (localtools)"
$ico = Join-Path $Dir "$Cmd.exe"
if (Test-Path $ico) { $lnk.IconLocation = "$ico,0" }
$lnk.Save()

Say "installed $Name $Version to $Dir"
Write-Host ""
Write-Host "  Open it:    Start menu > localtools > $Name   (or run: $Cmd)"
Write-Host "  In browser: http://127.0.0.1:$Port"
Write-Host "  Update:     $Cmd update"
Write-Host "  Uninstall:  $Cmd uninstall"
Write-Host "  New terminals pick up PATH automatically; this one already has it."
Write-Host ""

if ($env:LOCALTOOLS_NO_OPEN -ne '1') {
  Start-Process -FilePath $Entry -WorkingDirectory $Dir -WindowStyle Minimized
}
}
