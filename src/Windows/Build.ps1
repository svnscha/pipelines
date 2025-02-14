# Build.ps1 - Simulated Build Script
#
# SYNOPSIS
#   Simulates a build process by logging parameters and creating a dummy build output file.
#
# DESCRIPTION
#   This script logs the provided build parameters, determines if the build is signed,
#   ensures the target directory exists, and creates a simulated build output file.
#   It is useful for testing and validating build automation workflows.
#
# PARAMETERS
#   -Platform        The target platform (e.g., x86, x64, ARM64).
#   -Configuration   The build configuration (e.g., Debug, Release).
#   -Target         The output directory where the build result will be stored.
#
# ENVIRONMENT VARIABLES
#   CERT_THUMBPRINT  Used to determine if the build is signed.
#
# OUTPUTS
#   A text file in the target directory simulating the build result.

param (
    [string]$Platform,
    [string]$Configuration,
    [string]$Target
)

# Get Certificate Thumbprint from Environment
$CertThumbprint = $env:CERT_THUMBPRINT

# Function to log messages with timestamps
function Log {
    param ([string]$Message)
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Write-Host "[$timestamp] $Message"
}

# Determine if the build is signed or unsigned
if ([string]::IsNullOrEmpty($CertThumbprint)) {
    $BuildType = "Unsigned Build"
} else {
    $BuildType = "Signed and Optimized Build"
}

# Start logging build information
Log "Starting build process..."
Log "Platform: $Platform"
Log "Configuration: $Configuration"
Log "Target Directory: $Target"
Log "Build Type: $BuildType"

# Ensure target directory exists
if (!(Test-Path -Path $Target)) {
    Log "Target directory does not exist. Creating: $Target"
    New-Item -ItemType Directory -Path $Target -Force | Out-Null
}

# Simulate build output
$buildOutputFile = Join-Path -Path $Target -ChildPath "BuildOutput_${Platform}_${Configuration}.txt"
"Build successful for Platform: $Platform, Configuration: $Configuration, Type: $BuildType" | Out-File -FilePath $buildOutputFile -Encoding UTF8

Log "Build simulation complete. Output file created: $buildOutputFile"
Log "Build process finished."

exit 0
