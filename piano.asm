; ==================================
; Piano de prueba sin sonido (NASM + DOSBox)
; ==================================
; Uso:
;   nasm -f bin piano.asm -o piano.com
;   En DOSBox: piano
; ==================================

org 100h

msg db "Piano en ensamblador - Prueba sin sonido",13,10
    db "Presione A S D F G H J K L (ESC para salir)",13,10,"$"

keys db 'a','s','d','f','g','h','j','k','l',0
notes db "Do  Re  Mi  Fa  Sol La  Si  Do5 Re5",0

; -----------------------------------
start:
    mov ah, 09h
    mov dx, msg
    int 21h

main_loop:
    mov ah, 1
    int 16h         ; Chequear tecla
    jz main_loop    ; Si no hay, seguir

    mov ah, 0
    int 16h         ; Leer tecla
    mov bl, al

    cmp bl, 27      ; ESC = salir
    je salir

    mov ah, 02h
    mov dl, bl
    int 21h         ; Mostrar tecla presionada

    mov ah, 0Eh     ; Salto de línea
    mov al, 13
    int 10h
    mov al, 10
    int 10h

    jmp main_loop

salir:
    mov ah, 09h
    mov dx, fin
    int 21h

    mov ah, 7       ; Esperar una tecla antes de salir
    int 21h

    mov ax, 4C00h
    int 21h

fin db 13,10,"Saliendo del piano...$"
