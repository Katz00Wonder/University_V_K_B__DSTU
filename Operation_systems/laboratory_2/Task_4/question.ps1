# Получаем список процессов с id > 100
$processes = Get-Process | Where-Object { $_.Id -gt 100 }

# Сортируем процессы по значению параметра "TotalProcessorTime"
$sortedProcesses = $processes | Sort-Object Id

# Выводим список процессов с заданными параметрами в текстовый файл
$sortedProcesses | Format-Table Id, Name, TotalProcessorTime | Out-File -FilePath "ProcessList.txt"
