section .data
    array db 2, -5, 7, -3, 4, -3, 9, -8, 1, -6
    array_len equ $ - array

    msg db "Array values: ", 0xA ; строка для вывода значений массива
    msg_len equ $ - msg
    newline db 0xA ; символ новой строки

section .text
    global _start

_start:
    mov rsi, 0 ; счетчик элементов массива

convert_loop:
    cmp rsi, 10 ; проверка, достигли ли конца массива
    jge convert_end
    mov al, [array + rsi] ; загрузка текущего элемента массива
    test al, 80h ; проверка, является ли число отрицательным
    jz not_negative_convert

    neg al ; замена отрицательного числа его модулем
    mov [array + rsi], al ; сохраняем результат обратно в массив

not_negative_convert:
    inc rsi ; увеличиваем счетчик
    jmp convert_loop

convert_end:
    ; Вывод строкового сообщения "Array values: " на терминал
    mov rdi, 1 ; file descriptor для STDOUT
    mov rsi, msg ; указатель на строку для вывода
    mov rdx, msg_len ; длина строки
    mov rax, 1 ; вызов системного вызова write
    syscall

    ; Вывод значений массива как ASCII-символов в одну строку на терминал
    mov rsi, array ; указатель на массив для вывода
    mov rdx, array_len ; длина массива

print_loop:
    mov al, byte [rsi] ; загрузка текущего элемента массива
    add al, '0' ; преобразование числа в ASCII-символ
    mov [rsp], al ; сохранение символа на стеке
    mov rsi, rsp ; указатель на символ
    mov rax, 1 ; вызов системного вызова write
    mov rdx, 1 ; длина символа
    syscall

    inc rsi ; переход к следующему элементу массива
    dec rdx ; уменьшение счетчика символов
    cmp rdx, 0 ; проверка, достигли ли конца массива
    jg print_loop

    ; Вывод символа новой строки
    mov rsi, newline ; указатель на символ новой строки
    mov rdx, 1 ; длина символа новой строки
    syscall

    ; Завершение программы
    mov rax, 60 ; системный вызов для завершения программы
    xor rdi, rdi ; код завершения 0
    syscall