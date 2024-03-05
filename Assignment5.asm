%macro rw 3
  mov rax, %1
  mov rdi, 01
  mov rsi, %2
  mov rdx, %3 
  syscall
%endmacro rw

section .data
n1 dq 0000000000000002h
n2 dq 0000000000000004h
entercode db 0Ah
menu db 10,"___MENU___",10,13,"1. Add",10,13,"2. Sub",10,13,"3. mul",10,13,"4. div",10,13,"5. exit",10,13,"Enter your choice: "
mlen equ $-menu

section .bss
option resb 1
ans resq 1
result resb 16
re resq 1
count resb 1

section .text
global _start
_start:

restart:
rw 01,menu, mlen
rw 00, option, 1
cmp byte[option], 31h
jz addition
cmp byte[option], 32h
jz subtraction
cmp byte[option], 33h
jz multiplication
cmp byte[option], 34h
jz division
cmp byte[option], 35h
jz cont

addition:
call addproc
call hta
jmp restart

subtraction:
call subproc
call hta
jmp restart

multiplication:
call mulproc
call hta
jmp restart

division:
call divproc
call hta
jmp restart




cont:
mov rax,60
mov rdi,00
syscall


hta:
   mov rdi, result
   mov byte[count], 16
   mov rax, qword[ans]
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


addproc:
mov rax, qword[n1]
add rax, qword[n2]
mov qword[ans], rax
ret

subproc:
mov rax, qword[n1]
sub rax, qword[n2]
mov qword[ans], rax
ret

mulproc:
mov eax, dword[n1]
mul qword[n2]
mov qword[ans], rax
ret

divproc:
xor rax, rax
xor rdx, rdx
mov rax, qword[n2]
div dword[n1]
mov qword[ans], rax
mov qword[re], rdx
call hta
rw 01, entercode, 01
mov rdx, qword[re]
mov qword[ans], rdx
ret

