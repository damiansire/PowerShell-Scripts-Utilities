$projectDirectory = "HERE_THE_DIRECTORY_PATH"

$files = Get-ChildItem -Path $projectDirectory -File -Recurse


foreach ($file in $files) {
    $folderName = [System.IO.Path]::GetFileNameWithoutExtension($file.Name)
    $folderPath = Join-Path -Path $file.Directory.FullName -ChildPath $folderName

    if ($file.Directory.FullName -ne $projectDirectory) {
        if (-not (Test-Path -Path $folderPath -PathType Container)) {
            New-Item -Path $folderPath -ItemType Directory
        }

        Move-Item -Path $file.FullName -Destination (Join-Path -Path $folderPath -ChildPath $file.Name)
    }
}
