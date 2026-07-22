$repos = @(
    "https://github.com/keshavsoft/pattern-collector",
    "https://github.com/keshavsoft/pattern-collector-routesjs",
    "https://github.com/keshavsoft/pattern-collector-routesjs-build-story",
    "https://github.com/keshavsoft/pattern-collector-routesjs-pull-lines",
    "https://github.com/keshavsoft/pattern-collector-routesjs-use",
    "https://github.com/keshavsoft/pattern-collector-routesjs-use-extract",
    "https://github.com/keshavsoft/pattern-collector-routesjs-import",
    "https://github.com/keshavsoft/pattern-collector-routesjs-import-extract",
    "https://github.com/keshavsoft/pattern-collector-routesjs-fix-consumption",
    "https://github.com/keshavsoft/vs-code-ext-from-any-js"
)

function Get-BaseFolder {
    $inputPath = Read-Host "Workspace path (Press Enter for default)"

    if (-not [string]::IsNullOrWhiteSpace($inputPath)) {
        return $inputPath
    }

    if (Test-Path "D:\") {
        return "D:\KeshavSoftRepos"
    }

    return (Join-Path $env:USERPROFILE "KeshavSoftRepos")
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
