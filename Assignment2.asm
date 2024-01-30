%macro rwmacro 3
mov rax, %1
mov rdi, 01
mov rsi, %2
mov rdx, %3
syscall
%endmacro

section .data
msg1 db "Enter the String: "
msg2 db "The length is: "
length db 00h
count db 16

section .bss
arr resb 100
result resb 16

global _start
section .text
_start:


rwmacro 01, msg1, 18
rwmacro 00, arr, 100

mov rdi, result
main_loop:
	rol rax, 04
	mov bl, al
	and bl, 0Fh
	cmp bl, 09h
	jns alphabet
	add bl, 30h
	jmp number
	alphabet: 
		add bl,37h
	number:
		mov [rdi], bl
	inc rdi
	dec byte[count]
	jnz main_loop


rwmacro 01, result, 16

mov rax, 60
mov rdi, 00
syscall
