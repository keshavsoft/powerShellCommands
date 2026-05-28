$repos = @(
    "https://github.com/keshavsoft/tailwind-todo",    
    "https://github.com/keshavsoft/json-crud-ui-init",
    "https://github.com/keshavsoft/vs-code-ext-json-crud-ui-init",
    "https://github.com/keshavsoft/EndPointGenWebsite"
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
