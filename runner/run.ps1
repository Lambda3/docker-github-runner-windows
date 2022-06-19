#!/usr/bin/env pwsh
$ErrorActionPreference = "Stop"
if ($env:TOKEN) {
  Remove-Item Env:\TOKEN
}
if ($env:REPO) {
  Remove-Item Env:\REPO
}
if ($env:GROUP) {
  Remove-Item Env:\GROUP
}
if ($env:LTSC_YEAR) {
  Remove-Item Env:\LTSC_YEAR
}
. .\run.cmd
