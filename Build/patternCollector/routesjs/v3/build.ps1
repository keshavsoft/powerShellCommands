# build.ps1

$sourceFiles = @(
    ".\Functions\Ensure-GitInstalled.ps1",
    ".\Functions\Get-WorkspaceFolder.ps1",
    ".\Functions\Ensure-BaseFolder.ps1",
    ".\Functions\Ensure-WorkspaceFolder.ps1",
    ".\Functions\Clone-Repos.ps1",
    ".\Functions\Install-NpmPackages.ps1",
    ".\Functions\Open-Workspace.ps1",
    ".\main.ps1"
)

$outputFile = ".\dist\patternCollectorRoutesJsV3.ps1"

if (!(Test-Path ".\dist")) {

    New-Item -ItemType Directory -Path ".\dist" | Out-Null
}

"" | Set-Content $outputFile

foreach ($file in $sourceFiles) {

    Write-Host "Adding : $file"

    Add-Content $outputFile "`r`n# ===== FILE : $file =====`r`n"

    Get-Content $file | Add-Content $outputFile
}

Write-Host ""
Write-Host "Build completed : $outputFile"
Write-Host ""