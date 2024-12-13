section .data
    array db 0b00000101, 0b00000010, 0b00000011  ; Пример данных (3 байта)
    mask db 0b00000101  ; Маска 101
    result db 0         ; Результат операции XOR
    msg db "Result: ", 0  ; Сообщение для вывода
    msg_len equ $ - msg  ; Длина сообщения
    buffer db '0', 0     ; Буфер для десятичного результата

section .text
    global _start

_start:
    ; Инициализация результата
    mov byte [result], 0

    ; Цикл по 3 байтам
    mov ecx, 3  ; Количество байт
    mov esi, array  ; Указатель на массив

.loop:
    ; Загружаем текущее слово (3 бита) из массива
    mov al, [esi]  ; Загружаем байт из массива
    ; Применяем маску и выполняем XOR
    and al, 0b00000111  ; Оставляем только 3 младших бита
    xor al, [mask]  ; Выполняем XOR с маской
    ; Сохраняем результат
    xor [result], al  ; Обновляем результат

    ; Переход к следующему слову
    inc esi  ; Переход к следующему байту
    loop .loop  ; Повторяем, пока не обработаем все 3 байта

    ; Преобразуем результат в строку
    mov al, [result]  ; Загружаем результат
    add al, '0'       ; Преобразуем в символ (ASCII)
    mov [buffer], al  ; Сохраняем в буфер

    ; Выводим сообщение
    mov rax, 1          ; syscall: write
    mov rdi, 1          ; файл: stdout
    mov rsi, msg        ; указатель на сообщение
    mov rdx, msg_len    ; длина сообщения
    syscall

    ; Выводим результат
    mov rax, 1          ; syscall: write
    mov rdi, 1          ; файл: stdout
    mov rsi, buffer     ; указатель на буфер
    mov rdx, 1          ; длина результата (1 байт)
    syscall

    ; Завершение программы
    mov eax, 60         ; syscall: exit
    xor edi, edi        ; статус 0
    syscall
