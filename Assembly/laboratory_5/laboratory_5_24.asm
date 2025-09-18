.model small
.stack 100h

.data
    ; Сообщения
    msg_input db 'Enter a string: $'
    msg_output db 0Dh, 0Ah, 'Cryptogram: $'
    msg_space db ' $'
    msg_newline db 0Dh, 0Ah, '$'
    
    ; Буфер для ввода строки
    buffer db 100        ; Максимальная длина
    len db ?            ; Фактическая длина
    string db 100 dup('$') ; Сама строка

.code
main proc
    mov ax, @data
    mov ds, ax
    mov es, ax          ; Для работы со строками
    
    ; Вывод приглашения к вводу
    mov ah, 09h
    lea dx, msg_input
    int 21h
    
    ; Ввод строки с клавиатуры
    mov ah, 0Ah
    lea dx, buffer
    int 21h
    
    ; Вывод заголовка результата
    mov ah, 09h
    lea dx, msg_output
    int 21h
    
    ; Обработка строки
    mov cl, len         ; Длина строки
    mov ch, 0
    mov si, offset string ; Указатель на строку
    
    cmp cl, 0           ; Проверка пустой строки
    je exit_program
    
process_loop:
    mov al, [si]        ; Загружаем символ
    
    ; Проверяем, является ли символ буквой
    call is_letter
    jc convert_letter   ; Если буква, преобразуем
    
    ; Если не буква, выводим как есть
    mov dl, al
    mov ah, 02h
    int 21h
    
    ; Вывод пробела после символа
    mov ah, 09h
    lea dx, msg_space
    int 21h
    
    jmp next_char
    
convert_letter:
    ; Преобразуем букву в число
    call letter_to_number
    
    ; Вывод числа
    call print_number
    
    ; Вывод пробела после числа
    mov ah, 09h
    lea dx, msg_space
    int 21h
    
next_char:
    inc si              ; Следующий символ
    loop process_loop
    
exit_program:
    ; Завершение программы
    mov ax, 4C00h
    int 21h
main endp

; Процедура проверки, является ли символ буквой
; Вход: AL - символ
; Выход: CF = 1 если буква, CF = 0 если не буква
is_letter proc
    ; Проверка на заглавные буквы (A-Z)
    cmp al, 'A'
    jb not_letter
    cmp al, 'Z'
    jbe is_letter_true
    
    ; Проверка на строчные буквы (a-z)
    cmp al, 'a'
    jb not_letter
    cmp al, 'z'
    ja not_letter
    
is_letter_true:
    stc                 ; Устанавливаем флаг переноса
    ret
    
not_letter:
    clc                 ; Сбрасываем флаг переноса
    ret
is_letter endp

; Процедура преобразования буквы в число
; A=1, B=2, ..., Z=26
; Вход: AL - буква
; Выход: AL - число
letter_to_number proc
    push bx
    
    ; Приводим к верхнему регистру, если нужно
    cmp al, 'a'
    jb already_upper
    cmp al, 'z'
    ja already_upper
    sub al, 32          ; Преобразуем в верхний регистр
    
already_upper:
    ; Преобразуем A=1, B=2, ..., Z=26
    sub al, 'A' - 1     ; A становится 1, B становится 2, etc.
    
    pop bx
    ret
letter_to_number endp

; Процедура для вывода числа (0-255)
; Вход: AL - число
print_number proc
    push ax
    push bx
    push cx
    push dx
    
    mov bl, 10          ; Основание системы счисления
    xor cx, cx          ; Счетчик цифр
    
    ; Для чисел больше 9 нужно выводить две цифры
    cmp al, 9
    jbe single_digit
    
    ; Преобразование двухзначного числа
    xor ah, ah
convert_loop:
    xor ah, ah
    div bl              ; Делим AL на 10
    mov dl, ah          ; Остаток в DL
    push dx             ; Сохраняем цифру
    inc cx              ; Увеличиваем счетчик цифр
    test al, al
    jnz convert_loop
    
    jmp print_digits
    
single_digit:
    ; Однозначное число
    mov dl, al
    push dx
    inc cx
    
print_digits:
    ; Вывод цифр
    pop dx              ; Извлекаем цифру
    add dl, '0'         ; Преобразуем в символ
    mov ah, 02h         ; Вывод символа
    int 21h
    loop print_digits
    
    pop dx
    pop cx
    pop bx
    pop ax
    ret
print_number endp

end main