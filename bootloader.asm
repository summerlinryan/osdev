[org 0x7c00] ; memory offset of the bootloader (because of the BIOS)

mov [BOOT_DRIVE], dl ; the BIOS stores our boot drive in dl before calling into us

mov bp, 0x8000 ; set base pointer of our stack to 0x8000 (which is really far away from 0x7c00 that the bootloader is loaded into)
mov sp, bp ; the top of the stack is the same as the bottom of the stack when we first initializing the stack

mov bx, 0x9000
mov dh, 5
mov dl, [BOOT_DRIVE]
call disk_load

mov dx, [0x9000]
call print_hex

mov dx, [0x9000 + 512]
call print_hex

jmp $

BOOT_DRIVE: db 0

%include "./print_string.asm"
%include "./print_hex.asm"
%include "./disk_load.asm"

times 510-($-$$) db 0 ; pad with 0s until the last 2 bytes of the 512 byte boot sector 
dw 0xaa55 ; magic number that tells the BIOS this is bootable

; store a bunch of well known data beyond the boot sector so that we can confirm
; disk_load worked as expected. if we read the first word of the first 512 byte sector
; after the boot sector, we should see 0xDADA. if we read the first word of second 
; 512 byte sector after the boot sector, we should see 0xFACE.
times 256 dw 0xdada
times 256 dw 0xface