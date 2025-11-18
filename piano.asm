; ==================================
; Piano completo con 10 teclas blancas y 7 negras
; ==================================

org 100h

start:
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
    
    ; === ESCRIBIR TEXTO EN MODO GRÁFICO ===
    call escribir_textos

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

escribir_textos:
    ; Título "Piano" en fila 1
    mov ah, 02h         ; Posicionar cursor
    mov bh, 0
    mov dh, 1           ; Fila 1
    mov dl, 37          ; Columna 37 (centrado)
    int 10h
    
    mov si, txt_piano
    mov bl, 15          ; Color blanco
    call escribir_string
    
    ; Teclas en fila 23
    mov ah, 02h
    mov bh, 0
    mov dh, 23
    mov dl, 1
    int 10h
    
    mov si, txt_teclas
    mov bl, 14          ; Color amarillo
    call escribir_string
    
    ; ESC en fila 24
    mov ah, 02h
    mov bh, 0
    mov dh, 24
    mov dl, 1
    int 10h
    
    mov si, txt_esc
    mov bl, 14
    call escribir_string
    
    ret

escribir_string:
    push ax
    push bx
    push si
.loop_char:
    lodsb               ; Cargar byte de [SI] en AL
    cmp al, 0           ; ¿Fin de string?
    je .fin
    mov ah, 0Eh         ; Función teletype
    mov bh, 0
    int 10h
    jmp .loop_char
.fin:
    pop si
    pop bx
    pop ax
    ret

mostrar_instrucciones:
    ret

salir_programa:
    mov ax, 0003h
    int 10h
    mov ax, 4C00h
    int 21h

; === DATOS ===
txt_piano db 'Piano',0
txt_teclas db 'Teclas: A S D F G H J K L ',164,' - W E T Y U I O',0
txt_esc db 'Pulsa ESC para salir',0