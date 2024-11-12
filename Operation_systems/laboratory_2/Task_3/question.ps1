# Получаем список процессов
$processes = Get-Process

# Выводим список свойств процесса в текстовый файл
$processes | Format-List * | Out-File -FilePath "Svoistva_proccesa.txt"

# Выводим общее количество процессов на экран
Write-Host "Total number of processes: $($processes.Count)"
