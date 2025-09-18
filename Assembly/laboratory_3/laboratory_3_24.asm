.model small
.stack 100h

.data
    ; ������ ���� (16-������ ��������)
    numbers dw 5, -3, 8, 1, -7, 12, 0, 4, -2, 9
    count equ ($ - numbers) / 2  ; ���������� ��������� � �������
    
    ; ���������
    msg_positive db 'Positive numbers found: $'
    msg_min db 0Dh, 0Ah, 'Minimum positive number: $'
    msg_none db 0Dh, 0Ah, 'No positive numbers found$'
    msg_space db ' $'
    
    min_value dw ?        ; ��� �������� ������������ �������������� �����
    found_flag db 0       ; ����: ������� �� ������������� �����

.code
main proc
    mov ax, @data
    mov ds, ax
    
    ; �������������
    mov cx, count         ; ��������� ���������� ���������
    mov si, offset numbers ; ��������� �� ������ �������
    mov found_flag, 0     ; ���������� ����
    
    ; ����� ������� �������������� ����� ��� ������������� min_value
    mov bx, 0FFFFh        ; ��������� �������� (������������ ���������)
    
find_first_positive:
    mov ax, [si]          ; ��������� ������� �����
    test ax, ax           ; ��������� ����
    jle next_element      ; ���� <= 0, ����������
    
    ; ����� ������ ������������� �����
    mov bx, ax           ; �������������� �������
    mov min_value, ax
    mov found_flag, 1    ; ������������� ����
    jmp continue_search
    
next_element:
    add si, 2            ; ��������� � ���������� ��������
    loop find_first_positive
    
    ; ���� �� ������� ������������� �����
    cmp found_flag, 0
    je no_positive
    
continue_search:
    ; ���������� ����� ������������ �������������� �����
    mov cx, count - 1    ; ���������� ��������
    add si, 2            ; ��������� � ���������� ��������
    
search_loop:
    mov ax, [si]         ; ��������� ������� �����
    
    ; ���������, ������������� �� �����
    test ax, ax
    jle skip_negative    ; ���� <= 0, ����������
    
    ; ���������� � ������� ���������
    cmp ax, bx
    jge skip_positive    ; ���� ������ ��� �����, ����������
    
    ; ����� ����� �������
    mov bx, ax
    mov min_value, ax
    
skip_positive:
    mov found_flag, 1    ; ������������� ����, ��� ����� �������������
    
skip_negative:
    add si, 2            ; ��������� � ���������� ��������
    loop search_loop
    
    ; ���������, ���� �� ������� ������������� �����
    cmp found_flag, 0
    je no_positive
    
    ; ����� �����������
    call display_results
    jmp exit_program
    
no_positive:
    ; ����� ��������� �� ���������� ������������� �����
    mov ah, 09h
    lea dx, msg_none
    int 21h
    jmp exit_program
    
exit_program:
    mov ax, 4C00h
    int 21h
main endp

; ��������� ��� ������ �����������
display_results proc
    ; ����� ���������
    mov ah, 09h
    lea dx, msg_positive
    int 21h
    
    ; ����� ���� ������������� �����
    mov cx, count
    mov si, offset numbers
    
print_loop:
    mov ax, [si]
    test ax, ax
    jle skip_print
    
    ; ����� �������������� �����
    call print_number
    mov ah, 09h
    lea dx, msg_space
    int 21h
    
skip_print:
    add si, 2
    loop print_loop
    
    ; ����� ������������ �������������� �����
    mov ah, 09h
    lea dx, msg_min
    int 21h
    
    mov ax, min_value
    call print_number
    
    ret
display_results endp

; ��������� ��� ������ ����� (16-������)
print_number proc
    push ax
    push bx
    push cx
    push dx
    
    mov bx, 10          ; ��������� ������� ���������
    xor cx, cx          ; ������� ����
    
    ; �������� �����
    test ax, ax
    jns convert_loop
    neg ax              ; ���� �������������, ������ �������������
    push ax
    mov dl, '-'
    mov ah, 02h
    int 21h
    pop ax
    
convert_loop:
    xor dx, dx
    div bx              ; ����� AX �� 10
    push dx             ; ��������� ������� (�����)
    inc cx              ; ����������� ������� ����
    test ax, ax
    jnz convert_loop
    
print_digits:
    pop dx              ; ��������� �����
    add dl, '0'         ; ����������� � ������
    mov ah, 02h         ; ����� �������
    int 21h
    loop print_digits
    
    pop dx
    pop cx
    pop bx
    pop ax
    ret
print_number endp

end main