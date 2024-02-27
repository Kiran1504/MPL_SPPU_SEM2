%macro rw 3
  mov rax, %1
  mov rdi, 01
  mov rsi, %2
  mov rdx, %3 
  syscall
%endmacro rw

section .data
n1 dq 0000000000000002h
n2 dq 0000000000000003h
entercode db 0Ah
menu db "___MENU___",10,13,"1. Add",10,13,"2. Sub",10,13,"3. mul",10,13,"4. div",10,13,"5. exit",10,13,"Enter your choice: "
mlen equ $-menu

section .bss
option resb 1
ans resq 1
result resb 16
count resb 1

section .text
global _start
_start:

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
jmp cont

addition:
call addproc
call hta
jmp cont

subtraction:
call subproc
call hta
jmp cont

multiplication:
call mulproc
call hta
jmp cont

division:
;call divproc
;call hta
mov ecx, dword[n1]
mov rax, qword[n2]
div ecx
mov qword[ans], rax
check:
jmp cont

rw 01, entercode, 1
rw 01, option, 1

cont:
rw 01, entercode, 1
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
mov rax, qword[n1]
mul qword[n2]
mov qword[ans], rax
ret

divproc:
mov rax, qword[n2]
div qword[n1]
mov qword[ans], rax
ret

