$repos = @(
    "https://github.com/keshavsoft/vs-code-ext-boilerplate",    
    "https://github.com/keshavsoft/EndPointGenWebsite",
    "https://github.com/keshavsoft/vs-code-ext-express-api-gen-post-actions",
    "https://github.com/keshavsoft/vs-code-ext-express-api-gen-get-actions",
    "https://github.com/keshavsoft/vs-code-ext-express-api-gen-del-actions",
    "https://github.com/keshavsoft/vs-code-ext-express-api-gen-post-actions",
    "https://github.com/keshavsoft/vs-code-ext-express-api-gen-put-actions",
    "https://github.com/keshavsoft/vs-code-ext-express-api-gen-routes",
    "https://github.com/keshavsoft/vs-code-ext-express-api-gen-endpoints",
    "https://github.com/keshavsoft/vs-code-ext-express-api-gen",
    "https://github.com/keshavsoft/vs-code-ext-json-crud-ui-table",
    "https://github.com/keshavsoft/vs-code-ext-json-crud-ui-init"
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
