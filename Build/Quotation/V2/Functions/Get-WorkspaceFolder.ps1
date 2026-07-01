function Get-TodayFolderName {
    return Get-Date -Format "yyyy-MM-dd"
}

function Get-NextWorkspaceFolder {
    param (
        $baseFolder,
        $todayFolder
    )

    $counter = 1
    $newFolder = Join-Path $baseFolder "$todayFolder($counter)"

    while (Test-Path $newFolder) {
        $counter++
        $newFolder = Join-Path $baseFolder "$todayFolder($counter)"
    }

    return $newFolder
}

function Confirm-NewWorkspaceFolder {
    param (
        $targetFolder,
        $newFolder
    )

    Write-Host ""
    Write-Host "Workspace exists : $targetFolder"
    Write-Host "New workspace    : $newFolder"
    Write-Host ""

    $answer = Read-Host "Create another workspace folder? (Y/N)"

    if ($answer -ne "Y") {
        Write-Host ""
        Write-Host "Operation cancelled"
        Write-Host ""
        exit
    }
}

function Get-WorkspaceFolder {

    $todayFolder = Get-TodayFolderName

    $targetFolder = Join-Path $baseFolder $todayFolder

    if (!(Test-Path $targetFolder)) {
        return $targetFolder
    }

    $newFolder = Get-NextWorkspaceFolder `
        -baseFolder $baseFolder `
        -todayFolder $todayFolder

    Confirm-NewWorkspaceFolder `
        -targetFolder $targetFolder `
        -newFolder $newFolder

    return $newFolder
}