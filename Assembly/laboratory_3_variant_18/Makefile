all: lab_3_result

xor: lab_3.o
    ld lab_3.o -o lab_3_result

xor.o: laboratory_3.asm
    nasm -f elf64 laboratory_3.asm -o lab_3.o

clean:
    rm -f lab_3.o lab_3_result
