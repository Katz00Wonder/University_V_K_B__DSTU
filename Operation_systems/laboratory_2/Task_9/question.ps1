$OutputEncoding = [System.Text.Encoding]::UTF8

try {
    # Нахождение имен процессов, выполняющихся в двух или более экземплярах
    $processes = Get-Process -ErrorAction SilentlyContinue
    $duplicateProcesses = $processes | Group-Object -Property Name | Where-Object { $_.Count -gt 1 } | Select-Object -ExpandProperty Name
    Write-Host "Процессы, выполняющиеся в двух или более экземплярах:"
    $duplicateProcesses

    # Нахождение имени процесса, запущенного последним
    $lastProcess = Get-Process -ErrorAction SilentlyContinue | Sort-Object -Property StartTime -Descending | Select-Object -First 1
    Write-Host "Имя процесса, запущенного последним:"
    $lastProcess.Name
} catch {
    Write-Host "Произошла ошибка при выполнении скрипта:"
    Write-Host $_.Exception.Message
}
