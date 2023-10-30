# Create a directory for your app if it doesn't exist
$baseDir = "C:\app"
if (!(Test-Path -Path $baseDir -PathType Container)) {
    New-Item -Path $baseDir -ItemType Directory -Force
}

# Clone your GitHub repository (replace with your repository URL)
$repoUrl = "https://github.com/ZamiAn2132/HelloWordAndrei.git"
$targetDir = Join-Path -Path $baseDir -ChildPath "my-app"
if (!(Test-Path -Path $targetDir -PathType Container)) {
    git clone $repoUrl $targetDir
}

# Full path to the dotnet executable
$dotnetPath = "C:\Program Files\dotnet\dotnet.exe"

# Build and publish the .NET app
$publishPath = Join-Path -Path $baseDir -ChildPath "published-app"
Set-Location -Path $targetDir
& $dotnetPath publish -c Release -o $publishPath
