; ==================================
; Piano completo con 10 teclas blancas y 7 negras
; ==================================

org 100h

start:
    ; Mostrar pantalla de instrucciones
    call mostrar_instrucciones
    
    ; Modo gráfico 13h
    mov ax, 0013h
    int 10h
    
    ; Segmento de video
    mov ax, 0A000h
    mov es, ax
    
    ; === DIBUJAR 10 TECLAS BLANCAS ===
    mov bx, 20
    mov si, 30
    mov di, 150
    mov al, 15
    mov bp, 25
    call dibujar_rect
    
    mov bx, 52
    mov si, 30
    mov di, 150
    mov al, 15
    mov bp, 25
    call dibujar_rect
    
    mov bx, 84
    mov si, 30
    mov di, 150
    mov al, 15
    mov bp, 25
    call dibujar_rect
    
    mov bx, 116
    mov si, 30
    mov di, 150
    mov al, 15
    mov bp, 25
    call dibujar_rect
    
    mov bx, 148
    mov si, 30
    mov di, 150
    mov al, 15
    mov bp, 25
    call dibujar_rect
    
    mov bx, 180
    mov si, 30
    mov di, 150
    mov al, 15
    mov bp, 25
    call dibujar_rect
    
    mov bx, 212
    mov si, 30
    mov di, 150
    mov al, 15
    mov bp, 25
    call dibujar_rect
    
    mov bx, 244
    mov si, 30
    mov di, 150
    mov al, 15
    mov bp, 25
    call dibujar_rect
    
    mov bx, 276
    mov si, 30
    mov di, 150
    mov al, 15
    mov bp, 25
    call dibujar_rect
    
    mov bx, 308
    mov si, 30
    mov di, 150
    mov al, 15
    mov bp, 25
    call dibujar_rect
    
    ; === DIBUJAR 7 TECLAS NEGRAS ===
    mov bx, 38
    mov si, 30
    mov di, 90
    mov al, 8
    mov bp, 15
    call dibujar_rect
    
    mov bx, 70
    mov si, 30
    mov di, 90
    mov al, 8
    mov bp, 15
    call dibujar_rect
    
    mov bx, 134
    mov si, 30
    mov di, 90
    mov al, 8
    mov bp, 15
    call dibujar_rect
    
    mov bx, 166
    mov si, 30
    mov di, 90
    mov al, 8
    mov bp, 15
    call dibujar_rect
    
    mov bx, 198
    mov si, 30
    mov di, 90
    mov al, 8
    mov bp, 15
    call dibujar_rect
    
    mov bx, 262
    mov si, 30
    mov di, 90
    mov al, 8
    mov bp, 15
    call dibujar_rect
    
    mov bx, 294
    mov si, 30
    mov di, 90
    mov al, 8
    mov bp, 15
    call dibujar_rect

; === BUCLE PRINCIPAL ===
bucle:
    mov ah, 0
    int 16h
    
    cmp al, 27
    je salir_programa
    
    cmp al, 'a'
    je nota_c
    cmp al, 's'
    je nota_d
    cmp al, 'd'
    je nota_e
    cmp al, 'f'
    je nota_f
    cmp al, 'g'
    je nota_g
    cmp al, 'h'
    je nota_a
    cmp al, 'j'
    je nota_b
    cmp al, 'k'
    je nota_c2
    cmp al, 'l'
    je nota_d2
    cmp al, 164
    je nota_e2
    
    cmp al, 'w'
    je nota_cs
    cmp al, 'e'
    je nota_ds
    cmp al, 't'
    je nota_fs
    cmp al, 'y'
    je nota_gs
    cmp al, 'u'
    je nota_as
    cmp al, 'i'
    je nota_cs2
    cmp al, 'o'
    je nota_ds2
    
    jmp bucle

nota_c:
    mov ax, 4545
    call tocar_beep
    jmp bucle
nota_d:
    mov ax, 4049
    call tocar_beep
    jmp bucle
nota_e:
    mov ax, 3607
    call tocar_beep
    jmp bucle
nota_f:
    mov ax, 3400
    call tocar_beep
    jmp bucle
nota_g:
    mov ax, 3030
    call tocar_beep
    jmp bucle
nota_a:
    mov ax, 2703
    call tocar_beep
    jmp bucle
nota_b:
    mov ax, 2407
    call tocar_beep
    jmp bucle
nota_c2:
    mov ax, 2272
    call tocar_beep
    jmp bucle
nota_d2:
    mov ax, 2024
    call tocar_beep
    jmp bucle
nota_e2:
    mov ax, 1804
    call tocar_beep
    jmp bucle

nota_cs:
    mov ax, 4290
    call tocar_beep
    jmp bucle
nota_ds:
    mov ax, 3822
    call tocar_beep
    jmp bucle
nota_fs:
    mov ax, 3214
    call tocar_beep
    jmp bucle
nota_gs:
    mov ax, 2863
    call tocar_beep
    jmp bucle
nota_as:
    mov ax, 2551
    call tocar_beep
    jmp bucle
nota_cs2:
    mov ax, 2145
    call tocar_beep
    jmp bucle
nota_ds2:
    mov ax, 1911
    call tocar_beep
    jmp bucle

; === FUNCIONES ===
dibujar_rect:
    pusha
    mov dh, al
    mov cx, di
.fila:
    push cx
    push si
    push bx
    mov ax, si
    push dx
    mov dx, 320
    mul dx
    pop dx
    add ax, bx
    mov di, ax
    mov cx, bp
    mov al, dh
.pixel:
    stosb
    loop .pixel
    pop bx
    pop si
    pop cx
    inc si
    loop .fila
    popa
    ret

tocar_beep:
    push ax
    push bx
    push cx
    mov bx, ax
    mov al, 0B6h
    out 43h, al
    mov ax, bx
    out 42h, al
    mov al, ah
    out 42h, al
    in al, 61h
    or al, 03h
    out 61h, al
    mov cx, 0FFFFh
.espera_beep:
    loop .espera_beep
    in al, 61h
    and al, 0FCh
    out 61h, al
    pop cx
    pop bx
    pop ax
    ret

mostrar_instrucciones:
    mov ah, 09h
    mov dx, msg_titulo
    int 21h
    mov ah, 09h
    mov dx, msg_blancas
    int 21h
    mov ah, 09h
    mov dx, msg_negras
    int 21h
    mov ah, 09h
    mov dx, msg_esc
    int 21h
    mov ah, 09h
    mov dx, msg_continuar
    int 21h
    mov ah, 0
    int 16h
    ret

salir_programa:
    mov ax, 0003h
    int 10h
    mov ax, 4C00h
    int 21h

; === DATOS ===
msg_titulo db 13,10,'         Piano en Ensamblador',13,10,10,'$'
msg_blancas db ' Teclas blancas: A S D F G H J K L N',13,10,'$'
msg_negras db ' Teclas negras:  W E   T Y U I O',13,10,10,'$'
msg_esc db ' Presiona ESC para salir',13,10,10,'$'
msg_continuar db ' Presiona cualquier tecla para comenzar...$'