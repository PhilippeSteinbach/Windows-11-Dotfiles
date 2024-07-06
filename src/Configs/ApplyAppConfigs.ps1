$DotfilesFolder = Join-Path -Path $HOME -ChildPath ".dotfiles";
$FakeLoaingBarScriptPath = Join-Path -Path $HelperPath -ChildPath "FakeLoadingBar.ps1";
. $FakeLoaingBarScriptPath

# Configure Windows
Write-Host "Beginne mit der Konfiguration der Apps..."

Write-Host "Konfiguriere Windows Terminal"
Show-LoadingBar

Write-Host "Konfiguration der Apps abgeschlossen."