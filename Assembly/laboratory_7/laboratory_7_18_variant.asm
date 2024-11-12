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
    int 16h ; �������� ������� �������
    mov char, al ; ���������� �������

    cycle:
        mov ah, 0ch ; ������� �������� ������� ������� ������� ��� ��������
        int 21h ; ����� ���������� DOS
        jz skip_input ; ���� ������� �� ������, ������� �� ����� skip_input

        mov ah, 0 ; ������� �������� ������� �������
        int 16h ; ����� ���������� ����������

        cmp al, 1bh ; ��������, ���� �� ������ ������� Esc
        je end_program ; ���� ��, ������� �� ����� end_program

        cmp ah, 48h ; ��������, ���� �� ������ ������� �����
        je move_up ; ���� ��, ������� �� ����� move_up

        cmp ah, 50h ; ��������, ���� �� ������ ������� ����
        je move_down ; ���� ��, ������� �� ����� move_down

        cmp ah, 4bh ; ��������, ���� �� ������ ������� �����
        je move_left ; ���� ��, ������� �� ����� move_left

        cmp ah, 4dh ; ��������, ���� �� ������ ������� ������
        je move_right ; ���� ��, ������� �� ����� move_right

        jmp new_line ; ���� ������ ������ �������, ������� �� ����� new_line

    move_up:
        cmp row, 0 ; ��������, ��������� �� ������ � ������� ������
        je skip_input ; ���� ��, ������� �� ����� skip_input
        dec row ; ���������� ������ ������ �� 1
        jmp skip_input ; ������� �� ����� skip_input

    move_down:
        cmp row, 24 ; ��������, ��������� �� ������ � ������ ������
        je skip_input ; ���� ��, ������� �� ����� skip_input
        inc row ; ���������� ������ ������ �� 1
        jmp skip_input ; ������� �� ����� skip_input

    move_left:
        cmp col, 0 ; ��������, ��������� �� ������ � ����� �������
        je skip_input ; ���� ��, ������� �� ����� skip_input
        dec col ; ���������� ������ ������� �� 1
        jmp skip_input ; ������� �� ����� skip_input

    move_right:
        cmp col, 79 ; ��������, ��������� �� ������ � ������ �������
        je skip_input ; ���� ��, ������� �� ����� skip_input
        inc col ; ���������� ������ ������� �� 1
        jmp skip_input ; ������� �� ����� skip_input

    new_line:
        mov char, al ; ���������� �������� ������� � ���������� char
        inc row ; ���������� ������ ������ �� 1
        mov col, 0 ; ����� ������ ������� � ��������� ��������

    skip_input:
        mov ah, 02h ; ��������� ������� �������
        mov dh, row ; ������
        mov dl, col ; �������
        int 10h ; ����� ���������� �����

        mov ah, 09h ; ����� ������� � ��������
        mov al, char ; ������ ��� ������
        mov bh, 0 ; ����� ��������
        mov bl, attr ; ������� �������
        mov cx, 1 ; ���������� ���������� �������
        int 10h ; ����� ���������� �����

        inc attr ; ���������� �������� �� 1
        cmp attr, 16 ; ��������, ������ �� ������� ������������� ��������
        jne skip ; ���� ���, ������� �� ����� skip
        mov attr, 1 ; ����� �������� � ��������� ��������

    skip:
        mov ah, 1 ; �������� ������� ������� �������
        int 16h ; ����� ���������� ����������
        jz cycle ; ���� ������� �� ������, ������� �� ����� cycle
        jmp cycle ; ������� �� ����� cycle

    end_program:
        mov ah, 4ch ; ������� ���������� ���������
        int 21h ; ����� ���������� DOS
main endp
end main
