mov ah, 0x0e

mov bp, 0x8000 ; start our stack at 0x8000 so that its far enough to not collide with our code stored around 0x7c00 (where the BIOS loads us)
mov sp, bp

push 'A'
push 'B'
push 'C'

pop bx
mov al, bl
int 0x10 ; print the top of the stack

pop bx
mov al, bl
int 0x10 ; print the top of the stack

mov al, [0x7ffe] ; print the character that is starts after the first 2 bytes of the stack (since the stack grows downwards)
int 0x10 ; print the top of the stack

jmp $
times 510-($-$$) db 0
dw 0xaa55
