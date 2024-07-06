function Copy-Dotfiles {
	param (
		[string]$SourceFolder,
		[string]$DotfilesFolder
	)

	$success = $false

	Write-Host "Kopiere Dotfiles von $($SourceFolder) in $($DotfilesFolder)..."

	try {
		$DotfilesExists = Test-Path -Path $DotfilesFolder
		if ($DotfilesExists -eq $true) {
			$Overwrite = Read-Host "Dotfiles existieren bereits in $($DotfilesFolder). Sollen sie überschrieben werden? (y/n)"
			if ($Overwrite -eq "y") {
				Remove-Item -Path "$($DotfilesFolder)\*" -Recurse -Force
			} else {
				Write-Host "Vorgang abgebrochen."
				return $false
			}
		} 
		Copy-Item -Path "$($SourceFolder)\*" -Destination $DotfilesFolder -Recurse -Force
		Write-Host "Dotfiles wurden erfolgreich von $($SourceFolder) nach $($DotfilesFolder) kopiert/überschrieben."
		$success = $true
	} catch {
		Write-Host "Fehler beim Kopieren der Dotfiles von $($SourceFolder) nach $($DotfilesFolder): $_"
		$success = $false
	}

	return $success
}

