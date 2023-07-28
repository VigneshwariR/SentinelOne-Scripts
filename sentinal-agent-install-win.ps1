# Configuration variables
$SentinelOneUrl = 'https://example.com/SentinelInstaller.msi'  # Replace with the actual download URL
$SiteKey = 'SITE_TOKEN'  # Replace with your actual site key
$DownloadPath = 'C:\tmp\sentinelone_package.msi'
$ExtractedFolder = 'C:\tmp\SentinelOnePackage'

# Check if SentinelOne is already installed
$SentinelOneInstalled = Get-Service -Name "SentinelAgent"

if ($SentinelOneInstalled.Status -eq "Running") {
    Write-Host "SentinelOne is already installed. Skipping installation."
}
else {
    # Create the target directory if it doesn't exist
    if (!(Test-Path -Path 'C:\tmp' -PathType Container)) {
        New-Item -ItemType Directory -Path 'C:\tmp' | Out-Null
    }

    # Check if the file already exists in the download path
    if (Test-Path $DownloadPath -PathType Leaf) {
        Write-Host "SentinelOne package already exists in the download folder. Proceeding with the installation..."

        # Link the package with the site key
        Write-Host "Linking the package with the site key..."
        Start-Process $DownloadPath -ArgumentList "SITE_TOKEN=$SiteKey /quiet /NORESTART" -Wait
        
        # Clean up
        Write-Host "Cleaning up temporary files..."
        Remove-Item $DownloadPath -Force
    }
    else {
        # Download the package
        Write-Host "Downloading SentinelOne package..."
        $response = Invoke-WebRequest -Uri $SentinelOneUrl -OutFile $DownloadPath

        # Link the package with the site key
        Write-Host "Linking the package with the site key..."
        Start-Process $DownloadPath -ArgumentList "SITE_TOKEN=$SiteKey /quiet /NORESTART" -Wait

        # Clean up
        Write-Host "Cleaning up temporary files..."
        Remove-Item $DownloadPath -Force
        }
    }

# Check if the SentinelOne service is running successfully
$SentinelOneService = Get-Service -Name "SentinelAgent"
if ($SentinelOneService.Status -eq "Running") {
    Write-Host "SentinelOne service is running successfully."
} else {
    Write-Host "SentinelOne service is not running. Please check the installation manually."
}

Write-Host "SentinelOne installation or check completed."