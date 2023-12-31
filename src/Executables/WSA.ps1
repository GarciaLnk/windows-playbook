$url = "https://github.com/MustardChef/WSABuilds/releases/download/Windows_11_2310.40000.2.0/WSA_2310.40000.2.0_x64_Release-Nightly-with-Magisk-26.4-stable-MindTheGapps-13.0.7z"
$tempPath = "$env:TEMP\WSA_2310.40000.2.0.7z"
$extractPath = "$env:TEMP\WSA_2310.40000.2.0_x64"
$destinationPath = [System.IO.Path]::Combine([System.Environment]::GetFolderPath('MyDocuments'), "WSA")

$7zipPath = "C:\Program Files\7-Zip\7z.exe"
if (-not (Test-Path $7zipPath)) {
    Write-Error "7-Zip is not installed or not in the expected location. Please install it and try again."
    exit
}

$ProgressPreference = 'SilentlyContinue'
Invoke-WebRequest -Uri $url -OutFile $tempPath
& $7zipPath x "$tempPath" -o"$env:TEMP" -y
Remove-Item -Path $tempPath

if (Test-Path $destinationPath) {
    Remove-Item -Path $destinationPath -Recurse -Force
}
Move-Item -Path $extractPath -Destination $destinationPath
