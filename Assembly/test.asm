section .data
    msg db 'Hello, world!', 0 ; Строка

section .text
    global _start ; Глобальный символ, точка входа

_start: ; Метка начала программы
    ; Вывод строки
    mov eax, 4 ; Системный вызов печати в stdout
    mov ebx, 1 ; Дескриптор файла (stdout)
    mov ecx, msg ; Указатель на строку
    mov edx, 13 ; Длина строки
    int 0x80 ; Вызов системного прерывания

    ; Завершение программы
    mov eax, 1 ; Системный вызов завершения программы
    int 0x80
