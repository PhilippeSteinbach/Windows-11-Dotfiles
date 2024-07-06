function Show-LoadingBar {
	param (
		[int]$MinSeconds = 1,
		[int]$MaxSeconds = 3
	)

	# Zufällige Wartezeit generieren
	$random = Get-Random -Minimum $MinSeconds -Maximum ($MaxSeconds + 1)
	$startTime = Get-Date

	# Gesamtanzahl der Ticks (100ms Intervalle)
	$totalTicks = $random * 10
	$currentTick = 0

	while ($currentTick -le $totalTicks) {
		# Prozentuale Berechnung
		$percentComplete = ($currentTick / $totalTicks) * 100

		# Fortschrittsbalken anzeigen
		Write-Progress -Activity "Ladevorgang" -Status "$percentComplete% abgeschlossen" -PercentComplete $percentComplete

		# Warte 100ms
		Start-Sleep -Milliseconds 100
		$currentTick++
	}

	# Abschluss des Ladebalkens sicherstellen
	Write-Progress -Activity "Ladevorgang" -Status "Abgeschlossen" -Completed
	$elapsedTime = (New-TimeSpan -Start $startTime).Seconds
	Write-Host "Ladevorgang abgeschlossen - Zeit: $elapsedTime Sekunden" -ForegroundColor Green
}