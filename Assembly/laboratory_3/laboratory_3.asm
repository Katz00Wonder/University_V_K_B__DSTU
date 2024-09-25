section .data
    array db 0b00000001, 0b00000010, 0b00000011  ; Массив из 3 байт
    mask db 0b101  ; Маска для XOR
    result db 0    ; Переменная для хранения результата

section .text
    global _start

_start:
    ; Инициализация результата
    mov al, 0      ; AL = 0 (начальное значение результата)

    ; Обработка каждого байта в массиве
    mov ecx, 3     ; Количество байт в массиве
    lea rsi, [array] ; Указатель на массив
.loop:
    mov bl, [rsi]  ; Загружаем текущий байт в BL
    xor bl, mask   ; Применяем XOR с маской
    xor al, bl     ; Обновляем результат
    inc rsi        ; Переходим к следующему байту
    loop .loop     ; Повторяем для всех байтов

    ; Сохранение результата
    mov [result], al

    ; Завершение программы
    mov eax, 60    ; syscall: exit
    xor edi, edi   ; статус выхода 0
    syscall
