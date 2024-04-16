%macro rw 3
  mov rax, %1
  mov rdi, 01
  mov rsi, %2
  mov rdx, %3 
  syscall
%endmacro rw

section .data
extern charac
spacemsg db 10,13,"No. of spaces: "
spacelen equ $-spacemsg
newlinemsg db 10,13,"No. of new lines: "
newlinelen equ $-newlinemsg
charmsg db 10,13,"Count of character: "
charlen equ $-charmsg


charcnt db 00
spacecnt db 00
linecnt db 00

section .bss
extern buffer, bufferlen
result resb 2
counter resb 1

section .text
global countspaces, countnewlines, countcharac


countspaces:
mov al, byte[bufferlen]
mov byte[counter], al
mov rdi, buffer
loop1:
cmp [rdi], 20h
jne cont1
inc spacecnt
cont1:
inc rdi
dec byte[counter]
jnz loop1

mov cl, byte[spacecnt]
mov byte[result], cl
rw 01, spacemsg, spacelen
call hta

ret

countnewlines:
mov al, byte[bufferlen]
mov byte[counter], al
mov rdi, buffer
loop2:
cmp [rdi], 10h
jne cont2
inc linecnt
cont2:
inc rdi
dec byte[counter]
jnz loop2

mov cl, byte[linecnt]
mov byte[result], cl
rw 01, newlinemsg, newlinelen
call hta

ret



countcharac:
mov al, byte[bufferlen]
mov byte[counter], al
mov rdi, buffer
loop3:
cmp [rdi], charac
jne cont3
inc charcnt
cont3:
inc rdi
dec byte[counter]
jnz loop3

mov cl, byte[charcnt]
mov byte[result], cl
rw 01, charmsg, charlen
call hta

ret






hta:
   mov rdi, result
   mov byte[counter], 2
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
   dec byte[counter]
jnz down
   
rw 01, result, 2
ret
