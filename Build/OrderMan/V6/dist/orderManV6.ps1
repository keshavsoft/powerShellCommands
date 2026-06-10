

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

function Get-TodayFolderName {
    return Get-Date -Format "yyyy-MM-dd"
}

function Get-NextWorkspaceFolder {
    param (
        $baseFolder,
        $todayFolder
    )

    $counter = 1
    $newFolder = Join-Path $baseFolder "$todayFolder($counter)"

    while (Test-Path $newFolder) {
        $counter++
        $newFolder = Join-Path $baseFolder "$todayFolder($counter)"
    }

    return $newFolder
}

function Confirm-NewWorkspaceFolder {
    param (
        $targetFolder,
        $newFolder
    )

    Write-Host ""
    Write-Host "Workspace exists : $targetFolder"
    Write-Host "New workspace    : $newFolder"
    Write-Host ""

    $answer = Read-Host "Create another workspace folder? (Y/N)"

    if ($answer -ne "Y") {
        Write-Host ""
        Write-Host "Operation cancelled"
        Write-Host ""
        exit
    }
}

function Get-WorkspaceFolder {

    $todayFolder = Get-TodayFolderName

    $targetFolder = Join-Path $baseFolder $todayFolder

    if (!(Test-Path $targetFolder)) {
        return $targetFolder
    }

    $newFolder = Get-NextWorkspaceFolder `
        -baseFolder $baseFolder `
        -todayFolder $todayFolder

    Confirm-NewWorkspaceFolder `
        -targetFolder $targetFolder `
        -newFolder $newFolder

    return $newFolder
}

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
    "https://github.com/keshavsoft/OrderManV14",    
    "https://github.com/keshavsoft/kschema-fs-api-gen-actions",
    "https://github.com/keshavsoft/json-crud-fs",
    "https://github.com/keshavsoft/json-crud-ui-table",
    "https://github.com/keshavsoft/tailwind-table-dom",
    "https://github.com/keshavsoft/tailwind-header-dom",
    "https://github.com/keshavsoft/tailwind-table-dom-comp",
    "https://github.com/keshavsoft/tailwind-vertical-dom",
    "https://github.com/keshavsoft/tailwind-gen-css",
    "https://github.com/keshavsoft/vs-code-ext-json-crud-ui-table",
    "https://github.com/keshavsoft/tallyExtract"
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
