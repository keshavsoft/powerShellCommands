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
