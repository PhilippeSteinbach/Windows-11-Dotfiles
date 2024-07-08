$DotfilesFolder = Join-Path -Path $HOME -ChildPath ".dotfiles";
$DotfilesWorkFolder = Join-Path -Path $DotfilesFolder -ChildPath "${GitHubRepositoryName}-main" | Join-Path -ChildPath "src" 
$DotfilesHelpersFolder = Join-Path -Path $DotfilesWorkFolder -ChildPath "Helper";

$FakeLoaingBarScriptPath = Join-Path -Path $DotfilesHelpersFolder -ChildPath "FakeLoadingBar.ps1";
. $FakeLoaingBarScriptPath

# Configure Windows
Write-Host "Beginne mit der Konfiguration von Windows..."

Write-Host "Konfiguriere den Datei-Explorer"
Show-LoadingBar

Write-Host "Konfiguriere Microsoft Windows optionale Funktionen"
Show-LoadingBar

Write-Host "Konfiguration von Windows abgeschlossen."