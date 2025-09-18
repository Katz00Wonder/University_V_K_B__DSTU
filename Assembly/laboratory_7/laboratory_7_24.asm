.model small
.stack 100h

.data
    ; Сообщения для вывода
    msg1 db 'Hello, this is line 1!', 0Dh, 0Ah, '$'
    msg2 db 'Print Screen demo program', 0Dh, 0Ah, '$'
    msg3 db 'Press Print Screen to change colors!', 0Dh, 0Ah, '$'
    msg4 db 'Each press cycles through attributes 1-15', 0Dh, 0Ah, '$'
    msg5 db 'Current attribute: $'
    
    ; Переменные
    old_int5 dd ?       ; Для хранения старого вектора прерывания
    current_attr db 14  ; Текущий атрибут (желтый)
    attr_counter db 1   ; Счетчик для цикла атрибутов

.code
main proc
    mov ax, @data
    mov ds, ax
    
    ; Очистка экрана
    call clear_screen
    
    ; Сохранение старого обработчика Int 5h
    call save_old_interrupt
    
    ; Установка нового обработчика Int 5h
    call set_new_interrupt
    
    ; Вывод текста с начальным атрибутом
    call print_text
    
    ; Бесконечный цикл ожидания
    mov ah, 0
    int 16h             ; Ожидание любой клавиши
    
    ; Восстановление старого обработчика перед выходом
    call restore_interrupt
    
    ; Завершение программы
    mov ax, 4C00h
    int 21h
main endp

; Процедура очистки экрана
clear_screen proc
    mov ax, 0003h       ; Режим 80x25, 16 цветов
    int 10h
    ret
clear_screen endp

; Процедура сохранения старого обработчика Int 5h
save_old_interrupt proc
    push es
    xor ax, ax
    mov es, ax          ; ES = 0 (сегмент векторов прерываний)
    
    ; Сохраняем старый вектор Int 5h
    mov ax, es:[5h * 4]
    mov word ptr old_int5, ax
    mov ax, es:[5h * 4 + 2]
    mov word ptr old_int5 + 2, ax
    
    pop es
    ret
save_old_interrupt endp

; Процедура установки нового обработчика
set_new_interrupt proc
    push ds
    push es
    xor ax, ax
    mov es, ax          ; ES = 0
    
    ; Устанавливаем новый вектор Int 5h
    cli                 ; Запрещаем прерывания
    mov word ptr es:[5h * 4], offset new_int5_handler
    mov es:[5h * 4 + 2], cs
    sti                 ; Разрешаем прерывания
    
    pop es
    pop ds
    ret
set_new_interrupt endp

; Процедура восстановления старого обработчика
restore_interrupt proc
    push ds
    push es
    xor ax, ax
    mov es, ax          ; ES = 0
    
    ; Восстанавливаем старый вектор Int 5h
    cli
    mov ax, word ptr old_int5
    mov es:[5h * 4], ax
    mov ax, word ptr old_int5 + 2
    mov es:[5h * 4 + 2], ax
    sti
    
    pop es
    pop ds
    ret
restore_interrupt endp

; Процедура вывода текста с текущим атрибутом
print_text proc
    ; Установка позиции курсора
    mov ah, 02h
    mov bh, 0           ; Страница 0
    mov dh, 5           ; Строка 5
    mov dl, 10          ; Колонка 10
    int 10h
    
    ; Вывод сообщений с текущим атрибутом
    mov bl, current_attr
    call print_with_attribute
    
    ; Вывод информации о текущем атрибуте
    mov ah, 02h
    mov dh, 15
    mov dl, 10
    int 10h
    
    mov ah, 09h
    lea dx, msg5
    int 21h
    
    ; Вывод номера атрибута
    mov al, current_attr
    call print_number
    
    ret
print_text endp

; Процедура вывода строки с атрибутом
; Вход: DX - адрес строки, BL - атрибут
print_with_attribute proc
    push si
    mov si, dx
    
print_char:
    lodsb               ; Загружаем символ
    cmp al, '$'         ; Конец строки?
    je print_done
    
    ; Вывод символа с атрибутом
    mov ah, 09h
    mov bh, 0           ; Страница 0
    mov cx, 1           ; Количество повторений
    int 10h
    
    ; Перемещение курсора
    mov ah, 03h         ; Получить позицию курсора
    int 10h
    inc dl              ; Следующая колонка
    mov ah, 02h         ; Установить позицию курсора
    int 10h
    
    jmp print_char
    
print_done:
    pop si
    ret
print_with_attribute endp

; Процедура вывода числа (0-255)
print_number proc
    push ax
    push bx
    push cx
    push dx
    
    mov bl, 10
    xor cx, cx
    
convert_loop:
    xor ah, ah
    div bl
    mov dl, ah
    push dx
    inc cx
    test al, al
    jnz convert_loop
    
print_digits:
    pop dx
    add dl, '0'
    mov ah, 02h
    int 21h
    loop print_digits
    
    pop dx
    pop cx
    pop bx
    pop ax
    ret
print_number endp

; НОВЫЙ ОБРАБОТЧИК ПРЕРЫВАНИЯ Int 5h
new_int5_handler proc far
    push ax
    push bx
    push cx
    push dx
    push si
    push di
    push ds
    push es
    
    mov ax, @data
    mov ds, ax
    
    ; Циклическое изменение атрибута (1-15)
    inc attr_counter
    cmp attr_counter, 16
    jb update_attr
    mov attr_counter, 1
    
update_attr:
    mov al, attr_counter
    mov current_attr, al
    
    ; Очистка экрана
    call clear_screen
    
    ; Вывод текста с новым атрибутом
    call print_text
    
    ; Вывод отладочного сообщения (опционально)
    mov ah, 02h
    mov dh, 20
    mov dl, 0
    int 10h
    
    mov ah, 09h
    lea dx, debug_msg
    int 21h
    
    pop es
    pop ds
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    
    iret                ; Возврат из прерывания

debug_msg db 'Print Screen pressed! Attribute changed.', '$'
new_int5_handler endp

; Процедура вывода всех сообщений
print_all_messages proc
    ; Сообщение 1
    mov ah, 02h
    mov dh, 6
    mov dl, 10
    int 10h
    mov dx, offset msg1
    mov bl, current_attr
    call print_with_attribute
    
    ; Сообщение 2
    mov ah, 02h
    mov dh, 7
    mov dl, 10
    int 10h
    mov dx, offset msg2
    call print_with_attribute
    
    ; Сообщение 3
    mov ah, 02h
    mov dh, 8
    mov dl, 10
    int 10h
    mov dx, offset msg3
    call print_with_attribute
    
    ; Сообщение 4
    mov ah, 02h
    mov dh, 9
    mov dl, 10
    int 10h
    mov dx, offset msg4
    call print_with_attribute
    
    ret
print_all_messages endp

end main