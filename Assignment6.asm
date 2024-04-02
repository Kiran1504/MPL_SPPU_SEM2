%macro rw 3
  mov rax, %1
  mov rdi, 01
  mov rsi, %2
  mov rdx, %3 
  syscall
%endmacro rw

section .data
msg1 db "The System is in protected mode",10,13
m equ $-msg1
entercode db 0Ah
colon db 3Ah
msg2 db "The System is not in protected mode",10,13
mlen equ $-msg2

section .bss
result resb 04
descp resb 06
ans resw 1
count resb 1

global _start:
section .text
_start:
smsw ax
mov word[ans], ax
rcr ax, 01
jc penabled
rw 01, msg2, mlen
penabled:
rw 01, msg1, m
call hta
rw 01, entercode, 01
str ax
mov word[ans], ax
call hta
rw 01, entercode, 01
sldt ax
mov word[ans], ax
call hta
rw 01, entercode, 01


sgdt [descp]
mov eax, dword[descp]
ror eax, 16
mov word[ans], ax
call hta

ror eax, 16
mov word[ans], ax
call hta

mov ax, word[descp + 4]
mov word[ans], ax
rw 01, colon, 01
call hta
rw 01, entercode, 01



sidt [descp]
mov eax, dword[descp]
ror eax, 16
mov word[ans], ax
call hta

ror eax, 16
mov word[ans], ax
call hta

mov ax, word[descp + 4]
mov word[ans], ax
rw 01, colon, 01
call hta
rw 01, entercode, 01


;point:
mov rax,60
mov rdi,00
syscall


hta:
   mov rdi, result
   mov byte[count], 4
   mov ax, word[ans]
down: 
   rol ax, 04
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
   
rw 01, result, 4
ret
