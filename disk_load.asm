; param DH: # number of sectors to read
; param DL: the drive number to read from 
; param BX: the memory address to load the disk contents into

; summary: loads disk contents into memory (always reading from cylinder 0,
; head 0, sector 2 which is the first sector after the boot loader)
; remark: assumes the stack is set up already
disk_load: 
    push dx; 

    mov ah, 0x02 ; use the BIOS read sectore routine when 
    mov al, dh ; set the number of sectors to read
    mov ch, 0x00 ; set the cylinder to read from 
    mov dh, 0x00 ; set the head to read from 
    mov cl, 0x02 ; set the sector to read from 

    int 0x13 ; call into the BIOS to actually read the sectors

    ; jc disk_error ; call disk_error routine if carry flag is set (meaning there was an error in the BIOS interupt handler)

    pop dx ; restore dx to its value before this routine was called (being friendly to the caller)
    cmp dh, al ; coompare al (i.e. # of sectors read by BIOS) to dh (i.e. # of sectors we wanted to read)
    ; jne disk_error ; if there not equal we call disk_error routine 
    ret ; pop the instruction pointer off the stack into the instruction pointer register so we continue executing where we called from

disk_error:
    mov bx, DISK_ERROR_MSG ; set up parameter used by print_string
    call print_string ; prints the error string stored in bx
    jmp $ ; loop indefintely 

DISK_ERROR_MSG: db "Error while reading disk", 0 ; set the error message and add null terminating byte