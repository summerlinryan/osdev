[org 0x7c00] ; offset all labels by 0x7c00 because this code will be loaded at that address by the BIOS
mov bx, hello_world ; we'll be using bx as a pointer to the individual characters stored at hello_world

main:
    mov ah, 0x0e ; teletype mode (for printing chars)
    mov al, [bx] 
    mov cx, 0
    cmp cx, [bx] ; check to see if our current char is a null terminating byte
    jne print_and_advance ; if it's not, we print and advance our pointer (BX register)
    jmp loop ; if it is, we just enter an infinite loop

print_and_advance:
    int 0x10
    add bx, 0x01
    jmp main

hello_world:
    db 'Hello world', 0

loop:
    jmp $

times 510-($-$$) db 0
dw 0xaa55
