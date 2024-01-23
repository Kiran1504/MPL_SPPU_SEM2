section .data
num1 db 2Ch

section .bss
num2 resb 1

global _start
section .text
_start:
mov al,80h
brkpt:
mov bl, 04h
pt2:
mov dl, 99
pt3:

mov rax,60
mov rdi, 00
syscall
