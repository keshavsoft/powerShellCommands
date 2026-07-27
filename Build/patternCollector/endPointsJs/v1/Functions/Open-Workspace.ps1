function Open-Workspace {
    param (
        $inTargetFolder
    )

    Write-Host ""
    Write-Host "Workspace ready : $inTargetFolder"
    Write-Host ""

    $isWin = $IsWindows -or ($env:OS -like "*Windows*") -or ($PSVersionTable.OS -like "*Windows*")
    $isLin = $IsLinux -or ($PSVersionTable.OS -like "*Linux*")

    if ($isWin) {
        Start-Process explorer.exe $inTargetFolder
    } elseif ($isLin) {
        if (Get-Command xdg-open -ErrorAction SilentlyContinue) {
            Start-Process xdg-open $inTargetFolder
        } elseif (Get-Command nautilus -ErrorAction SilentlyContinue) {
            Start-Process nautilus $inTargetFolder
        } else {
            Write-Host "Could not find xdg-open or nautilus to open the folder automatically."
        }
    } else {
        Write-Host "Unsupported operating system for auto-opening folder."
    }

    Set-Location $inTargetFolder
};
