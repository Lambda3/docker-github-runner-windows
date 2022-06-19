# escape=`
ARG FROM=mcr.microsoft.com/windows/servercore:ltsc2019
FROM ${FROM} as runner
SHELL [ "powershell.exe", "-NoLogo", "-Command", "$ErrorActionPreference='Stop';", "$ProgressPreference='SilentlyContinue';" ]
RUN Invoke-WebRequest https://nodejs.org/dist/v16.15.1/node-v16.15.1-win-x64.zip -OutFile node.zip; `
    Add-Type -AssemblyName System.IO.Compression.FileSystem; `
    [System.IO.Compression.ZipFile]::ExtractToDirectory(\"$PWD/node.zip\", \"$env:temp\node\"); `
    mv \"$env:temp\node\node-v16.15.1-win-x64\" c:\node\; `
    $env:Path=\"c:\node\;$env:PATH\"; `
    $releases = Invoke-RestMethod https://api.github.com/repos/actions/runner/releases; `
    $releaseTag = npx -q --yes semvermaxcli ( $releases | ? { ! $_.prerelease } | % { $_.tag_name -replace 'v(\d+\.\d+\.\d+)', '$1' }); `
    $assetsUrl = Invoke-RestMethod ($releases | ? { $_.tag_name -eq \"v$releaseTag\" }).assets_url; `
    $assetUrl = $assetsUrl | % { $_.browser_download_url } | ? { $_ -like \"*-win-x64-$releaseTag.zip\" }; `
    if ($assetUrl.count -ne 1) { throw \"Found more than one version.\" } `
    Invoke-WebRequest $assetUrl -OutFile C:\actions-runner.zip;

FROM ${FROM}
LABEL maintainer="giggio@giggio.net"
WORKDIR c:\actions-runner\
SHELL [ "powershell.exe", "-NoLogo", "-Command", "$ErrorActionPreference='Stop';", "$ProgressPreference='SilentlyContinue';" ]
# runner, auto download latest release
COPY --from=runner C:\actions-runner.zip C:\actions-runner\
RUN Add-Type -AssemblyName System.IO.Compression.FileSystem; `
    [System.IO.Compression.ZipFile]::ExtractToDirectory('actions-runner.zip', '.'); `
    Remove-Item actions-runner.zip
COPY *.ps1 c:\actions-runner\
CMD ["powershell", "-f", "configureAndRun.ps1"]