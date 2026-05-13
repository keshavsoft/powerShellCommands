function Open-Workspace {
    param (
        $inTargetFolder
    )

    Write-Host ""
    Write-Host "Workspace ready : $inTargetFolder"
    Write-Host ""

    Start-Process explorer.exe $inTargetFolder

    Set-Location $inTargetFolder
};
