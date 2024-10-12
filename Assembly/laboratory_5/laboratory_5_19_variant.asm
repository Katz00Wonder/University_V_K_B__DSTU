.model small
.stack 100h
.data
    input db 80 dup('$') ; Buffer for input string
    prompt db 'Enter a string: $'
    result db 'Number of commas: $'
    comma_count db 0 ; Counter for commas
    newline db 0Dh, 0Ah, '$' ; Newline characters

.code
main proc
    mov ax, @data
    mov ds, ax
    mov es, ax

    ; Display prompt
    lea dx, prompt
    mov ah, 09h
    int 21h

    ; Read input string from the keyboard
    mov ah, 0Ah
    lea dx, input
    int 21h

    ; Initialize pointers and counters
    lea si, input + 2 ; Skip the first two bytes (length and CR)
    mov cx, 0 ; Initialize comma counter

count_commas:
    mov al, [si]
    cmp al, '$'
    je print_result

    ; Check for comma
    cmp al, ','
    je increment_comma_count

    inc si
    jmp count_commas

increment_comma_count:
    inc cx
    inc si
    jmp count_commas

print_result:
    ; Print newline
    lea dx, newline
    mov ah, 09h
    int 21h

    ; Print result message
    lea dx, result
    mov ah, 09h
    int 21h

    ; Convert comma count to string and print
    mov comma_count, cl
    add comma_count, '0'
    mov ah, 0Eh
    mov al, comma_count
    int 10h

    ; Print newline
    lea dx, newline
    mov ah, 09h
    int 21h

    ; Exit program
    mov ax, 4C00h
    int 21h

main endp
end main
