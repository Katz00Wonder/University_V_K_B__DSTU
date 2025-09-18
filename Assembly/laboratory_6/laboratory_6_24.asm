.model small
.stack 100h

.data
    ; Сообщения
    msg_input db 'Enter decimal number: $'
    msg_binary db 0Dh, 0Ah, 'Binary: $'
    msg_error db 0Dh, 0Ah, 'Error: Not a valid number!$'
    msg_newline db 0Dh, 0Ah, '$'
    
    ; Буфер для ввода
    buffer db 7          ; Максимальная длина (5 цифр + Enter)
    len db ?            ; Фактическая длина
    number_str db 6 dup('$') ; Строка с числом
    
    ; Переменные
    number dw 0          ; Преобразованное число
    is_valid db 1        ; Флаг валидности

.code
main proc
    mov ax, @data
    mov ds, ax
    
    ; Вывод приглашения
    mov ah, 09h
    lea dx, msg_input
    int 21h
    
    ; Ввод строки
    mov ah, 0Ah
    lea dx, buffer
    int 21h
    
    ; Преобразование строки в число
    call string_to_number
    
    ; Проверка валидности
    cmp is_valid, 0
    je show_error
    
    ; Вывод результата
    mov ah, 09h
    lea dx, msg_binary
    int 21h
    
    ; Преобразование числа в двоичную систему и вывод
    mov ax, number
    call print_binary
    
    jmp exit_program
    
show_error:
    mov ah, 09h
    lea dx, msg_error
    int 21h
    
exit_program:
    ; Завершение программы
    mov ax, 4C00h
    int 21h
main endp

; ПОДПРОГРАММА: Преобразование строки в число
; Вход: number_str - строка с цифрами
; Выход: number - преобразованное число, is_valid - флаг валидности
string_to_number proc
    push ax
    push bx
    push cx
    push dx
    push si
    
    mov is_valid, 1     ; Предполагаем, что число валидно
    mov number, 0       ; Обнуляем число
    
    mov cl, len         ; Длина строки
    mov ch, 0
    cmp cl, 0           ; Проверка пустой строки
    je invalid_number
    
    mov si, offset number_str ; Указатель на строку
    
    ; Проверка каждого символа
    mov bx, 10          ; Множитель для десятичной системы
    
convert_loop:
    mov al, [si]        ; Загружаем символ
    
    ; Проверяем, является ли символ цифрой
    cmp al, '0'
    jb invalid_number
    cmp al, '9'
    ja invalid_number
    
    ; Преобразуем символ в цифру
    sub al, '0'
    mov ah, 0
    
    ; Умножаем текущее число на 10 и добавляем новую цифру
    mov dx, number
    mov cx, ax          ; Сохраняем новую цифру
    
    mov ax, dx          ; Текущее число в AX
    mul bx              ; Умножаем на 10
    jc invalid_number   ; Проверка переполнения
    
    add ax, cx          ; Добавляем новую цифру
    jc invalid_number   ; Проверка переполнения
    
    mov number, ax      ; Сохраняем результат
    
    inc si              ; Следующий символ
    loop convert_loop
    
    jmp conversion_done
    
invalid_number:
    mov is_valid, 0     ; Устанавливаем флаг ошибки
    
conversion_done:
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
string_to_number endp

; ПОДПРОГРАММА: Преобразование числа в двоичную систему и вывод
; Вход: AX - число для преобразования
print_binary proc
    push ax
    push bx
    push cx
    push dx
    
    mov bx, ax          ; Сохраняем число
    mov cx, 16          ; 16 битов для вывода
    
    ; Пропускаем ведущие нули
    mov ah, 02h         ; Функция вывода символа
    
skip_leading_zeros:
    test bx, 8000h      ; Проверяем старший бит
    jnz start_print     ; Если не ноль, начинаем вывод
    shl bx, 1           ; Сдвигаем влево
    loop skip_leading_zeros
    
    ; Если все биты нулевые, выводим "0"
    mov dl, '0'
    int 21h
    jmp binary_done
    
start_print:
    ; Вывод битов
print_bits:
    mov dl, '0'         ; Предполагаем '0'
    test bx, 8000h      ; Проверяем старший бит
    jz print_zero
    mov dl, '1'         ; Если бит установлен
    
print_zero:
    int 21h             ; Выводим бит
    shl bx, 1           ; Сдвигаем влево для следующего бита
    loop print_bits
    
binary_done:
    pop dx
    pop cx
    pop bx
    pop ax
    ret
print_binary endp

end main