# Description: Hauptskript für die Installation von Dotfiles und Apps
# Author: Philippe Steinbach

$ScriptVersion = "0.0.1"
$GitHubRepositoryAuthor = "PhilippeSteinbach"
$GitHubRepositoryName = "Windows-11-Dotfiles"

# Pfade
$DotfilesFolder = Join-Path -Path $HOME -ChildPath ".dotfiles";
$DotfilesExists = Test-Path -Path $DotfilesFolder;
$DotfilesWorkFolder = Join-Path -Path $DotfilesFolder -ChildPath "${GitHubRepositoryName}-main" | Join-Path -ChildPath "src" 
$HelperPath = Join-Path -Path $DotfilesWorkFolder -ChildPath "Helper";

. Join-Path -Path $HelperPath -ChildPath "CopyDotfiles.ps1";
. Join-Path -Path $HelperPath -ChildPath "UpdateDotfiles.ps1";

$InstallAppsPath = Join-Path -Path $DotfilesWorkFolder -ChildPath "Apps";
$ConfigureAppsPath = Join-Path -Path $DotfilesWorkFolder -ChildPath "Configs";
$ConfigureWindowsPath = Join-Path -Path $DotfilesWorkFolder -ChildPath "Windows";

# Auswahl anzeigen
Write-Host "Wähle eine Option:"
Write-Host "1: Installieren"
Write-Host "2: Dotfiles Update (prüfe ob dotfiles aktuell sind)"
Write-Host "3: Abbrechen"
$Selection = Read-Host "Bitte geben Sie die Nummer der gewünschten Aktion ein"

switch ($Selection) {
    "1"{
        # Installationslogik

        # Installiere Apps
        Invoke-Expression -Command "$InstallAppsPath\InstallApps.ps1"

        # Konfiguriere Apps
        Invoke-Expression -Command "$ConfigureAppsPath\ApplyAppConfigs.ps1"

        # Konfiguriere Windows
        Invoke-Expression -Command "$ConfigureWindowsPath\ConfigureWindows.ps1"
    }
    "2" {
        # Update-Logik
        Write-Host "Überprüfe, ob aktuelle Dotfiles vorhanden sind..."
        
        if ($DotfilesExists -eq $true) {
            Update-Dotfiles -GitHubRepositoryAuthor $GitHubRepositoryAuthor -GitHubRepositoryName $GitHubRepositoryName -DestinationPath $PSScriptRoot
        } else {
            Write-Host "Dotfiles sind nicht vorhanden. Bitte installiere sie zuerst."
            exit
        }
        
    }
    "3" {
        # Abbrechen-Logik
        Write-Host "Vorgang durch den Benutzer abgebrochen." -ForegroundColor Red
        exit
    }
    default {
        Write-Host "Ungültige Eingabe. Bitte starte das Skript neu und wähle eine gültige Option."
        exit
    }
}
