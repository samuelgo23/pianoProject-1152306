<h1>Proyecto piano en ensamblador</h1>

<p>Este programa simula un pequeño piano de teclas hecho completamente en lenguaje ensamblador para MS-DOS.
Al ejecutarlo, puedes tocar notas musicales usando las teclas A S D F G H J K L, mientras que ESC sale del programa.
Las notas se reproducen mediante el altavoz interno del PC (PC speaker) usando instrucciones de bajo nivel.</p>

<p>A continuacion de lo que se espera al acabar el proyecto:</p>

<img src="img/mockup.png" alt="imagen de como quiero que quede">

<h2>🧠 Cómo funciona</h2>
Usa interrupciones del BIOS (INT 16h) para leer el teclado.

Genera sonido con los puertos 43h, 42h y 61h, que controlan el temporizador y el altavoz del sistema.

Cada tecla corresponde a una frecuencia diferente almacenada en una tabla (notes).

🚀 Posibles mejoras

Mostrar en pantalla el nombre de la nota presionada (por ejemplo: “C4”, “D4”, “E4”…).

Permitir cambiar la duración de las notas.

Agregar más octavas (teclas adicionales).

Implementar pausas o grabación de melodías.

Incluir colores y animaciones en texto para hacerlo más visual.