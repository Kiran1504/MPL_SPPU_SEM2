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
pcount db 00
ncount db 00 
zcount db 00
msg1 db " Count of positive numbers = "
msg2 db " Count of negative numbers = "
msg3 db " Count of no of zeroes is = "

section .bss
resultarr  resb 02
res resb 1

section .text
global _start
_start:
             

mov rdi, arr


up: 
   mov rax, [rdi]
   cmp rax, 0h
   js next
   jz zero
   inc byte[pcount]
   jmp below
zero: inc byte[zcount]
jmp below
next: inc byte[ncount]
below:
add rdi, 08
   dec byte[count]
jnz up

mov al, byte[pcount]
mov byte[res], al
rw 01, msg1, 29
call hta

mov al, byte[ncount]
mov byte[res], al
rw 01, msg2, 29
call hta

mov al, byte[zcount]
mov byte[res], al
rw 01, msg3, 28
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
