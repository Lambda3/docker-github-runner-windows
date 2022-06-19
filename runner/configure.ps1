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
$TOKEN = $env:TOKEN
$REPO = $env:REPO
$GROUP = $env:GROUP
if (!($env:GROUP)) {
  $GROUP = "Default"
}
Remove-Item Env:\TOKEN
Remove-Item Env:\REPO
Remove-Item Env:\GROUP
. .\config.cmd --unattended --url https://github.com/$REPO --token $TOKEN --runnergroup $GROUP
if ($LASTEXITCODE -ne 0) {
  Write-Error "Failed to configure GitHub Actions runner."
  exit 1
}