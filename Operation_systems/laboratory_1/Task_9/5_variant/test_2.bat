@echo off
setlocal enabledelayedexpansion

rem Проверка наличия файла Numb.txt в указанном каталоге
set "directory=%~1"
set "file=%directory%\Numb.txt"

if not exist "%file%" (
    echo Файл Numb.txt не найден в каталоге: %directory%
    exit /b
)

rem Инициализация переменной для хранения простых чисел
set "primes="

rem Чтение целых чисел из файла
for /f "usebackq delims=" %%i in ("%file%") do (
    set "num=%%i"
    rem Проверка, что число не превышает 2500
    if !num! lss 2501 (
        set "is_prime=1"
        rem Проверка на простоту
        if !num! lss 2 (
            set "is_prime=0"
        ) else (
            for /l %%j in (2,1,!num!) do (
                if %%j lss !num! (
                    set /a "mod=!num! %% %%j"
                    if !mod! == 0 (
                        set "is_prime=0"
                        goto :next
                    )
                )
            )
        )
        :next
        if !is_prime! == 1 (
            set "primes=!primes! !num!"
        )
    )
)

rem Вывод результатов
if defined primes (
    echo Простые числа из файла Numb.txt:
    echo !primes!
) else (
    echo Простых чисел не найдено.
)

endlocal
