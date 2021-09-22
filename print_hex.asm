 ; param DX: a number value to print

; summary: prints number value stored in DX in hex format
print_hex: 
    pusha

    mov cx, 4 ; number of characters to skip when writing letter to HEX_OUT

char_loop:
    dec cx
    mov ax, dx ; store the initial number
    and ax, 0xf ; get the last digit
    shr dx, 4 ; drop the last digit

    cmp ax, 0xa
    jl handle_numeric_digit
    jmp handle_alpha_digit

set_hex_out_digit: 
    mov bx, HEX_OUT
    add bx, 2 ; skip past '0x' of HEX_OUT
    add bx, cx
    mov byte [bx], al ; don't wanna move both bytes of ax, so only move the lower half
    cmp cx, 0
    je print_hex_done
    jmp char_loop

print_hex_done:
    mov bx, HEX_OUT
    call print_string
    popa
    ret

handle_numeric_digit:
    add ax, 0x30 ; '0' (0x30) - 0x0 = 0x30
    jmp set_hex_out_digit

handle_alpha_digit:
    add ax, 0x37 ; 'A' (0x41) - 0xa = 0x37
    jmp set_hex_out_digit

HEX_OUT: db '0x0000', 0xd, 0xa, 0 ; end with CRLF and null terminating byte