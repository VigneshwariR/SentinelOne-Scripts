# Configuration variables
$SentinelOneUrl = 'https://example.com/SentinelInstaller.msi'  # Replace with the actual download URL
$SiteKey = 'SITE_TOKEN'  # Replace with your actual site key
$DownloadPath = 'C:\tmp\sentinelone_package.msi'

function Download-Package {
    param (
        [string]$url,
        [string]$outputPath
    )
    try {
        Write-Host "Downloading SentinelOne package from $url..."
        Invoke-WebRequest -Uri $url -OutFile $outputPath
    } catch {
        Write-Host "Error downloading package: $_"
        exit 1
    }
}

function Install-Package {
    param (
        [string]$packagePath,
        [string]$siteKey
    )
    try {
        Write-Host "Installing SentinelOne package..."
        Start-Process $packagePath -ArgumentList "SITE_TOKEN=$siteKey /quiet /NORESTART" -Wait
    } catch {
        Write-Host "Error installing package: $_"
        exit 1
    }
}

# Check if SentinelOne is already installed
$SentinelOneInstalled = Get-Service -Name "SentinelAgent" -ErrorAction SilentlyContinue

if ($SentinelOneInstalled -and $SentinelOneInstalled.Status -eq "Running") {
    Write-Host "SentinelOne is already installed. Skipping installation."
} else {
    # Ensure target directory exists
    if (!(Test-Path -Path 'C:\tmp' -PathType Container)) {
        New-Item -ItemType Directory -Path 'C:\tmp' | Out-Null
    }

    # Download and install the package
    if (!(Test-Path $DownloadPath -PathType Leaf)) {
        Download-Package -url $SentinelOneUrl -outputPath $DownloadPath
    } else {
        Write-Host "SentinelOne package already exists in the download folder. Proceeding with the installation..."
    }

    Install-Package -packagePath $DownloadPath -siteKey $SiteKey

    # Clean up
    Write-Host "Cleaning up temporary files..."
    Remove-Item $DownloadPath -Force
}

# Verify installation
$SentinelOneService = Get-Service -Name "SentinelAgent" -ErrorAction SilentlyContinue
if ($SentinelOneService -and $SentinelOneService.Status -eq "Running") {
    Write-Host "SentinelOne service is running successfully."
} else {
    Write-Host "SentinelOne service is not running. Please check the installation manually."
}

Write-Host "SentinelOne installation or check completed."
