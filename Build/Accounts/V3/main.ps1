$repos = @(
    "https://github.com/keshavsoft/accountsV8",    
    "https://github.com/keshavsoft/kschema-fs-api-gen-actions",
    "https://github.com/keshavsoft/json-crud-fs",
    "https://github.com/keshavsoft/json-crud-ui-table",
    "https://github.com/keshavsoft/tailwind-table-dom",
    "https://github.com/keshavsoft/tailwind-header",
    "https://github.com/keshavsoft/vs-code-ext-json-crud-ui-table"
)

$baseFolder = "D:\KeshavSoftRepos"

$targetFolder = Get-WorkspaceFolder

Ensure-BaseFolder -inBaseFolder $baseFolder

Ensure-WorkspaceFolder -inTargetFolder $targetFolder

if (-not (Ensure-GitInstalled)) {
    return
}

Clone-Repos -inRepos $repos -inTargetFolder $targetFolder

Install-NpmPackages -inTargetFolder $targetFolder

Open-Workspace -inTargetFolder $targetFolder
