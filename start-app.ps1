# Path to the published app
$appPath = "C:\app\published-app\HelloWordAndrei.dll"
$serviceName = "HelloWorldAndreiService"

# Install the .NET application as a Windows Service
$serviceExists = Get-Service -Name $serviceName -ErrorAction SilentlyContinue

if (-not $serviceExists) {
    $arguments = @"
create "$serviceName" binpath= "C:\Program Files\dotnet\dotnet.exe $appPath" start= auto
"@
    Invoke-Expression -Command:"sc.exe $arguments"
}

# Start the Windows Service
Start-Service -Name $serviceName
