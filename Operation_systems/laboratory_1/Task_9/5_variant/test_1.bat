@echo off
setlocal enabledelayedexpansion

rem Проверяем, передан ли параметр
if "%~1"=="" (
    echo Укажите путь к каталогу в качестве первого параметра.
    exit /b 1
)

set "directory=%~1"
set "totalSize=0"

rem Проходим по всем файлам с атрибутом system в указанном каталоге
for /f "usebackq tokens=3" %%A in (`dir /s /a:s /-c "%directory%\*" ^| findstr /r "^[0-9]"`) do (
    set /a totalSize+=%%A
)

echo Суммарный объем файлов с атрибутом system в каталоге "%directory%": !totalSize! байт

endlocal
