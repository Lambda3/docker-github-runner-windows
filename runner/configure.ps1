#!/usr/bin/env pwsh
$ErrorActionPreference = "Stop"

if (!($env:TOKEN)) {
  Write-Error 'Variable "TOKEN" is not set.'
  exit 2
}
if (!($env:REPO)) {
  Write-Error 'Variable "REPO" is not set.'
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
if (Test-Path _work) {
  Write-Host "Already configured."
  return
}
$headers = @{
  'Accept'        = 'application/vnd.github.v3+json'
  'Authorization' = "token $TOKEN"
}
$configToken = Invoke-RestMethod -Method Post -Headers $headers -Uri https://api.github.com/repos/$REPO/actions/runners/registration-token
. .\config.cmd --unattended --url https://github.com/$REPO --token $configToken.token --runnergroup $GROUP --labels windows-$LTSC_YEAR --replace
if ($LASTEXITCODE -ne 0) {
  Write-Error "Failed to configure GitHub Actions runner."
  exit 1
}
