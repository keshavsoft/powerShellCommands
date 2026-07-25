$repos = @(
    "https://github.com/keshavsoft/pattern-collector-anyjs",
    "https://github.com/keshavsoft/pattern-collector",
    "https://github.com/keshavsoft/pattern-collector-base-regex",
    "https://github.com/keshavsoft/pattern-collector-anyjs-matches",
    "https://github.com/keshavsoft/pattern-collector-anyjs-extract",
    "https://github.com/keshavsoft/pattern-collector-anyjs-pull-lines",
    "https://github.com/keshavsoft/pattern-collector-anyjs-pull-lines-import",
    "https://github.com/keshavsoft/pattern-collector-anyjs-pull-lines-consumption",
    "https://github.com/keshavsoft/pattern-collector-anyjs-build-story",
    "https://github.com/keshavsoft/express-fix-any-js-from-story",
    "https://github.com/keshavsoft/express-fix-any-js-from-for-import",
    "https://github.com/keshavsoft/express-fix-any-js-from-for-consumption"
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
