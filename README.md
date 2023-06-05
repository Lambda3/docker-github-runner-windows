# This project is unmaintaned

At this point the project is unmantained. If you wish to collaborate let us know.

# Github Self hosted runner for Windows

This repository contains `Dockerfile` definitions for
[lambda3/github-runner-windows](https://github.com/lambda3/docker-github-runner-windows).

[![Downloads from Docker Hub](https://img.shields.io/docker/pulls/lambda3/github-runner-windows.svg)](https://registry.hub.docker.com/u/lambda3/github-runner-windows)
[![Build](https://github.com/lambda3/docker-github-runner-windows/actions/workflows/build.yml/badge.svg?branch=main)](https://github.com/Lambda3/docker-github-runner-windows/actions/workflows/build.yml)

## Supported tags

- [`latest` (*runner/Dockerfile*)](https://github.com/lambda3/docker-github-runner-windows/blob/main/runner/Dockerfile)

## Configuration

You need to set these environment variables:

- `TOKEN` - The token from Github Actions. Required.
- `REPO` - The Github repo, should be `owner/repo`. Required.
- `GROUP` - The runner group. Optional. Default value: `Default`

To create the above token see the requirements at
[the Github docs](https://docs.github.com/en/actions/hosting-your-own-runners/autoscaling-with-self-hosted-runners#authentication-requirements). At the time of this writing, public repos use the `public_repo`
[scope](https://docs.github.com/en/apps/building-oauth-apps/understanding-scopes-for-oauth-apps/#available-scopes),
and private repos use the `repo` scope.
You can create tokens for a user at <https://github.com/settings/tokens>.
This token will be used to call the
[api](https://docs.github.com/en/rest/actions/self-hosted-runners#create-a-registration-token-for-a-repository)
and use it to exchage it for a runner registration token.

## Running

On Windows, use Docker for Windows and run, on PowerShell:

````powershell
docker run --name github-actions-runner -e TOKEN=$env:TOKEN -e REPO=$env:REPO lambda3/github-runner-windows
````

## Maintainers

- [Giovanni Bassi](http://blog.lambda3.com.br/L3/giovannibassi/), aka Giggio, [Lambda3](http://www.lambda3.com.br), [@giovannibassi](https://twitter.com/giovannibassi)

## License

This software is open source, licensed under the MIT license.
See [LICENSE.txt](https://github.com/lambda3/docker-github-runner-windows/blob/main/LICENSE.txt) for details.
Check out the terms of the license before you contribute, fork, copy or do anything
with the code. If you decide to contribute you agree to grant copyright of all your contribution to this project, and agree to
mention clearly if do not agree to these terms. Your work will be licensed with the project at Apache V2, along the rest of the code.
