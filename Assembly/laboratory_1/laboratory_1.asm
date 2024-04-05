; Объявление переменных A, B, C и X
section .data
    A dd 3
    B dd 2
    C dd 5
    X dd 0

; Размещение памяти для переменной X
section .bss
    resd 1

; Код программы
section .text
    global _start
_start:
    ; Загрузка значений переменных A, B и C
    mov eax, [A]
    mov ebx, [B]
    mov ecx, [C]

    ; Вычисление выражения 3*(A - 4*B)
    imul ebx, 4
    sub eax, ebx
    imul eax, 3

    ; Добавление результата к C/4
    cdq                   ; Установка edx в 0 для корректного деления
    idiv ecx              ; Деление C на 4
    add eax, [X]          ; Прибавление результата к X

    ; Сохранение результата в переменной X
    mov [X], eax

    ; Вывод результата в стандартный вывод (stdout)
    mov eax, 4            ; Системный вызов write
    mov ebx, 1            ; Файл stdout
    mov ecx, X            ; Адрес значения для вывода
    mov edx, 4            ; Количество байт для вывода
    int 0x80

    ; Завершение программы
    mov eax, 1            ; Системный вызов exit
    mov ebx, 0            ; Код возврата
    syscall               ; Вызываем системный сервис для завершения программы