$ErrorActionPreference = 'Stop';

$meta = Get-Content -Path $env:ChocolateyPackageFolder\tools\packageArgs.json -Raw
$packageArgs = @{}
(ConvertFrom-Json $meta).psobject.properties | Foreach { $packageArgs[$_.Name] = $_.Value }

$packageArgs["packageName"] = $env:ChocolateyPackageName
$packageArgs["unzipLocation"] = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Install-ChocolateyZipPackage @packageArgs

Install-BinFile -Name 'cerebro' -Path (Join-Path (Join-Path $toolsDir 'bin') 'cerebro.bat')
