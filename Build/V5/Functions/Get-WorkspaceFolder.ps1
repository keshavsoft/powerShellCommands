function Get-WorkspaceFolder {

    $todayFolder = Get-Date -Format "yyyy-MM-dd"

    $targetFolder = Join-Path $baseFolder $todayFolder

    if (!(Test-Path $targetFolder)) {

        return $targetFolder
    }

    Write-Host ""
    Write-Host "Workspace already exists : $targetFolder"
    Write-Host ""

    $answer = Read-Host "Create another workspace folder? (Y/N)"

    if ($answer -ne "Y") {

        Write-Host ""
        Write-Host "Operation cancelled"
        Write-Host ""

        exit
    }

    $counter = 1

    while (Test-Path $targetFolder) {

        $targetFolder = Join-Path $baseFolder "$todayFolder($counter)"

        $counter++
    }

    return $targetFolder
};
