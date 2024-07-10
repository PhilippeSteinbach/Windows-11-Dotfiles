# $DotfilesFolder = Join-Path -Path $HOME -ChildPath ".dotfiles";
# $DotfilesWorkFolder = Join-Path -Path $DotfilesFolder -ChildPath "${GitHubRepositoryName}-main" | Join-Path -ChildPath "src" 
# $DotfilesHelpersFolder = Join-Path -Path $DotfilesWorkFolder -ChildPath "Helper";

# Initialisiere Umgebungsvariablen
. .\src\Helper\Initialize-DotfilesEnvironment.ps1
$envVars = Initialize-DotfilesEnvironment

$FakeLoadingBarScriptPath = Join-Path -Path $envVars.DotfilesHelpersFolder -ChildPath "FakeLoadingBar.ps1";
. $FakeLoadingBarScriptPath

# Setze Workspace-Ordner
#$WorkspaceFolder = Join-Path -Path $Config.WorkspaceDisk -ChildPath "Workspace";

# Install choco
Write-Host "Installiere Chocolatey..."
Show-LoadingBar

# Install apps
Write-Host "Installiere Apps..."
Show-LoadingBar

Write-Host "Es wurden alle Apps installiert."