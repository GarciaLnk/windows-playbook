# Download and install VirtIO drivers and Spice Guest Tools
$spiceUrl = "https://www.spice-space.org/download/windows/spice-guest-tools/spice-guest-tools-latest.exe"
$spiceTempPath = "$env:TEMP\spice-guest-tools-latest.exe"
$virtioUrl = "https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.240-1/virtio-win-gt-x64.msi"
$virtioTempPath = "$env:TEMP\virtio-win-gt-x64.msi"

Invoke-WebRequest -Uri $spiceUrl -OutFile $spiceTempPath
Start-Process -FilePath $spiceTempPath -Args "/S" -Wait -NoNewWindow
Invoke-WebRequest -Uri $virtioUrl -OutFile $virtioTempPath
Start-Process "msiexec.exe" -ArgumentList "/i `"$virtioTempPath`" /qn /norestart ADDLOCAL=ALL" -Wait -NoNewWindow

Remove-Item -Path $spiceTempPath -Force
Remove-Item -Path $virtioTempPath -Force
