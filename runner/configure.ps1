#!/usr/bin/env pwsh
$ErrorActionPreference = "Stop"

if (!($env:TOKEN)) {
  Write-Error 'Variable "TOKEN" is not set.'
  exit 2
}
if (!($env:REPO)) {
  Write-Error 'Variable "TOKEN" is not set.'
  exit 2
}
if (!($env:LTSC_YEAR)) {
  Write-Error 'Variable "LTSC_YEAR" is not set.'
  exit 2
}
$TOKEN = $env:TOKEN
$REPO = $env:REPO
$LTSC_YEAR = $env:LTSC_YEAR
$GROUP = $env:GROUP
if ($env:GROUP) {
  Remove-Item Env:\GROUP
} else {
  $GROUP = "Default"
}
Remove-Item Env:\TOKEN
Remove-Item Env:\REPO
Remove-Item Env:\LTSC_YEAR
. .\config.cmd --unattended --url https://github.com/$REPO --token $TOKEN --runnergroup $GROUP --labels windows-$LTSC_YEAR
if ($LASTEXITCODE -ne 0) {
  Write-Error "Failed to configure GitHub Actions runner."
  exit 1
}