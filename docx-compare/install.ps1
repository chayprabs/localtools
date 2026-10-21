# localtools installer for DOCX Compare (docx-compare 1.0.3). Windows PowerShell 5.1+, no admin.
# Usage: irm https://raw.githubusercontent.com/chayprabs/localtools/main/docx-compare/install.ps1 | iex
# Re-running updates. Set $env:LOCALTOOLS_NO_OPEN='1' to skip launching the tool afterwards.
# Wrapped in a script block so `irm | iex` never leaks settings into, or exits, the caller's session.
& {
$ErrorActionPreference = 'Stop'
$ProgressPreference = 'SilentlyContinue'
[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12

$Slug = 'docx-compare'; $Name = 'DOCX Compare'; $Version = '1.0.3'; $Port = 47134; $Kind = 'bin'
$Url = 'https://github.com/chayprabs/localtools/releases/download/docx-compare-v1.0.3/docx-compare-1.0.3-windows-x64.zip'; $Sha = '546601df0163ed00e1544fe51fa49c7f89602723a4a63e303ae35d5479351773'; $Image = ''
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
    $ps = @'
$ErrorActionPreference = 'Continue'
$a = @($args); $first = if ($a.Count) { [string]$a[0] } else { 'serve' }
$dir = $PSScriptRoot; $root = Split-Path -Parent $dir
$cmd = 'localtools-docx-compare'; $image = ':1.0.3'
if ($first -in @('update','uninstall')) {
  $shim = Join-Path (Join-Path $root 'bin') "$cmd.cmd"
  if (-not (Test-Path (Join-Path $dir 'installed.txt')) -or -not (Test-Path $shim) -or -not ((Get-Content -Raw $shim).Contains((Join-Path $dir "$cmd.cmd")))) {
    Write-Host "$cmd was not installed by the localtools script; use your original package manager or docker pull $image"; exit 0
  }
  $env:LOCALTOOLS_HOME = $root; $env:LOCALTOOLS_NO_OPEN = '1'
  $script = if ($first -eq 'update') { 'install' } else { 'uninstall' }
  try { irm "https://raw.githubusercontent.com/chayprabs/localtools/main/docx-compare/$script.ps1" | iex; exit 0 } catch { Write-Error $_; exit 1 }
}
$port = if ($env:LOCALTOOLS_PORT) { $env:LOCALTOOLS_PORT } else { '47134' }
$noOpen = $env:LOCALTOOLS_NO_OPEN -eq '1'
if ($first -match '^(serve|--no-open|--port(?:=.*)?)$') {
  $start = if ($first -eq 'serve') { 1 } else { 0 }
  for ($i=$start; $i -lt $a.Count; $i++) {
    switch -regex ([string]$a[$i]) {
      '^--port$' { $i++; if ($i -ge $a.Count) { Write-Error '--port requires a number'; exit 1 }; $port=$a[$i]; break }
      '^--port=(.*)$' { $port=$Matches[1]; break }
      '^--no-open(?:=true)?$' { $noOpen=$true; break }
      default { Write-Error "unknown serve option $($a[$i]) (see --help)"; exit 1 }
    }
  }
  $number=0; if (-not [int]::TryParse([string]$port,[ref]$number) -or $number -lt 1 -or $number -gt 65535) { Write-Error '--port must be 1 through 65535'; exit 1 }
  $url="http://127.0.0.1:$port"
  try { $health=Invoke-RestMethod "$url/api/health" -TimeoutSec 1 } catch { $health=$null }
  if ($health.tool -eq 'docx-compare') { Write-Host "$cmd already running at $url"; if (-not $noOpen) { Start-Process "$url/" }; exit 0 }
  if (-not $noOpen) {
    Start-Job -ArgumentList $url { param($url) for ($i=0; $i -lt 90; $i++) { try { $h=Invoke-RestMethod "$url/api/health" -TimeoutSec 1; if ($h.tool -eq 'docx-compare') { Start-Process "$url/"; return } } catch {}; Start-Sleep 1 } } | Out-Null
  }
  Write-Host "$cmd 1.0.3 running at $url  (Ctrl+C to stop; choose --port N for another port)"
  & docker run --rm --name "$cmd-$port" --label "localtools.install=$dir" --read-only --tmpfs /worktemp:rw,nosuid,nodev,size=384m,mode=1777 --cap-drop ALL --security-opt no-new-privileges -p "127.0.0.1:${port}:$port" $image serve --no-open --port $port
  exit $LASTEXITCODE
}
& docker run --rm -i --network none --read-only --tmpfs /worktemp:rw,nosuid,nodev,size=384m,mode=1777 --cap-drop ALL --security-opt no-new-privileges -v "${PWD}:/work" -w /work $image @a
exit $LASTEXITCODE
'@
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
if ($Kind -eq 'docker') { Invoke-Docker ps -aq --filter "label=localtools.install=$Dir" | ForEach-Object { Invoke-Docker rm -f $_ 2>&1 | Out-Null } }
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
