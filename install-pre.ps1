# Set installation directory for .NET SDK
$dotnetInstallDir = "C:\Program Files\dotnet"

# .NET installation directory exists
if (-Not (Test-Path -Path $dotnetInstallDir -PathType Container)) {
    New-Item -Path $dotnetInstallDir -ItemType Directory -Force
}

# Install .NET Core 7.0 SDK
Write-Output "Installing .NET Core 7.0 SDK..."
Invoke-WebRequest -Uri https://dot.net/v1/dotnet-install.ps1 -OutFile dotnet-install.ps1 -ErrorAction Stop
.\dotnet-install.ps1 -Channel 7.0 -InstallDir $dotnetInstallDir -ErrorAction Stop

if (Test-Path (Join-Path $dotnetInstallDir "sdk")) {
    Write-Output ".NET Core 7.0 SDK installed successfully."
} else {
    Write-Error ".NET Core 7.0 SDK installation failed."
    exit 1  # Exit the script with an error code
}


# Install Git and create the C:\temp directory if it doesn't exist
if (-Not (Test-Path -Path "C:\temp" -PathType Container)) {
    New-Item -Path "C:\temp" -ItemType Directory -Force
}

# Proceed with downloading the Git installer
$gitInstallerUrl = "https://github.com/git-for-windows/git/releases/download/v2.33.1.windows.1/Git-2.33.1-64-bit.exe"
$gitInstallerPath = "C:\temp\GitInstaller.exe"

# Download Git installer
Invoke-WebRequest -Uri $gitInstallerUrl -OutFile $gitInstallerPath -UseBasicParsing

# Install Git silently
Start-Process -FilePath $gitInstallerPath -ArgumentList "/VERYSILENT /NORESTART /NOCANCEL /SP- /CLOSEAPPLICATIONS /RESTARTAPPLICATIONS /COMPONENTS='icons,ext\reg\shellhere,assoc,assoc_sh' /DIR=C:\Git" -Wait

# Clean up
Remove-Item -Path $gitInstallerPath -Force

if (Test-Path (Join-Path "C:\Git" "cmd\git.exe")) {
    Write-Output "Git installed successfully."
} else {
    Write-Error "Failed to install Git."
    exit 1  # Exit the script with an error code
}
