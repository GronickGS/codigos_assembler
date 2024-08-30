section .data
    texto db "Hola, Mundo!", 10 ; Definición de una cadena de caracteres llamada "texto" con el contenido "Hola, Mundo!"
                            ; db: define bytes, lo que significa que estamos asignando espacio para caracteres en la memoria.

section .text
    global _start 	; Declaración de "_start" como el punto de entrada del programa.

_start:
    mov rax, 1		; Mover el valor 1 al registro RAX. Este valor corresponde al número de llamada al sistema (syscall)
            		; que indica que queremos realizar la operación de escritura en la salida estándar (stdout).
    mov rdi, 1      ; Mover el valor 1 al registro RDI, que es el primer argumento para la syscall. Indica que queremos escribir en stdout.
    mov rsi, texto  ; Mover la dirección de memoria de la cadena "texto" al registro RSI, que es el segundo argumento para la syscall.
    mov rdx, 12     ; Mover el valor 12 al registro RDX, que es el tercer argumento para la syscall.
                    ; Indica la longitud de la cadena que queremos escribir.
    syscall         ; Realizar la llamada al sistema para escribir en la salida estándar.

    mov rax, 60     ; Mover el valor 60 al registro RAX. Este valor corresponde al número de llamada al sistema para "exit".
    mov rdi, 0      ; Mover el valor 0 al registro RDI, que es el argumento para la syscall "exit".
    syscall         ; Realizar la llamada al sistema para salir del programa.
