function Install-NpmPackages {
    param (
        $inTargetFolder
    )

    Write-Host ""
    Write-Host "Running npm install..."
    Write-Host ""

    $backendGeneratorPath = Join-Path $inTargetFolder "BackEndGenerator"
    $packageJsonPath = Join-Path $backendGeneratorPath "package.json"

    if (Test-Path $packageJsonPath) {

        Write-Host ""
        Write-Host "npm install : BackEndGenerator"
        Write-Host ""

        Push-Location $backendGeneratorPath

        npm install

        Pop-Location
    }
};
