$AppDir = "$(Join-Path $env:APPDATA $env:ChocolateyPackageName)"
Remove-Item -LiteralPath $AppDir -Force -Recurse

nssm.exe remove cerebro confirm
