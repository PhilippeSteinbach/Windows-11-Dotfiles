$DotfilesFolder = Join-Path -Path $HOME -ChildPath ".dotfiles";
$FakeLoaingBarScriptPath = Join-Path -Path $HelperPath -ChildPath "FakeLoadingBar.ps1";
. $FakeLoaingBarScriptPath

# Install choco
Write-Host "Installiere Chocolatey..."
Show-LoadingBar

# Install apps
Write-Host "Installiere Apps..."
Show-LoadingBar

Write-Host "Es wurden alle Apps installiert."