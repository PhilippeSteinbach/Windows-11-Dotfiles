# Initialisiere Umgebungsvariablen
$InitScriptPath = Join-Path -Path $DotfilesFolder -ChildPath "${GitHubRepositoryName}-main" | Join-Path -ChildPath ".\src\Helper\Initialize-DotfilesEnvironment.ps1"
. $InitScriptPath
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