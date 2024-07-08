function Set-Configuration-File {
    [CmdletBinding()]
    param(
        [Parameter( Position = 0, Mandatory = $TRUE)]
        [String]
        $DotfilesConfigFile,

        [Parameter( Position = 1, Mandatory = $TRUE)]
        [String]
        $ComputerName,
    
        [Parameter( Position = 2, Mandatory = $TRUE)]
        [String]
        $GitUserName,
    
        [Parameter( Position = 3, Mandatory = $TRUE)]
        [String]
        $GitUserEmail,

        [Parameter( Position = 4, Mandatory = $TRUE)]
        [String]
        $WorkspaceDisk
    )

    $Config = @{
        ComputerName  = $ComputerName;
        GitUserName   = $GitUserName;
        GitUserEmail  = $GitUserEmail;
        WorkspaceDisk = $WorkspaceDisk;
    }

    try {
        if (-not (Test-Path -Path $DotfilesConfigFile)) {
            Write-Host "Erstelle Dotfiles-Konfigurationsdatei..." -ForegroundColor "Green";
    
            $Config | ConvertTo-Json | Set-Content -Path $DotfilesConfigFile;
    
            Write-Host "Dotfiles-Konfigurationsdatei wurde erstellt." -ForegroundColor "Green";
        }
    }
    catch {
        Write-Error "Failed to read or parse the configuration file: $_"
    }
}

function Get-Configuration-File {
    [CmdletBinding()]
    param(
        [Parameter( Position = 0, Mandatory = $TRUE)]
        [String]
        $DotfilesConfigFile
    )

    try {
        $Config = @{};
        $ConfigContent = Get-Content -Path $DotfilesConfigFile -Raw | ConvertFrom-Json;

        Write-Host "Lese Dotfiles-Konfigurationsdatei..." -ForegroundColor "Green";

        foreach ($Property in $ConfigContent.PSObject.Properties) {
            $Config[$Property.Name] = $Property.Value;
        }

        Write-Host "config.json enthält folgende Werte:" -ForegroundColor "Green";
        Write-Host -ForegroundColor "Green" ($Config | Format-List | Out-String);

        return $Config;
    }
    catch {
        Write-Error "Failed to read or parse the configuration file: $_"
    }
}