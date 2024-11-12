# Получаем список процессов с id > 100
$processes = Get-Process | Where-Object { $_.Id -gt 100 }

# Сортируем процессы по значению параметра "TotalProcessorTime"
$sortedProcesses = $processes | Sort-Object TotalProcessorTime

# Создаем HTML-таблицу с заданными параметрами
$htmlTable = $sortedProcesses | ConvertTo-Html -Property Id, Name, TotalProcessorTime

# Сохраняем HTML-таблицу в файл
$htmlTable | Out-File -FilePath "ProcessList.html"
