    org 100h
begin:  jmp start
   db "***" ; ��� ������� - ����� ���� ����� ���� ������
NB db 10100111b, 11111100b, 10010010b ; ������� ���, ���� - ������� ?
   db "***" ;
xorop db 10100000b,0,0 ; ����� �������� xor
 
start:
    call showresult
    call doxor
    call showresult
    call doxor ; ����������� ����� - ��� 2��� xor ��������� �� ������ ��������
    call showresult
    ret ; ����� � ��������
 
doxor:
mov bl,10100000b ; 101 - ������� ���� ?
mov bh,0
lea di,xorop
mov [di],bl
mov [di+1],bh
mov [di+2],bh
mov cx,8 ; ���� 8 ���
m0:
lea si,NB  ; ��������� �������� xor
mov al,[di]
xor [si],al
 
mov al,[di+1]
xor [si+1],al
 
mov al,[di+2]
xor [si+2],al
 
    clc   ; �������� ����� xor 3 ���� ������
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
    
; �������� ������� ������
showresult:
    lea si,NB
    mov dh,[si]   ; ������� ������ � �������� 
    mov bh,[si+1]
    mov bl,[si+2]
    mov cx,8
s1: call showbit ; ���������� 3 ����
    call showbit
    call showbit
    mov dl," "
    call showchar
    loop s1
    mov dl,13     ; ������� ������
    call showchar
    mov dl,10
    call showchar
    ret
 
showbit: add bx,bx  ; Carry=���
    adc dh,dh
    mov dl,"0"
    jnc showchar
    mov dl,"1"
showchar:mov ah,2
    int 21h
    ret