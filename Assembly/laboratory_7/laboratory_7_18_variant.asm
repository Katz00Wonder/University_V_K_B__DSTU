.model small
.stack 100h
.data
    char db ?
    attr db 1
    row db 0
    col db 0
.code
main proc
    mov ax, @data
    mov ds, ax

    mov ah, 0
    int 16h ; ожидание нажатия клавиши
    mov char, al ; сохранение символа

    cycle:
        mov ah, 0ch ; функция проверки наличия нажатой клавиши без ожидания
        int 21h ; вызов прерывания DOS
        jz skip_input ; если клавиша не нажата, переход на метку skip_input

        mov ah, 0 ; функция ожидания нажатия клавиши
        int 16h ; вызов прерывания клавиатуры

        cmp al, 1bh ; проверка, была ли нажата клавиша Esc
        je end_program ; если да, переход на метку end_program

        cmp ah, 48h ; проверка, была ли нажата стрелка вверх
        je move_up ; если да, переход на метку move_up

        cmp ah, 50h ; проверка, была ли нажата стрелка вниз
        je move_down ; если да, переход на метку move_down

        cmp ah, 4bh ; проверка, была ли нажата стрелка влево
        je move_left ; если да, переход на метку move_left

        cmp ah, 4dh ; проверка, была ли нажата стрелка вправо
        je move_right ; если да, переход на метку move_right

        jmp new_line ; если нажата другая клавиша, переход на метку new_line

    move_up:
        cmp row, 0 ; проверка, находится ли курсор в верхней строке
        je skip_input ; если да, переход на метку skip_input
        dec row ; уменьшение номера строки на 1
        jmp skip_input ; переход на метку skip_input

    move_down:
        cmp row, 24 ; проверка, находится ли курсор в нижней строке
        je skip_input ; если да, переход на метку skip_input
        inc row ; увеличение номера строки на 1
        jmp skip_input ; переход на метку skip_input

    move_left:
        cmp col, 0 ; проверка, находится ли курсор в левом столбце
        je skip_input ; если да, переход на метку skip_input
        dec col ; уменьшение номера столбца на 1
        jmp skip_input ; переход на метку skip_input

    move_right:
        cmp col, 79 ; проверка, находится ли курсор в правом столбце
        je skip_input ; если да, переход на метку skip_input
        inc col ; увеличение номера столбца на 1
        jmp skip_input ; переход на метку skip_input

    new_line:
        mov char, al ; сохранение нажатого символа в переменную char
        inc row ; увеличение номера строки на 1
        mov col, 0 ; сброс номера столбца в начальное значение

    skip_input:
        mov ah, 02h ; установка позиции курсора
        mov dh, row ; строка
        mov dl, col ; столбец
        int 10h ; вызов прерывания видео

        mov ah, 09h ; вывод символа и атрибута
        mov al, char ; символ для вывода
        mov bh, 0 ; номер страницы
        mov bl, attr ; атрибут символа
        mov cx, 1 ; количество повторений символа
        int 10h ; вызов прерывания видео

        inc attr ; увеличение атрибута на 1
        cmp attr, 16 ; проверка, достиг ли атрибут максимального значения
        jne skip ; если нет, переход на метку skip
        mov attr, 1 ; сброс атрибута в начальное значение

    skip:
        mov ah, 1 ; проверка наличия нажатой клавиши
        int 16h ; вызов прерывания клавиатуры
        jz cycle ; если клавиша не нажата, переход на метку cycle
        jmp cycle ; переход на метку cycle

    end_program:
        mov ah, 4ch ; функция завершения программы
        int 21h ; вызов прерывания DOS
main endp
end main
