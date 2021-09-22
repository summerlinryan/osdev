; param BX: null terminated string to print

; summary: prints the null-terminated string pointed to by BX
print_string: 
    push bx
    mov ah, 0x0e ; tell the video services interrupt handler that we want to print with TTY mode

handle_char: 
    mov al, [bx] ; set the character that we want to check to see if we should print it or if its the end of the string
    cmp al, 0x00 ; compare the character that we're looking at with 0
    jne print_char; if that character is not 0 (i.e. null terminating) then we should print the character

    pop bx
    ret ; we've reached the end of the string so pop the PC address off the stack and return to the caller

print_char:
    int 0x10 ; asking the BIOS to print the current character
    inc bx; advance the bx register by 1 byte so we're looking at the next character
    jmp handle_char ; handle the next character


BIOS_TELETYPE_MODE: db 0x0e
BIOS_VIDEO_SERVICES_INTERRUPT_HANDLER: db 0x10