global reload_gdt

reload_gdt:
    jmp 0x08:.reload_cs_far

.reload_cs_far:
    push esp
    mov ax, 0x10
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax
    pop esp
    ret