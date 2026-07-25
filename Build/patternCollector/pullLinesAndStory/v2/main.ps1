$repos = @(
    "https://github.com/keshavsoft/pattern-collector-anyjs",
    "https://github.com/keshavsoft/pattern-collector-anyjs-pull-lines",
    "https://github.com/keshavsoft/pattern-collector-anyjs-pull-lines-import",
    "https://github.com/keshavsoft/pattern-collector-anyjs-pull-lines-consumption",
    "https://github.com/keshavsoft/pattern-collector-anyjs-pull-lines-all",
    "https://github.com/keshavsoft/pattern-collector-anyjs-build-story"
)

function Get-BaseFolder {
    $inputPath = Read-Host "Workspace path (Press Enter for default)"

    if (-not [string]::IsNullOrWhiteSpace($inputPath)) {
        return $inputPath
    }

    $isWin = $IsWindows -or ($env:OS -like "*Windows*") -or ($PSVersionTable.OS -like "*Windows*")

    if ($isWin -and (Test-Path "D:\")) {
        return "D:\KeshavSoftRepos"
    }

    return (Join-Path $HOME "KeshavSoftRepos")
}

$baseFolder = Get-BaseFolder

$targetFolder = Get-WorkspaceFolder

Ensure-BaseFolder -inBaseFolder $baseFolder

Ensure-WorkspaceFolder -inTargetFolder $targetFolder

if (-not (Ensure-GitInstalled)) {
    return
}

Clone-Repos -inRepos $repos -inTargetFolder $targetFolder

Install-NpmPackages -inTargetFolder $targetFolder

Open-Workspace -inTargetFolder $targetFolder
