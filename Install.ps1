# Description: Hauptskript für die Installation von Dotfiles und Apps
# Author: Philippe Steinbach

$ScriptVersion = "0.0.1"
$GitHubRepositoryAuthor = "PhilippeSteinbach"
$GitHubRepositoryName = "Windows-11-Dotfiles"

$DotfilesExists = $false;
$NewDotfilesVersionExists = $false;

# Pfade
$DotfilesFolder = Join-Path -Path $HOME -ChildPath ".dotfiles";
$DotfilesSourcesFolder = Join-Path -Path $PSScriptRoot -ChildPath "src";
$HelperPath = Join-Path -Path $DotfilesSourcesFolder -ChildPath "Helper";

$CopyDotfilesScriptPath = Join-Path -Path $HelperPath -ChildPath "CopyDotfiles.ps1";
. $CopyDotfilesScriptPath

$InstallAppsPath = Join-Path -Path $DotfilesSourcesFolder -ChildPath "Apps";
$ConfigureAppsPath = Join-Path -Path $DotfilesSourcesFolder -ChildPath "Configs";
$ConfigureWindowsPath = Join-Path -Path $DotfilesSourcesFolder -ChildPath "Windows";

# Auswahl anzeigen
Write-Host "Wähle eine Option:"
Write-Host "1: Installieren"
Write-Host "2: Dotfiles Update (prüfe ob dotfiles aktuell sind)"
$Auswahl = Read-Host "Bitte geben Sie die Nummer der gewünschten Aktion ein"

switch ($Auswahl) {
    "i"{
        # Installationslogik

        # Kopiere Dotfiles in das Home-Verzeichnis
        $DotfilesCopySuccess = Copy-Dotfiles -SourceFolder $PSScriptRoot -DotfilesFolder $DotfilesFolder
        if ($DotfilesCopySuccess -eq $true) {
            $DotfilesExists = $true
        } else {
            Write-Host "Das Skript wurde abgebrochen."
            exit
        }

        # Installiere Apps
        Invoke-Expression -Command "$InstallAppsPath\InstallApps.ps1"

        # Konfiguriere Apps
        Invoke-Expression -Command "$ConfigureAppsPath\ApplyAppConfigs.ps1"

        # Konfiguriere Windows
        Invoke-Expression -Command "$ConfigureWindowsPath\ConfigureWindows.ps1"
    }
    "u" {
        # Update-Logik
        Write-Host "Überprüfe, ob aktuelle Dotfiles vorhanden sind..."
        # Todo: Abgleich mit Git-Repository
    }
    default {
        Write-Host "Ungültige Eingabe. Bitte starten Sie das Skript neu und wählen Sie eine gültige Option."
        exit
    }
}
