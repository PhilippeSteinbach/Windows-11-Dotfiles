$DotfilesFolder = Join-Path -Path $HOME -ChildPath ".dotfiles";
$FakeLoaingBarScriptPath = Join-Path -Path $HelperPath -ChildPath "FakeLoadingBar.ps1";
. $FakeLoaingBarScriptPath

# Configure Windows
Write-Host "Beginne mit der Konfiguration von Windows..."

Write-Host "Konfiguriere den Datei-Explorer"
Show-LoadingBar

Write-Host "Konfiguriere Microsoft Windows optionale Funktionen"
Show-LoadingBar

Write-Host "Konfiguration von Windows abgeschlossen."