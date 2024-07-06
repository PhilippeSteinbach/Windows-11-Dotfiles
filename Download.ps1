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
    $UserConfirmation = Read-Host "Der Dotfiles-Ordner existiert bereits und ist nicht leer. Möchten Sie ihn überschreiben und fortfahren? (J/N)"
    if ($UserConfirmation -ne 'J') {
      Write-Host "Vorgang durch den Benutzer abgebrochen." -ForegroundColor Red
      exit
    } else {
      Remove-Item -Path $DotfilesFolder -Recurse -Force
      New-Item $DotfilesFolder -ItemType directory
    }
  }
} else {
  New-Item $DotfilesFolder -ItemType directory
}

# Download Dotfiles repository as Zip
Try {
  Invoke-WebRequest -Uri $GitHubRepositoryUri -OutFile $ZipRepositoryFile
  $DownloadResult = $TRUE
}
catch [System.Net.WebException] {
  Write-Host "Fehler beim Herunterladen des Dotfiles-Repositorys" -ForegroundColor Red
}

if ($DownloadResult) {
  Add-Type -AssemblyName System.IO.Compression.FileSystem
  [System.IO.Compression.ZipFile]::ExtractToDirectory($ZipRepositoryFile, $DotfilesFolder)
  Remove-Item -Path $ZipRepositoryFile -Force
  Invoke-Expression (Join-Path -Path $DotfilesWorkFolder -ChildPath "Install.ps1")
}