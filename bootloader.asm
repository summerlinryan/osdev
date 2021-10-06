[org 0x7c00] ; memory offset of the bootloader (because of the BIOS)

mov bp, 0x9000
mov sp, bp

mov bx, MSG_REAL_MODE
call print_string

call switch_to_pm
jmp $

%include "./print_string.asm"
%include "./gdt.asm"
%include "./print_string_pm.asm"
%include "./switch_to_pm.asm"

[bits 32]
BEGIN_PM:
    mov ebx, MSG_PROT_MODE
    call print_string_pm

    jmp $

; Global variables
MSG_REAL_MODE: db "Started in 16-bit Real Mode", 0
MSG_PROT_MODE: db "Successfully landed in 32-bit Protected Mode", 0

times 510-($-$$) db 0 ; pad with 0s until the last 2 bytes of the 512 byte boot sector 
dw 0xaa55 ; magic number that tells the BIOS this is bootable

