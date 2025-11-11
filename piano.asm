; ==================================
; Piano en ensamblador (NASM + DOSBox)
; ==================================
; Uso:
; nasm -f bin piano.asm -o piano.com
; Luego ejecutar: piano
; ==================================

org 100h

msg db "Piano en ensamblador - Presione A S D F G H J K L (ESC para salir)$"

notes:
    dw 4545, 4049, 3607, 3400, 3030, 2703, 2407, 2272, 2024  ; Notas C4–D5
keys:
    db 'a','s','d','f','g','h','j','k','l',0

; ---------------------------
start:
    mov ah, 09h
    mov dx, msg
    int 21h

main_loop:
    ; Esperar una tecla (bloqueante)
    mov ah, 0
    int 16h
    mov bl, al

    cmp bl, 27      ; ESC para salir
    je exit_program

    ; Buscar tecla en la lista
    mov si, keys
    xor cx, cx
find_key:
    mov al, [si]
    cmp al, 0
    je main_loop     ; si no la encuentra, ignora
    cmp al, bl
    je play_note
    inc si
    inc cx
    jmp find_key

; ---------------------------
play_note:
    mov bx, cx
    shl bx, 1
    mov ax, [notes + bx]
    call beep
    jmp main_loop

; ---------------------------
beep:
    push ax
    push bx
    push dx

    mov bx, ax
    mov al, 0b6h
    out 43h, al
    mov ax, bx
    out 42h, al
    mov al, ah
    out 42h, al

    in al, 61h
    or al, 03h
    out 61h, al

    mov cx, 0FFFFh
.delay:
    loop .delay

    in al, 61h
    and al, 0FCh
    out 61h, al

    pop dx
    pop bx
    pop ax
    ret

; ---------------------------
exit_program:
    mov ax, 4C00h
    int 21h
