# Initialisiere Umgebungsvariablen
$InitScriptPath = Join-Path -Path $DotfilesFolder -ChildPath "${GitHubRepositoryName}-main" | Join-Path -ChildPath ".\src\Helper\Initialize-DotfilesEnvironment.ps1"
. $InitScriptPath
$envVars = Initialize-DotfilesEnvironment

$FakeLoaingBarScriptPath = Join-Path -Path $envVars.DotfilesHelpersFolder -ChildPath "FakeLoadingBar.ps1";
. $FakeLoaingBarScriptPath

# Configure Windows
Write-Host "Beginne mit der Konfiguration von Windows..."

Write-Host "Konfiguriere den Datei-Explorer"
Show-LoadingBar

Write-Host "Konfiguriere Microsoft Windows optionale Funktionen"
Show-LoadingBar

Write-Host "Konfiguration von Windows abgeschlossen."