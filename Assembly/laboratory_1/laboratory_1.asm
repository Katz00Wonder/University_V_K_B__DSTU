; Объявление переменных A, B, C и X
section .data
    prompt_a: db "Enter value for A: ", 0xa
    prompt_b: db "Enter value for B: ", 0xa
    prompt_c: db "Enter value for C: ", 0xa
    newline: db 0xa

section .bss
    a: resd 1
    b: resd 1
    c: resd 1
    result: resd 1

section .text
    global _start
_start:
    ; Вывод приглашения для ввода значения A
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt_a
    mov edx, 12
    int 80h

    ; Чтение значения A
    mov eax, 3
    mov ebx, 0
    mov ecx, a
    mov edx, 4
    int 80h

    ; Вывод приглашения для ввода значения B
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt_b
    mov edx, 12
    int 80h

    ; Чтение значения B
    mov eax, 3
    mov ebx, 0
    mov ecx, b
    mov edx, 4
    int 80h

    ; Вывод приглашения для ввода значения C
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt_c
    mov edx, 12
    int 80h

    ; Чтение значения C
    mov eax, 3
    mov ebx, 0
    mov ecx, c
    mov edx, 4
    int 80h

    ; Загрузка адреса переменной X в регистр
    lea ecx, [result]

    ; Вычисление результата
    mov eax, [a]
    mov ebx, [b]
    mov ecx, [c]
    imul ebx, 4
    sub eax, ebx
    imul eax, 3
    cdq
    idiv ecx
    mov [ecx], eax

    ; Вывод результата
    mov eax, 4
    mov ebx, 1
    mov edx, 4
    int 80h

    ; Завершение программы
    mov eax, 1
    mov ebx, 0
    int 80h