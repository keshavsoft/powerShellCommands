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
