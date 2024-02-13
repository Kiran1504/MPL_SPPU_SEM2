%macro rw 3
  mov rax, %1
  mov rdi, 01
  mov rsi, %2
  mov rdx, %3 
  syscall
%endmacro rw

section .data
count db 04h
arr dq 1645487569236547h, 9548123459878521h, 1246561231235874h, 0000000000000000h
msg1 db "The largest number is = "

section .bss
currmax resq 1
result  resb 16

section .text
global _start
_start:

mov rdi, arr
mov rax, [rdi]
mov qword[currmax], rax
mainloop:

mov rax, [rdi]
cmp rax, qword[currmax]
jge greater
jmp cont
greater:
mov qword[currmax], rax
cont:
add rdi, 08
dec byte[count]
jnz mainloop
rw 01, msg1, 24
call hta

mov rcx, qword[currmax]
xy:

mov rax,60
mov rdi,00
syscall


hta:
   mov rdi, result
   mov byte[count], 16
   mov rax, qword[currmax]
down: 
   rol rax, 04
   mov bl, al
   and bl, 0Fh
   cmp bl, 09h
   jle neg
   add bl, 07h
neg: 
   add bl, 30h
   mov [rdi], bl
   inc rdi
   dec byte[count]
jnz down
   
rw 01, result, 16
ret
