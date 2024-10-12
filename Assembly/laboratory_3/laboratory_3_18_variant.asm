    org 100h
begin:  jmp start
   db "***" ; для красоты - чтобы были видны наши данные
NB db 10100111b, 11111100b, 10010010b ; старший бит, байт - первыми ?
   db "***" ;
xorop db 10100000b,0,0 ; маска операции xor
 
start:
    call showresult
    call doxor
    call showresult
    call doxor ; проверочный вызов - при 2ном xor результат не должен меняться
    call showresult
    ret ; выход в эмулятор
 
doxor:
mov bl,10100000b ; 101 - старшие виты ?
mov bh,0
lea di,xorop
mov [di],bl
mov [di+1],bh
mov [di+2],bh
mov cx,8 ; цикл 8 раз
m0:
lea si,NB  ; выполняем операцию xor
mov al,[di]
xor [si],al
 
mov al,[di+1]
xor [si+1],al
 
mov al,[di+2]
xor [si+2],al
 
    clc   ; сдвигаем маску xor 3 раза вправо
    rcr byte ptr [di],1
    rcr byte ptr [di+1],1
    rcr byte ptr [di+2],1
    
    clc
    rcr byte ptr [di],1
    rcr byte ptr [di+1],1
    rcr byte ptr [di+2],1
 
    clc
    rcr byte ptr [di],1
    rcr byte ptr [di+1],1
    rcr byte ptr [di+2],1
 
loop m0
    ret
    
; показать битовый массив
showresult:
    lea si,NB
    mov dh,[si]   ; заносим массив в регистры 
    mov bh,[si+1]
    mov bl,[si+2]
    mov cx,8
s1: call showbit ; напечатать 3 бита
    call showbit
    call showbit
    mov dl," "
    call showchar
    loop s1
    mov dl,13     ; перевод строки
    call showchar
    mov dl,10
    call showchar
    ret
 
showbit: add bx,bx  ; Carry=бит
    adc dh,dh
    mov dl,"0"
    jnc showchar
    mov dl,"1"
showchar:mov ah,2
    int 21h
    ret