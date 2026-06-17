$repos = @(
    "https://github.com/keshavsoft/tallyServerV1",    
    "https://github.com/keshavsoft/kschema-fs-api-gen-actions",
    "https://github.com/keshavsoft/json-crud-fs",
    "https://github.com/keshavsoft/json-crud-ui-table",
    "https://github.com/keshavsoft/json-crud-ui-comp",
    "https://github.com/keshavsoft/tailwind-table-dom",
    "https://github.com/keshavsoft/tailwind-header-dom",
    "https://github.com/keshavsoft/tailwind-table-dom-comp",
    "https://github.com/keshavsoft/tailwind-vertical-dom",
    "https://github.com/keshavsoft/tailwind-gen-css",
    "https://github.com/keshavsoft/vs-code-ext-json-crud-ui-table"
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
