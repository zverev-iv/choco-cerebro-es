$ErrorActionPreference = 'Stop';

$meta = Get-Content -Path $env:ChocolateyPackageFolder\tools\packageArgs.json -Raw
$packageArgs = @{}
(ConvertFrom-Json $meta).psobject.properties | ForEach-Object { $packageArgs[$_.Name] = $_.Value }

$packageArgs["packageName"] = $env:ChocolateyPackageName
$packageArgs["unzipLocation"] = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$AppDir = "$(Join-Path $env:APPDATA $env:ChocolateyPackageName)"

Install-ChocolateyZipPackage @packageArgs

nssm.exe install cerebro confirm
nssm.exe set cerebro Application "$(Join-Path $packageArgs["unzipLocation"] (Join-Path "cerebro-$($env:ChocolateyPackageVersion)" (Join-Path "bin" "cerebro.bat")))"
New-Item -ItemType directory -Path $AppDir
nssm.exe set cerebro AppDirectory "$($AppDir)"
net.exe start cerebro
