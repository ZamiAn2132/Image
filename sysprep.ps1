$ErrorActionPreference = "Stop"

Write-Host "Running Sysprep..."
& "$Env:SystemRoot\System32\Sysprep\Sysprep.exe" /oobe /generalize /shutdown

Write-Host "Sysprep complete."
#Install sysprep to get the custom image.
