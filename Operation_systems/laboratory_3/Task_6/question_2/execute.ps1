                                                                                                                             # Параметры задачи
$taskName = "RunPowerShellScriptAtSpecificTime"
$taskDescription = "This task runs a PowerShell script at a specific time."
$taskAction = "powershell.exe"
$taskArguments = "-File C:\ProjectinProgramming\University_V_K_B__DSTU\Operation_systems\laboratory_3\Task_6\question_2\hello.ps1"
$taskTriggerTime = "2024-10-30T16:45:00"  # Укажите время запуска задачи

# Создание новой задачи
$action = New-ScheduledTaskAction -Execute $taskAction -Argument $taskArguments
$trigger = New-ScheduledTaskTrigger -Once -At $taskTriggerTime
$principal = New-ScheduledTaskPrincipal -UserId "SYSTEM" -LogonType ServiceAccount -RunLevel Highest
$settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries

# Регистрация задачи
Register-ScheduledTask -TaskName $taskName -Description $taskDescription -Action $action -Trigger $trigger -Principal $principal -Settings $settings

# Экспорт задачи в XML-файл
$taskPath = "C:\Windows\System32\Tasks\$taskName"
$xmlFilePath = "C:\ProjectinProgramming\University_V_K_B__DSTU\Operation_systems\laboratory_3\Task_6\question_2\ExportedTask.xml"
schtasks /query /tn $taskName /xml > $xmlFilePath
