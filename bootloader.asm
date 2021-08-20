mov ah, 0x0e ; use teletype output mode
mov al, 'H'
int 0x10 ; write character in al
mov al, 'E'
int 0x10 ; write character in al
mov al, 'L'
int 0x10 ; write character in al
int 0x10 ; write character in al
mov al, 'O'
int 0x10 ; write character in al

jmp $ ; jump to current address (i.e. infinite loop)

; add 0 bytes up until last 2 bytes of bootloader with need to be 0xAA55
; to tell the BIOS that this disk is bootable
times 510-($-$$) db 0
dw 0xaa55