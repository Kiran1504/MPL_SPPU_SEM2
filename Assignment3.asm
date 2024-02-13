%macro rw 3
  mov rax, %1
  mov rdi, 01
  mov rsi, %2
  mov rdx, %3 
  syscall
%endmacro rw

section .data
count db 03
arr dq 1645487569236547h, 9548123459878521h, 1246561231235874h
pcount db 00
ncount db 00 
msg1 db "Count of positive numbers = "
msg2 db "Count of negative numbers = "

section .bss
resultarr  resb 02
res resb 1

section .text
global _start
_start:
             

mov rbp, arr


up: 
   mov rax, [rbp]
   cmp rax, 0000000000000000h
   js next
   inc byte[pcount]
   jmp below 
next: inc byte[ncount]
below:
   inc rbp
   dec byte[count]
jnz up

mov al, byte[pcount]
mov byte[res], al
rw 01, msg1, 28
call hta

mov al, byte[ncount]
mov byte[res], al
rw 01, msg2, 28
call hta
                        
mov rax,60
mov rdi,00
syscall

hta:
   mov rdi, resultarr
   mov byte[count], 02
   mov al, byte[res]
down: 
   rol al, 04
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
   
rw 01, resultarr, 02
ret
