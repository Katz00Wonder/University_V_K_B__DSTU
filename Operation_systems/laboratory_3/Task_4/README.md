Изменить текущее значение политики запуска PowerShell скриптов – разрешить запуск локальных скриптов, определить область применения политики (выбрать любую), проверить текущие настройки ExecutionPolicy для всех областей. Настроить политику исполнения скриптов PowerShell, разрешив запуск только подписанных скриптов.


Для начала мы должны разрешить запуск локальных скриптов и определить область применения. С этой целью мы изменяем политику на RemoteSigned (разрешает запуск локальных скриптов без подписи)
Ниже представлены значения политики выполнения скриптов PowerShell

    Resreicted - Запрещает выполнение всех скриптов
    AllSigned - Разрешает выполнение только подписанных скриптов
    RemoteSigned - Разрешает выполнение локальных скриптов без подписи, но требует подписи для скриптов, полученных из сети
    Unrestricted - Разрешает выполнение всех скриптов
    Bypass - Игнорирует политику выполнения

Ниже представлены области видимости

    MachinePolicy - Применяется к всем пользователям на компьютере
    UserPolicy - Применяется только к текущему пользователю
    Process - Применяется только к текущему процессу PowerShell
    CurrentUser - Применяется только к текущему пользователю
    LocalMachine - Применяется к всем пользователям на компьютере

Выполните команду, которая представлена ниже

Set-ExecutionPolicy RemoteSigned -Scope Process

Проверяем текущие настройки ExecutionPolicy для всех областей

Get-ExecutionPolicy -List

2. Настроить политику на запуск только подписанных скриптов
Изменяем политику на AllSigned (разрешает запуск только подписанных скриптов)

Set-ExecutionPolicy  AllSigned -Scope Process
