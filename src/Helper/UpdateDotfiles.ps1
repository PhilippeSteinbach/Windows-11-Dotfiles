
function CheckForNewVersion {
    param (
        [string]$GitHubRepositoryAuthor,
        [string]$GitHubRepositoryName
    )

    $GitHubRepositoryUri = "https://github.com/${GitHubRepositoryAuthor}/${GitHubRepositoryName}/archive/refs/heads/main.zip"
    $tempPath = Join-Path -Path $env:TEMP -ChildPath "${GitHubRepositoryName}_main.zip"
    Invoke-WebRequest -Uri $GitHubRepositoryUri -OutFile $tempPath

    # Extract the zip to a temporary directory
    $tempExtractPath = Join-Path -Path $env:TEMP -ChildPath "${GitHubRepositoryName}_extract"
    Expand-Archive -Path $tempPath -DestinationPath $tempExtractPath -Force

    $installScriptPath = Join-Path -Path $tempExtractPath -ChildPath "${GitHubRepositoryName}-main\install.ps1"
    $content = Get-Content -Path $installScriptPath
    $content | Where-Object { $_ -match '\$ScriptVersion = "(.*)"' }
    $latestVersion = $matches[1]

    if ([Version]$latestVersion -gt [Version]$ScriptVersion) {
        $Global:NewDotfilesVersionExists = $true
        Write-Host "A new version ($latestVersion) is available."
    } else {
        $Global:NewDotfilesVersionExists = $false
        Write-Host "You are already using the latest version ($ScriptVersion)."
    }
}

function Update-Dotfiles {
    param (
        [string]$GitHubRepositoryAuthor,
        [string]$GitHubRepositoryName,
        [string]$DestinationPath
    )

    # Call the CheckForNewVersion function
    CheckForNewVersion -GitHubRepositoryAuthor $GitHubRepositoryAuthor -GitHubRepositoryName $GitHubRepositoryName

    if ($Global:NewDotfilesVersionExists -eq $true) {
        $tempPath = Join-Path -Path $env:TEMP -ChildPath "${GitHubRepositoryName}_main.zip"
        $tempExtractPath = Join-Path -Path $env:TEMP -ChildPath "${GitHubRepositoryName}_extract"

        if (-not (Test-Path -Path $tempPath)) {
            $GitHubRepositoryUri = "https://github.com/${GitHubRepositoryAuthor}/${GitHubRepositoryName}/archive/refs/heads/main.zip"
            Invoke-WebRequest -Uri $GitHubRepositoryUri -OutFile $tempPath
            Expand-Archive -Path $tempPath -DestinationPath $tempExtractPath -Force
        }

        $sourceInstallScriptPath = Join-Path -Path $tempExtractPath -ChildPath "${GitHubRepositoryName}-main\install.ps1"
        $destinationInstallScriptPath = Join-Path -Path $DestinationPath -ChildPath "install.ps1"
        Copy-Item -Path $sourceInstallScriptPath -Destination $destinationInstallScriptPath -Force

        Write-Host "Skript auf die neueste Version aktualisiert. Bitte starten Sie das Skript neu, um die neue Version zu verwenden."
    } else {
        Write-Host "Kein Update erforderlich. Sie verwenden bereits die neueste Version."
    }
}

