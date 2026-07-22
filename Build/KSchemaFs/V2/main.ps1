$repos = @(
    "https://github.com/keshavsoft/express-fix-endPoints-js",    
    "https://github.com/keshavsoft/kschema-fs-api-gen-actions",
    "https://github.com/keshavsoft/kschema-pull-endpoints"
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
