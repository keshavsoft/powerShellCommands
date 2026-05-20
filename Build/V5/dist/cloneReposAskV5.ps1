

# ===== FILE : .\Functions\Ensure-GitInstalled.ps1 =====

function Ensure-GitInstalled {

    $gitExists = Get-Command git -ErrorAction SilentlyContinue

    if ($gitExists) {
        Write-Host "Git already installed"
        return $true
    }

    Write-Host ""
    Write-Host "Git is not installed"
    Write-Host ""

    $answer = Read-Host "Install Git now? (Y/N)"

    if ($answer -ne "Y") {
        Write-Host "Git installation cancelled"
        return $false
    }

    Write-Host ""
    Write-Host "Installing Git..."
    Write-Host ""

    winget install --id Git.Git -e --source winget

    $gitExistsAfterInstall = Get-Command git -ErrorAction SilentlyContinue

    if ($gitExistsAfterInstall) {
        Write-Host "Git installed successfully"
        return $true
    }

    Write-Host "Git installation failed"

    return $false
};

# ===== FILE : .\Functions\Get-WorkspaceFolder.ps1 =====

function Get-WorkspaceFolder {

    $todayFolder = Get-Date -Format "yyyy-MM-dd"

    $targetFolder = Join-Path $baseFolder $todayFolder

    if (!(Test-Path $targetFolder)) {

        return $targetFolder
    }

    Write-Host ""
    Write-Host "Workspace already exists : $targetFolder"
    Write-Host ""

    $answer = Read-Host "Create another workspace folder? (Y/N)"

    if ($answer -ne "Y") {

        Write-Host ""
        Write-Host "Operation cancelled"
        Write-Host ""

        exit
    }

    $counter = 1

    while (Test-Path $targetFolder) {

        $targetFolder = Join-Path $baseFolder "$todayFolder($counter)"

        $counter++
    }

    return $targetFolder
};

# ===== FILE : .\Functions\Ensure-BaseFolder.ps1 =====

function Ensure-BaseFolder {
    param (
        $inBaseFolder
    )

    if (!(Test-Path $inBaseFolder)) {

        New-Item -ItemType Directory -Path $inBaseFolder | Out-Null
    }
};

# ===== FILE : .\Functions\Ensure-WorkspaceFolder.ps1 =====

function Ensure-WorkspaceFolder {
    param (
        $inTargetFolder
    )

    if (Test-Path $inTargetFolder) {

        Write-Host ""
        Write-Host "Workspace already exists : $inTargetFolder"
        Write-Host ""

        exit
    }

    New-Item -ItemType Directory -Path $inTargetFolder | Out-Null
};

# ===== FILE : .\Functions\Clone-Repos.ps1 =====

function Clone-Repos {
    param (
        $inRepos,
        $inTargetFolder
    )

    Write-Host ""
    Write-Host "Starting clone..."
    Write-Host ""

    foreach ($repo in $inRepos) {

        $repoName = ($repo.Split("/") | Select-Object -Last 1)

        Write-Host ""
        Write-Host "Cloning $repoName ..."
        Write-Host ""

        git clone --depth 1 $repo "$inTargetFolder\$repoName"

        if ($LASTEXITCODE -ne 0) {

            Write-Host ""
            Write-Host "Failed to clone : $repoName"
            Write-Host ""

            continue
        }
    }
};

# ===== FILE : .\Functions\Install-NpmPackages.ps1 =====

function Install-NpmPackages {
    param (
        $inTargetFolder
    )

    Write-Host ""
    Write-Host "Running npm install..."
    Write-Host ""

    $backendGeneratorPath = Join-Path $inTargetFolder "BackEndGenerator"

    if (Test-Path "$backendGeneratorPath\package.json") {

        Write-Host ""
        Write-Host "npm install : BackEndGenerator"
        Write-Host ""

        Push-Location $backendGeneratorPath

        npm install

        Pop-Location
    }
};

# ===== FILE : .\Functions\Open-Workspace.ps1 =====

function Open-Workspace {
    param (
        $inTargetFolder
    )

    Write-Host ""
    Write-Host "Workspace ready : $inTargetFolder"
    Write-Host ""

    Start-Process explorer.exe $inTargetFolder

    Set-Location $inTargetFolder
};

# ===== FILE : .\main.ps1 =====

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
