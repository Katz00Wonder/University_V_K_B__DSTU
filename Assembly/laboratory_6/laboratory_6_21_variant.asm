.model small
.stack 100h
.data
    input_buffer db 80 dup('$') ; Buffer for input string
    prompt db 'Enter a string: $'
    result_buffer db 80 dup('$') ; Buffer for result string
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
    lea dx, input_buffer
    int 21h

    ; Initialize pointers
    lea si, input_buffer + 2 ; Skip the first two bytes (length and CR)
    lea di, result_buffer

    ; Process each word in the input string
process_words:
    mov al, [si]
    cmp al, '$'
    je done

    ; Find the end of the current word
    mov bx, si
find_end_of_word:
    mov al, [bx]
    cmp al, ' '
    je word_found
    cmp al, '$'
    je word_found
    inc bx
    jmp find_end_of_word

word_found:
    ; Reverse the current word
    dec bx
    call reverse_string

    ; Copy the reversed word to the result buffer
copy_word:
    mov al, [si]
    cmp al, ' '
    je copy_space
    cmp al, '$'
    je done
    mov [di], al
    inc si
    inc di
    jmp copy_word

copy_space:
    mov [di], al
    inc si
    inc di
    jmp process_words

done:
    ; Null-terminate the result string
    mov byte ptr [di], '$'

    ; Print a newline
    lea dx, newline
    mov ah, 09h
    int 21h

    ; Print the result string
    lea dx, result_buffer
    mov ah, 09h
    int 21h

    ; Exit program
    mov ax, 4C00h
    int 21h

main endp

; Subroutine to reverse a string
; Input: SI = start of the string, BX = end of the string
; Output: The string is reversed in place
reverse_string proc
    push ax
    push si
    push bx

reverse_loop:
    cmp si, bx
    jge reverse_done
    mov al, [si]
    mov ah, [bx]
    mov [si], ah
    mov [bx], al
    inc si
    dec bx
    jmp reverse_loop

reverse_done:
    pop bx
    pop si
    pop ax
    ret
reverse_string endp

end main
