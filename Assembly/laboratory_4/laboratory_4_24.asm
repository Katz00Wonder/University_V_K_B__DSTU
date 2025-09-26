.model small
.stack 100h

.data
    byte_array db 0F0h, 07h, 3Fh, 01h, 0FFh, 00h
    array_size equ 6
    
    msg_result db 'Bytes with <= 3 ones: $'
    msg_count db 0Dh, 0Ah, 'Count: $'
    msg_binary db 0Dh, 0Ah, 'Binary: $'
    msg_space db ' $'
    
    count db 0          
    temp db ?            

.code
main proc
    mov ax, @data
    mov ds, ax
    
    mov cx, array_size   
    mov si, offset byte_array 
    mov count, 0         
    

    mov ah, 09h
    lea dx, msg_result
    int 21h
    
process_loop:
    mov al, [si]         
    mov temp, al         
    
    
    mov bl, 0            
    mov dh, 8            
    
count_ones:
    test al, 1           
    jz bit_zero          
    
    inc bl               
    
bit_zero:
    shr al, 1            
    dec dh               
    jnz count_ones       
    
    
    cmp bl, 3
    ja skip_count        
    
    inc count
    
    call print_binary_byte
    mov ah, 09h
    lea dx, msg_space
    int 21h
    
skip_count:
    inc si             
    loop process_loop
    
    mov ah, 09h
    lea dx, msg_count
    int 21h
    
    mov al, count
    call print_number
    

    mov ax, 4C00h
    int 21h
main endp


print_binary_byte proc
    push ax
    push bx
    push cx
    push dx
    
    mov al, temp
    mov cl, 8            
    mov ch, 0
    
print_bits:
    rol al, 1            
    jc print_one
    
    
    mov dl, '0'
    jmp print_bit
    
print_one:
    mov dl, '1'
    
print_bit:
    mov ah, 02h
    int 21h
    
    dec cl
    jnz print_bits
    
    pop dx
    pop cx
    pop bx
    pop ax
    ret
print_binary_byte endp


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

end main