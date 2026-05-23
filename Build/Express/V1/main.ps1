$repos = @(
    "https://github.com/keshavsoft/vs-code-ext-boilerplate",    
    "https://github.com/keshavsoft/vs-code-ext-express-api-gen",
    "https://github.com/keshavsoft/express-todo",
    "https://github.com/keshavsoft/kschema-api-gen-appjs"
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
