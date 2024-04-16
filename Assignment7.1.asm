%macro rw 4
  mov rax, %1
  mov rdi, %2;01
  mov rsi, %3
  mov rdx, %4 
  syscall
%endmacro rw

section .data
fname db "text.txt",0
global charac
charac db 00
success db "File opened successfully",10,13
succlen equ $-success
fail db "File not opened",10,13
faillen equ $-fail

section .bss
global buffer, bufferlen
buffer resb 100
bufferlen resb 1
fd resq 1

section .text

extern countspaces, countnewlines, countcharac  

global _start
_start:
rw 02, fname, 02, 0777h
mov qword[fd], rax
rol rax, 01
jc failmsg
rw 01, 01, success, succlen


;read the file - system call
rw 00, [fd], buffer, 100
mov byte[bufferlen], rax
;rw 01, 01, buffer, 100

call countspaces
call countnewlines
call countcharac


mov rax, 03h    ;close the file
mov rdi, fname
syscall
jmp endofprogram

failmsg:
rw 01, 01, fail, faillen


endofprogram:

mov rax,60
mov rdi,00
syscall
