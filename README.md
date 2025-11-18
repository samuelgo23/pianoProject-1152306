🎹 Piano Virtual en Ensamblador x86
Piano Gráfico Interactivo para DOS / DOSBox

Ejecutable: piano3.com
Lenguaje: Ensamblador x86 (NASM)
Peso: ~500 bytes

📌 Descripción General

Este proyecto implementa un piano virtual completamente funcional escrito en ensamblador x86, usando:

Modo gráfico VGA 13h (320×200, 256 colores)

PC Speaker para generar sonido real

Entrada por teclado

Representación visual de teclas blancas y negras

El programa permite tocar 17 notas musicales desde C4 (Do) hasta E5 (Mi), mostrando un teclado gráfico interactivo.

🎯 Objetivo

Crear un piano virtual minimalista pero funcional, demostrando:

Dominio de gráficos VGA en modo 13h

Generación de sonido mediante el temporizador PIT 8253

Lectura directa del teclado

Optimización extrema en ensamblador x86 real-mode

✨ Características

🎨 Interfaz gráfica en VGA 13h

🎶 17 notas musicales (10 blancas + 7 negras)

🔊 PC Speaker controlado por puertos 42h/43h/61h

⚡ Código altamente optimizado (<500 bytes)

💻 Totalmente compatible con DOSBox

🎼 Distribución de Teclas
Teclas Blancas (Notas naturales)
Tecla	Nota	Frecuencia
A	C4	261.63 Hz
S	D4	293.66 Hz
D	E4	329.63 Hz
F	F4	349.23 Hz
G	G4	392.00 Hz
H	A4	440.00 Hz
J	B4	493.88 Hz
K	C5	523.25 Hz
L	D5	587.33 Hz
Ñ	E5	659.25 Hz
Teclas Negras (Sostenidos)
Tecla	Nota
W	C#4
E	D#4
T	F#4
Y	G#4
U	A#4
I	C#5
O	D#5
Control

ESC → Salir del programa

🛠 Instalación y Ejecución
✔ 1. Compilar
nasm -f bin piano.asm -o piano3.com

✔ 2. Ejecutar en DOSBox
mount c C:\ruta\al\proyecto
c:
piano3

🧩 Arquitectura del Sistema
┌───────────────────────────┐
│     Entrada del Usuario   │ (INT 16h)
└──────────────┬────────────┘
               │
┌──────────────▼────────────┐
│ Procesamiento de teclas   │
└──────────────┬────────────┘
               │
        ┌──────┴───────┐
        │              │
┌───────▼──────┐   ┌───▼──────────┐
│  PC Speaker   │   │ Gráficos VGA │
│ (Timer 8253)  │   │  (0A000h)    │
└───────────────┘   └──────────────┘

📐 Modo Gráfico 13h (VGA)

Resolución: 320×200

Colores: 256

Memoria: 0A000h:0000h

Offset pixel = y * 320 + x

Colores usados
Color	Uso
0	Fondo negro
8	Teclas negras
14	Texto
15	Teclas blancas
🔊 Sistema de Sonido

El piano usa el temporizador PIT 8253:

Puerto 43h → Control

Puerto 42h → Divisor

Puerto 61h → Encendido/apagado del speaker

Fórmula:

Frecuencia = 1193180 / divisor


Incluye 17 divisores precalculados para precisión.

⚙️ Optimización y Rendimiento

Optimizaciones implementadas:

Uso intensivo de registros en lugar de memoria

Dibujado acelerado con rep stosb

Protección de registros con push/pop

Cálculo eficiente de offsets

Teclas espaciadas visualmente (25 px c/u)

Consumo:

RAM: <1 KB

Tamaño ejecutable: ~500 bytes

Latencia sonora: ~65 ms

🧭 Problemas Resueltos
Problema	Causa	Solución
Bucle infinito	mul dañaba CX	push/pop
Colores incorrectos	AL modificado	guardar color
Teclas pegadas	ancho muy grande	espaciar 32px
Texto no visible	INT 10h incorrecto	teletype AH=0Eh
🚀 Mejoras Futuras

 Grabación y reproducción de notas

 Sostenido (SHIFT)

 Más octavas

 Sprites para texto

 Double buffering

 Sonido mejorado vía Sound Blaster

🏁 Conclusiones

Este proyecto demuestra que es posible crear un instrumento musical gráfico funcional en ensamblador puro, interactuando directamente con:

Hardware VGA

PC Speaker

BIOS

Puertos I/O

Es un ejercicio completo de:

Programación de bajo nivel

Control preciso de hardware

Optimización extrema

Diseño gráfico simple pero eficiente

📚 Anexos
Interrupciones usadas
INT	AH	Función	Uso
10h	00h	Modo video	VGA 13h
10h	02h	Cursor	Posición texto
10h	0Eh	Teletype	Texto
16h	00h	Leer tecla	Input
21h	4Ch	Exit	Finalizar
Puertos I/O
Puerto	Uso
42h	Divisor del timer
43h	Registro de control
61h	Control del speaker