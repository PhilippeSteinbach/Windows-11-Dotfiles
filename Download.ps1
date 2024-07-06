# Request custom values
$ComputerName = Read-Host -Prompt "Gib deinen Computernamen ein"
$GitUserName = Read-Host -Prompt "Gib deinen Git-Benutzernamen hier ein"
$GitUserEmail = Read-Host -Prompt "Gib deine Git-E-Mail-Adresse hier ein"

$ValidDisks = Get-PSDrive -PSProvider "FileSystem" | Select-Object -ExpandProperty "Root"
do {
  Write-Host "Wähle ein Laufwerk für die Dotfiles-Installation aus:" -ForegroundColor "Green"
  Write-Host $ValidDisks -ForegroundColor "Green"
  $WorkspaceDisk = Read-Host -Prompt "Bitte gib das Laufwerk ein"
}
while (-not ($ValidDisks -Contains $WorkspaceDisk))

# Define paths
$GitHubRepositoryAuthor = "PhilippeSteinbach" 
$GitHubRepositoryName = "Windows-11-Dotfiles" 
$GitHubRepositoryUri = "https://github.com/${GitHubRepositoryAuthor}/${GitHubRepositoryName}/archive/refs/heads/main.zip"

$DotfilesFolder = Join-Path -Path $HOME -ChildPath ".dotfiles"
$ZipRepositoryFile = Join-Path -Path $DotfilesFolder -ChildPath "${GitHubRepositoryName}-main.zip"
$DotfilesWorkFolder = Join-Path -Path $DotfilesFolder -ChildPath "${GitHubRepositoryName}-main" | Join-Path -ChildPath "src"

$DownloadResult = $FALSE

# Check if Dotfiles folder exists and is not empty
if (Test-Path $DotfilesFolder) {
  if ((Get-ChildItem -Path $DotfilesFolder).Count -gt 0) {
    Write-Host "Der Dotfiles-Ordner existiert bereits und ist nicht leer. Wählen Sie eine Option:"
    Write-Host "1: Überschreiben"
    Write-Host "2: Nicht überschreiben und existierendes Install-Skript starten"
    Write-Host "3: Abbrechen"
    $UserSelection = Read-Host "Bitte geben Sie die Nummer Ihrer Wahl ein"

    switch ($UserSelection) {
      "1" {
        Remove-Item -Path $DotfilesFolder -Recurse -Force
        New-Item $DotfilesFolder -ItemType Directory
        # Fortfahren mit dem Download und der Installation
      }
      "2" {
        # Pfad zum existierenden Install-Skript
        $InstallScriptPath = Join-Path -Path $DotfilesWorkFolder -ChildPath "Install.ps1"
        if (Test-Path $InstallScriptPath) {
          Invoke-Expression $InstallScriptPath
        } else {
          Write-Host "Install-Skript nicht gefunden." -ForegroundColor Red
        }
        exit
      }
      "3" {
        Write-Host "Vorgang durch den Benutzer abgebrochen." -ForegroundColor Red
        exit
      }
      default {
        Write-Host "Ungültige Auswahl. Bitte starten Sie das Skript erneut und wählen Sie eine gültige Option." -ForegroundColor Yellow
        exit
      }
    }
  }
} else {
  New-Item $DotfilesFolder -ItemType Directory
}

# Fortsetzung des Skripts für den Fall, dass Option 1 gewählt wurde...
Try {
  Invoke-WebRequest -Uri $GitHubRepositoryUri -OutFile $ZipRepositoryFile
  $DownloadResult = $TRUE
  # Weitere Logik für den Download und die Installation...
} Catch [System.Net.WebException] {
  Write-Host "Fehler beim Herunterladen des Dotfiles-Repositorys" -ForegroundColor Red
} Catch {
  Write-Host "Ein unbekannter Fehler ist aufgetreten" -ForegroundColor Red
}

if ($DownloadResult) {
  Add-Type -AssemblyName System.IO.Compression.FileSystem
  [System.IO.Compression.ZipFile]::ExtractToDirectory($ZipRepositoryFile, $DotfilesFolder)
  Remove-Item -Path $ZipRepositoryFile -Force
  Invoke-Expression (Join-Path -Path $DotfilesWorkFolder -ChildPath "Install.ps1")
}