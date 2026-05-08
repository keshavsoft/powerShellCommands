# cloneReposPar5

$repos = @(
    "https://github.com/keshavsoft/BackEndGenerator",
    "https://github.com/keshavsoft/kschema"
)

$baseFolder = "D:\KeshavSoftRepos"

function Get-WorkspaceFolder {
    $todayFolder = Get-Date -Format "yyyy-MM-dd"

    return Join-Path $baseFolder $todayFolder
};

function Ensure-BaseFolder {
    param (
        $inBaseFolder
    )

    if (!(Test-Path $inBaseFolder)) {
        New-Item -ItemType Directory -Path $inBaseFolder
    }
};

function Ensure-WorkspaceFolder {
    param (
        $inTargetFolder
    )

    if (Test-Path $inTargetFolder) {
        Write-Host "Workspace already exists : $inTargetFolder"
        exit
    }

    New-Item -ItemType Directory -Path $inTargetFolder
};

function Clone-ReposParallel {
    param (
        $inRepos,
        $inTargetFolder
    )

    Write-Host ""
    Write-Host "Starting parallel clone..."
    Write-Host ""

    $inRepos | ForEach-Object -Parallel {

        $repo = $_

        $repoName = ($repo.Split("/") | Select-Object -Last 1)

        Write-Host "Cloning $repoName ..."

        git clone $repo "$using:inTargetFolder\$repoName"

    } -ThrottleLimit 5
};

function Install-NpmPackages {
    param (
        $inTargetFolder
    )

    Write-Host ""
    Write-Host "Running npm install..."
    Write-Host ""

    $backendGeneratorPath = Join-Path $inTargetFolder "BackEndGenerator"

    if (Test-Path "$backendGeneratorPath\package.json") {

        Write-Host "npm install : BackEndGenerator"

        Push-Location $backendGeneratorPath

        npm install

        Pop-Location
    }
};

function Open-Workspace {
    param (
        $inTargetFolder
    )

    Write-Host ""
    Write-Host "Workspace ready : $inTargetFolder"

    Start-Process explorer.exe $inTargetFolder
};

$targetFolder = Get-WorkspaceFolder;

Ensure-BaseFolder -inBaseFolder $baseFolder;

Ensure-WorkspaceFolder -inTargetFolder $targetFolder;

Clone-ReposParallel -inRepos $repos -inTargetFolder $targetFolder;

Install-NpmPackages -inTargetFolder $targetFolder;

Open-Workspace -inTargetFolder $targetFolder;