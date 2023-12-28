# Script to install Universal x86 Tuning Utility
$url = "https://github.com/JamesCJ60/Universal-x86-Tuning-Utility/releases/latest/download/Universal.x86.Tuning.Utility.V2.msi"
$tempPath = Join-Path -Path $env:TEMP -ChildPath "Universal.x86.Tuning.Utility.V2.msi"

Invoke-WebRequest -Uri $url -OutFile $tempPath
Start-Process -FilePath "msiexec.exe" -ArgumentList "/i `"$tempPath`" /passive /norestart" -Wait -NoNewWindow
Remove-Item -Path $tempPath -Force
