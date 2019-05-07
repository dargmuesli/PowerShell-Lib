Add-Type -AssemblyName System.IO.Compression.FileSystem
$ZipFolder = Join-Path -Path $PWD -ChildPath $env:APPVEYOR_PROJECT_NAME
$ZipFile = Join-Path -Path $PWD -ChildPath "$($env:APPVEYOR_PROJECT_NAME)_$($env:APPVEYOR_BUILD_VERSION).zip"
Compress-Archive -Path $ZipFolder -DestinationPath $ZipFile
Push-AppveyorArtifact -Path $ZipFile
