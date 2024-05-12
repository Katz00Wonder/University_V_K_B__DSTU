; Х= 3 (А - 4В ) + С / 4

global _start ; объявление метки _start - точки входа в программу
section .data ; секция данных
    A dq 30 ; А
    B dq 6 ; В
    C dq 20 ; С

section .text ; объявление секции кода
_start:
    ; Вычисление А - 4В

   mov rax, [C] ; С
   mov rcx, 4 ; 4
   idiv rcx ; С / 4

   mov rcx, rax ; резульат С / 4

   mov rax, [A] ; А
   mov rbx, [B] ; В

   imul rbx, 4 ; 3 * 4
   sub rax, rbx ; А - 4В
   imul rax, 3; 3 * (А - 4В)

   add rax, rcx ; 3 * (А - 4В) + С / 4

   mov rdi, rax ; резульат

   mov rax, 60 ; системный вызов для завершения программы
   syscall ; вызов системного прерывания