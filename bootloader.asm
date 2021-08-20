loop:
    jmp loop

; add 0 bytes up until last 2 bytes of bootloader with need to be 0xAA55
; to tell the BIOS that this disk is bootable
times 510-($-$$) db 0
dw 0xaa55