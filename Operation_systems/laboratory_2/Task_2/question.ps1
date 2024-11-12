
# Получаем текущий каталог
$currentDirectory = Get-Location

# Получаем все подкаталоги в каталоге Windows, заканчивающиеся на 'S' или 'T'
$directories = Get-ChildItem -Path 'C:\Windows' -Directory | Where-Object { $_.Name -like '*[ST]' } | Sort-Object Name

# Выводим результат на консоль
Write-Output $directories

# Выводим сообщение на консоль
Write-Host "Saving results to file..."

# Выводим в текстовый файл в текущем каталоге
$directories | Format-Table FullName, Name, LastWriteTime | Out-File -FilePath "$currentDirectory\WindowsDirectories.txt"
