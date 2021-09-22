[org 0x7c00] ; memory offset of the bootloader (because of the BIOS)

mov bp, 0x8000 ; set base pointer of our stack to 0x8000 (which is really far away from 0x7c00 that the bootloader is loaded into)
mov sp, bp ; the top of the stack is the same as the bottom of the stack when we first initializing the stack

mov dx, 0xabcd
call print_hex 

mov dx, 0x1ab
call print_hex

jmp $

%include "./print_string.asm"
%include "./print_hex.asm"

times 510-($-$$) db 0 ; pad with 0s until the last 2 bytes of the 512 byte boot sector 
dw 0xaa55 ; magic number that tells the BIOS this is bootable