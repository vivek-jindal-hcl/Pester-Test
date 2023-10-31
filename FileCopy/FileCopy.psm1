# this function will copy a file from one path to another using absolute paths
function Copy-BYFile {

    param(

        [string]$SourcePath,
        [string]$DestinationPath

    )

    if (-not (Test-Path -Path $SourcePath -PathType Leaf)) {
        throw "Source file does not exist or is not a file: `"$SourcePath`""
    }

    if (Test-Path -Path $DestinationPath -PathType Any) {
        throw "Destination already exists: `"$DestinationPath`""
    }

    Write-Host "Copying `"$SourcePath`" to `"$DestinationPath`""
    Copy-Item -Path $SourcePath -Destination $DestinationPath -Force

}

Export-ModuleMember -Function Copy-BYFile
