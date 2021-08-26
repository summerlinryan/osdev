mov ah, 0x0e ; teletype mode (for printing chars)

mov al, "1" 
int 0x10 ; print 1
mov al, the_secret
int 0x10 ; print the address of the secret (as a char)

mov al, "2" 
int 0x10 ; print 2
mov al, [the_secret]
int 0x10 ; print the contents at the memory address of the_secret (as a char)

mov al, "3" 
int 0x10 ; print 3
mov al, 0x7c00
int 0x10 ; print the address of 0x7c00 (as a char)

mov al, "4",
int 0x10
mov bx, the_secret
add bx, 0x7c00
mov al, [bx]
int 0x10 ; print the contents of the address of the_secret + 0x7c00 (the starting address of this bootloader program)

the_secret:
    db "X" ; Store "X" right before 0xaa55 magic bootable bytes

jmp $

times 510-($-$$) db 0
dw 0xaa55