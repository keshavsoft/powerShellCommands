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

    $isWin = $IsWindows -or ($env:OS -like "*Windows*") -or ($PSVersionTable.OS -like "*Windows*")
    $isLin = $IsLinux -or ($PSVersionTable.OS -like "*Linux*")

    if ($isWin) {
        winget install --id Git.Git -e --source winget
    } elseif ($isLin) {
        sudo apt-get update && sudo apt-get install -y git
    } else {
        Write-Host "Unsupported operating system for auto-installation. Please install git manually."
        return $false
    }

    $gitExistsAfterInstall = Get-Command git -ErrorAction SilentlyContinue

    if ($gitExistsAfterInstall) {
        Write-Host "Git installed successfully"
        return $true
    }

    Write-Host "Git installation failed"

    return $false
};
