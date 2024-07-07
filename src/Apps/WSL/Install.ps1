function Update-UbuntuPackagesRepository() {
    Write-Host "Update Ubuntu Packages Repository"
    wsl sudo apt --yes update;
}

function Update-UbuntuPackages() {
    Write-Host "Update Ubuntu Packages"
    wsl sudo apt --yes upgrade;
}

function Install-UbuntuPackage {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory = $TRUE)]
        [string]
        $PackageName
    )
  
    Write-Host "Install Ubuntu Package: $PackageName" -ForegroundColor "Green";
    wsl sudo apt install --yes --no-install-recommends $PackageName;
}

function Set-Git-Configuration-In-Ubuntu {
    Write-Host "Konfiguriere Git in Ubuntu..." -ForegroundColor "Green";
    
    wsl git config --global init.defaultBranch "main";
    wsl git config --global user.name $Config.GitUserName;
    wsl git config --global user.email $Config.GitUserEmail;
    wsl git config --global credential.helper "/mnt/c/Program\ Files/Git/mingw64/libexec/git-core/git-credential-manager-core.exe";
    wsl git config --list;

    Write-Host "Git in Ubuntu wurde konfiguriert." -ForegroundColor "Green";
}

choco install -y "wsl2" --params "/Version:2 /Retry:true";
choco install -y "wsl-ubuntu-2004" --params "/InstallRoot:true" --execution-timeout 3600;

# Update WSL
Update-UbuntuPackagesRepository;
Update-UbuntuPackages;

# Install WSL Tools
Install-UbuntuPackage -PackageName "git";
Install-UbuntuPackage -PackageName "curl";
Install-UbuntuPackage -PackageName "wget";
Install-UbuntuPackage -PackageName "zsh";
# ...

# Konfiguriere Git
Set-Git-Configuration-In-Ubuntu;

# Installiere aktuellstes Dotnet SDK

# Installiere Oh My Zsh

# Installiere Oh My Zsh Themes

# Konfiguriere Oh My Zsh

# Setze Zsh als Standard-Shell