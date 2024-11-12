# Запускаем командлет dir 10 раз и замеряем время выполнения
$dirTimes = for ($i = 1; $i -le 10; $i++) {
    Measure-Command { dir }
}

# Запускаем командлет ps 10 раз и замеряем время выполнения
$psTimes = for ($i = 1; $i -le 10; $i++) {
    Measure-Command { ps }
}

# Вычисляем максимальное, минимальное и среднее значение времени выполнения командлетов dir
$dirMaxTime = ($dirTimes | Measure-Object -Property TotalSeconds -Maximum).Maximum
$dirMinTime = ($dirTimes | Measure-Object -Property TotalSeconds -Minimum).Minimum
$dirAvgTime = ($dirTimes | Measure-Object -Property TotalSeconds -Average).Average

# Вычисляем максимальное, минимальное и среднее значение времени выполнения командлетов ps
$psMaxTime = ($psTimes | Measure-Object -Property TotalSeconds -Maximum).Maximum
$psMinTime = ($psTimes | Measure-Object -Property TotalSeconds -Minimum).Minimum
$psAvgTime = ($psTimes | Measure-Object -Property TotalSeconds -Average).Average

# Выводим результаты на экран
Write-Host "dir:"
Write-Host "Max Time: $($dirMaxTime) seconds"
Write-Host "Min Time: $($dirMinTime) seconds"
Write-Host "Avg Time: $($dirAvgTime) seconds"
Write-Host ""
Write-Host "ps:"
Write-Host "Max Time: $($psMaxTime) seconds"
Write-Host "Min Time: $($psMinTime) seconds"
Write-Host "Avg Time: $($psAvgTime) seconds"
