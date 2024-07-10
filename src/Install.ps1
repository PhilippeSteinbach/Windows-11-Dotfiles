# Description: Hauptskript für die Installation von Dotfiles und Apps
# Author: Philippe Steinbach

$ScriptVersion = "0.0.2"

# Initialisiere Umgebungsvariablen
$DotfilesFolder = Join-Path -Path $HOME -ChildPath ".dotfiles"
$GitHubRepositoryAuthor = "PhilippeSteinbach"
$GitHubRepositoryName = "Windows-11-Dotfiles"

$InitScriptPath = Join-Path -Path $DotfilesFolder -ChildPath "${GitHubRepositoryName}-main" | Join-Path -ChildPath ".\src\Helper\Initialize-DotfilesEnvironment.ps1"
. $InitScriptPath
$envVars = Initialize-DotfilesEnvironment

# Pfade
$DotfilesFolder = $envVars.DotfilesFolder
$DotfilesExists = $envVars.DotfilesExists
$DotfilesWorkFolder = $envVars.DotfilesWorkFolder
$DotfilesConfigFile = $envVars.DotfilesConfigFile
$DotfilesHelpersFolder = $envVars.DotfilesHelpersFolder
$MainFolderPath = $envVars.MainFolderPath

# Lade Hilfsfunktionen
Write-Host "Lade Hilfsfunktionen..." -ForegroundColor "Green";
$DotfilesHelpers = Get-ChildItem -Path "${DotfilesHelpersFolder}\*" -Include *.ps1 -Recurse;
foreach ($DotfilesHelper in $DotfilesHelpers) {
    . $DotfilesHelper;
};


$InstallAppsPath = Join-Path -Path $DotfilesWorkFolder -ChildPath "Apps";
$ConfigureWindowsPath = Join-Path -Path $DotfilesWorkFolder -ChildPath "Windows";

# Auswahl anzeigen
Write-Host "Wähle eine Option:"
Write-Host "1: Installieren"
Write-Host "2: Dotfiles Update (prüfe ob dotfiles aktuell sind)"
Write-Host "3: Abbrechen"
$Selection = Read-Host "Bitte geben Sie die Nummer der gewünschten Aktion ein"

switch ($Selection) {
    "1" {
        # Installationslogik
        
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


        # Speichere Konfiguration
        Set-Configuration-File -DotfilesConfigFile $DotfilesConfigFile -ComputerName $ComputerName -GitUserName $GitUserName -GitUserEmail $GitUserEmail -WorkspaceDisk $WorkspaceDisk;

        # Laden der Konfiguration
        $Config = Get-Configuration-File -DotfilesConfigFile $DotfilesConfigFile;

        # Installiere Apps
        Invoke-Expression -Command "$InstallAppsPath\InstallApps.ps1"

        # Konfiguriere Windows
        Invoke-Expression -Command "$ConfigureWindowsPath\ConfigureWindows.ps1"
    }
    "2" {
        # Update-Logik
        Write-Host "Überprüfe, ob aktuelle Dotfiles vorhanden sind..."
        
        if ($DotfilesExists -eq $true) {
            Update-Dotfiles -GitHubRepositoryAuthor $GitHubRepositoryAuthor -GitHubRepositoryName $GitHubRepositoryName -DestinationPath $PSScriptRoot
        }
        else {
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
