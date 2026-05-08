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

# ---------- stop if workspace already exists ----------
if (Test-Path $targetFolder) {
    Write-Host "Workspace already exists : $targetFolder"
    exit
}

# ---------- create workspace ----------
New-Item -ItemType Directory -Path $targetFolder

Write-Host ""
Write-Host "Starting parallel clone..."
Write-Host ""

# ---------- parallel clone ----------
$repos | ForEach-Object -Parallel {

    $repo = $_

    $repoName = ($repo.Split("/") | Select-Object -Last 1)

    Write-Host "Cloning $repoName ..."

    git clone $repo "$using:targetFolder\$repoName"

} -ThrottleLimit 5

Write-Host ""
Write-Host "Workspace ready : $targetFolder"

Start-Process explorer.exe $targetFolder