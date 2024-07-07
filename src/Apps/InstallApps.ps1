$DotfilesFolder = Join-Path -Path $HOME -ChildPath ".dotfiles";
$FakeLoaingBarScriptPath = Join-Path -Path $HelperPath -ChildPath "FakeLoadingBar.ps1";
. $FakeLoaingBarScriptPath

# Setze Workspace-Ordner
$WorkspaceFolder = Join-Path -Path $Config.WorkspaceDisk -ChildPath "Workspace";

# Install choco
Write-Host "Installiere Chocolatey..."
Show-LoadingBar

# Install apps
Write-Host "Installiere Apps..."
Show-LoadingBar

Write-Host "Es wurden alle Apps installiert."