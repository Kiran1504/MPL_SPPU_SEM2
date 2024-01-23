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

section .bss
numarr resb 17

global _start
section .text
_start:

rwmacro 01, msg1, 18

rwmacro 00,numarr,17

rwmacro 01, msg2, 15

rwmacro 01, numarr, 17

mov rax, 60
mov rdi, 00
syscall
