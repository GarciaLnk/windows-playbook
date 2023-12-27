function Update-Feature {
    param(
        [string]$featureName,
        [bool]$bool
    )
    
    $regPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\Notifications\OptionalFeatures"
    $regKey = Get-ItemProperty -Path "$regPath\$featureName" -ErrorAction SilentlyContinue
	
	$dismCmd = if ($bool) { "Enable" } else { "Disable" }
	
    if ($null -eq $regKey -or ($regKey.Selection -eq 0 -and $bool) -or ($regKey.Selection -eq 1 -and !$bool)) {
        Write-Host "$dismCmd $featureName"
        if ($bool) {
            Enable-WindowsOptionalFeature -Online -FeatureName $featureName -NoRestart -All
        } else {
            Disable-WindowsOptionalFeature -Online -FeatureName $featureName -NoRestart
        }
    }
}


$features = @(
    @{ Name = "DirectPlay"; Bool = $true },
    @{ Name = "LegacyComponents"; Bool = $true },
    @{ Name = "MicrosoftWindowsPowerShellV2"; Bool = $true },
    @{ Name = "MicrosoftWindowsPowerShellV2Root"; Bool = $true },
    @{ Name = "MSRDC-Infrastructure"; Bool = $true },
    @{ Name = "Printing-Foundation-Features"; Bool = $true },
    @{ Name = "Printing-Foundation-InternetPrinting-Client"; Bool = $true },
    @{ Name = "Printing-XPSServices-Features"; Bool = $true },
    @{ Name = "Printing-PrintToPDFServices-Features"; Bool = $true },
    @{ Name = "WorkFolders-Client"; Bool = $true }
	@{ Name = "SmbDirect"; Bool = $true }
)
foreach ($feature in $features) {
    Update-Feature -featureName $feature.Name -bool $feature.Bool
}