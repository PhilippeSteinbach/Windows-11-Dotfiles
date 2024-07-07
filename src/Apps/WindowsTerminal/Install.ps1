function Install-WindowsTerminal {
    Write-Host "Installiere Windows Terminal..."
    if (-not (Get-Command wt -ErrorAction SilentlyContinue)) {
        choco install microsoft-windows-terminal -y
    } else {
        Write-Host "Windows Terminal ist bereits installiert."
    }
}

function Set-WindowsTerminalConfiguration {
    Write-Host "Konfiguriere Windows Terminal..."
    $WindowsTerminalSettingsFilePath = Join-Path -Path $env:LOCALAPPDATA -ChildPath "Packages" | Join-Path -ChildPath "Microsoft.WindowsTerminal_8wekyb3d8bbwe" | Join-Path -ChildPath "LocalState" | Join-Path -ChildPath "settings.json"
    $DotfilesWindowsTerminalSettingsFilePath = Join-Path -Path $ConfigureAppsPath -ChildPath "WindowsTerminal\settings.json"
    $WorkspaceFolder = Join-Path -Path $Config.WorkspaceDisk -ChildPath "Workspace";

    Write-Host "Kopiere Windows Terminal Konfigurationsdatei..."

    # Kopiere die Konfigurationsdatei, überschreibe sie wenn sie bereits existiert
    Copy-Item -Path $DotfilesWindowsTerminalSettingsFilePath -Destination $WindowsTerminalSettingsFilePath -Force

    # Setze Startverzeichnisse in der Konfigurationsdatei (Ersetze die Platzhalter)
    $WindowsTerminalSettings = Get-Content -Path $WindowsTerminalSettingsFilePath -Raw | ConvertFrom-Json
    $WindowsTerminalSettings -replace "__STARTING_WINDOWS_DIRECTORY__", ($WorkspaceFolder | ConvertTo-Json) | Set-Content -Path $WindowsTerminalSettingsFilePath;

    $UbuntuStartingDirectory = wsl wslpath -w "~/Workspace";
    $WindowsTerminalSettings -replace "__STARTING_UBUNTU_DIRECTORY__", ($UbuntuStartingDirectory | ConvertTo-Json) | Set-Content -Path $WindowsTerminalSettingsFilePath;

    Write-Host "Windows Terminal wurde erfolgreich konfiguriert." -ForegroundColor "Green"
}

function Open-Close-WindowsTerminal {
    # Öffne und schließe Windows Terminal als Administrator, um das Profil zu laden
    Write-Host "Öffne Windows Terminal..." -ForegroundColor "Green"
    wt new-tab PowerShell -c "Set-ExecutionPolicy Unrestricted;";
    Start-Sleep -Seconds 10;

    Write-Host "Schließe Windows Terminal..." -ForegroundColor "Green"
    Stop-Process -Name "WindowsTerminal" -Force;
}