%macro rwmacro 3
mov rax, %1
mov rdi, 01
mov rsi, %2
mov rdx, %3
syscall
%endmacro

section .data
msg1 db "Enter the Number: "
msg2 db "The Number is: "
count db 05h

section .bss
numarr resb 17

global _start
section .text
_start:

loop1:
rwmacro 01, msg1, 18

rwmacro 00,numarr,17

rwmacro 01, msg2, 15

rwmacro 01, numarr, 17
dec byte[count]
xy: jnz loop1

mov rax, 60
mov rdi, 00
syscall
