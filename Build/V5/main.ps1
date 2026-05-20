$repos = @(
    "https://github.com/keshavsoft/kschema-api-gen",
    "https://github.com/keshavsoft/kschema-cli",
    "https://github.com/keshavsoft/kschema",
    "https://github.com/keshavsoft/kschema-api-validator",
    "https://github.com/keshavsoft/kschema-cli-samples",
    "https://github.com/keshavsoft/kschema-api-check",
    "https://github.com/keshavsoft/kschema-api-gen-actions",
    "https://github.com/keshavsoft/powerShellCommands",
    "https://github.com/keshavsoft/express-todo",
    "https://github.com/keshavsoft/tailwind-todo"    
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
