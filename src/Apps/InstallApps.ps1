$FakeLoadingBarScriptPath = Join-Path -Path $envVars.DotfilesHelpersFolder -ChildPath "FakeLoadingBar.ps1";
. $FakeLoadingBarScriptPath

# Setze Workspace-Ordner
Set-Workspace-Folder-Windows;

# Installiere Chocolatey
Invoke-Expression -Command "$InstallAppsPath\Chocolatey\Chocolatey.ps1"

# Installiere Windows Terminal
# Invoke-Expression -Command "$InstallAppsPath\WindowsTerminal\Install.ps1"

# Install apps
Write-Host "Installiere Apps..."
Show-LoadingBar

Write-Host "Es wurden alle Apps installiert."