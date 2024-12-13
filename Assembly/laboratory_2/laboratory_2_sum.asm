global _start
 
section .data
nums dq 10,5, 32, 4, 6, 7, 8, 9, 10, 11
count equ ($-nums)/numSize    ; количество элементов
numSize equ 8   ; размер каждого элемента
 
section .text
_start:
    ; устанавливаем параметры для функции sum
    mov rdi, nums                  ; в RDI адрес массива
    mov rsi, count     ; в RSI - количество элементов массива
    call sum 
    
    mov rax, rax ; результат сложения в RAX
    mov rcx, count ; количество элементов в RCX
    idiv rcx ; деление RAX на RCX    ; после вызова в RAX - результат сложения
    mov rdi, rax     ; помещаем результат в RDI
    mov rax, 60
    syscall
 
; Функция sum выполняет сложение чисел массива
; RDI - адрес массива
; RSI - размер массива
; RAX - результат сложения
sum: ; начало функции
    xor rax, rax     ; обнуляем RAX для хранения результата
    jmp while_condition ; переходим к проверке условия
while_begin: ; начало цикла
    dec rsi     ; уменьшаем счетчик количества элементов массива

    add rax, [rdi + rsi * numSize] ; суммируем элементы массива
while_condition: ; проверка условия
    cmp rsi, 0   ; сравниваем количество обработанных элементов 
    jne while_begin ; если не все элементы обработали, переходим обратно
    ret