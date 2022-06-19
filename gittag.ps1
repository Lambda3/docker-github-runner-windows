$ErrorActionPreference = "Stop"
$releases = Invoke-RestMethod https://api.github.com/repos/actions/runner/releases
$releaseTag = npx -q --yes semvermaxcli ( $releases | ? { ! $_.prerelease } | % { $_.tag_name -replace 'v(\d+\.\d+\.\d+)', '$1' })

Write-Output "Release tag: $releaseTag"
Write-Output "Release url: https://github.com/actions/runner/releases/v$releaseTag"
$assetsUrl = Invoke-RestMethod ($releases | ? { $_.tag_name -eq "v$releaseTag" }).assets_url
$assetUrl = $assetsUrl | % { $_.browser_download_url } | ? { $_ -like "*-win-x64-$releaseTag.zip" }
if ($assetUrl.count -ne 1) {
  Write-Error "Found more than one download url: $assetUrl"
  exit 1
} else {
  Write-Output "Download url: $assetUrl"
}
Write-Output "Writing git tag $releaseTag..."
git tag -s $releaseTag -m $releaseTag
if ($LASTEXITCODE -ne 0) {
  Write-Output "Failed to write git tag $releaseTag"
  exit 1
}
