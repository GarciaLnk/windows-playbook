$url = "https://github.com/MustardChef/WSABuilds/releases/download/Windows_11_2310.40000.2.0/WSA_2310.40000.2.0_x64_Release-Nightly-with-Magisk-26.4-stable-MindTheGapps-13.0.7z"
$tempPath = "$env:TEMP\WSA_2310.40000.2.0.7z"
$extractPath = "$env:TEMP\WSA_2310.40000.2.0_x64"

Invoke-WebRequest -Uri $url -OutFile $tempPath

if (-not (Get-Command "7z.exe" -ErrorAction SilentlyContinue)) {
    Write-Error "7-Zip is not installed or not in the system's PATH. Please install it and try again."
    exit
}

# Extract the .7z archive
7z x "$tempPath" -o"$env:TEMP"
Remove-Item -Path $tempPath

# Move the newly extracted folder to the Documents directory
$destinationPath = [System.IO.Path]::Combine([System.Environment]::GetFolderPath('MyDocuments'), "WSA")
Move-Item -Path $extractPath -Destination $destinationPath

Push-Location -Path $destinationPath
Start-Process "Run.bat" -Wait

Pop-Location
exit