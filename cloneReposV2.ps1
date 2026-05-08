$repos = @(
    "https://github.com/keshavsoft/BackEndGenerator",
    "https://github.com/keshavsoft/kschema"
)

# ---------- base folder ----------
$baseFolder = "D:\KeshavSoftRepos"

# ---------- today folder ----------
$todayFolder = Get-Date -Format "yyyy-MM-dd"

# ---------- final target ----------
$targetFolder = Join-Path $baseFolder $todayFolder

# ---------- create base folder ----------
if (!(Test-Path $baseFolder)) {
    New-Item -ItemType Directory -Path $baseFolder
}

# ---------- create today folder ----------
if (!(Test-Path $targetFolder)) {
    New-Item -ItemType Directory -Path $targetFolder
}

# ---------- move into target ----------
Set-Location $targetFolder

# ---------- clone repos ----------
foreach ($repo in $repos) {

    $repoName = ($repo.Split("/") | Select-Object -Last 1)

    if (Test-Path $repoName) {
        Write-Host "$repoName already exists"
    }
    else {
        Write-Host "Cloning $repoName ..."
        git clone $repo
    }
}

Write-Host ""
Write-Host "Workspace ready : $targetFolder"