# Получаем сведения о ЦП компьютера
$cpuInfo = Get-WmiObject -Class Win32_Processor

# Выводим сведения на экран
Write-Host "CPU Name: $($cpuInfo.Name)"
Write-Host "Number of Cores: $($cpuInfo.NumberOfCores)"
Write-Host "Number of Logical Processors: $($cpuInfo.NumberOfLogicalProcessors)"
Write-Host "Max Clock Speed: $($cpuInfo.MaxClockSpeed) MHz"
Write-Host "Current Clock Speed: $($cpuInfo.CurrentClockSpeed) MHz"
