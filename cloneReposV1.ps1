$repos = @(
    "https://github.com/keshavsoft/EndPointGen",
    "https://github.com/keshavsoft/kschema"
)

$targetFolder = "D:\KeshavSoftRepos"

if (!(Test-Path $targetFolder)) {
    New-Item -ItemType Directory -Path $targetFolder
}

Set-Location $targetFolder

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

Write-Host "All repos processed"