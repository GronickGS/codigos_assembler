section .data
    hello db 'Hello, world!', 10 ; 10 es el carácter de nueva línea (LF)

section .text
    global _start

_start:
    ; Escribir el mensaje en la consola
    mov eax, 4          ; Syscall número 4: sys_write
    mov ebx, 1          ; File descriptor 1: STDOUT
    mov ecx, hello      ; Dirección del mensaje
    mov edx, 13         ; Longitud del mensaje
    int 0x80            ; Llamada al sistema

    ; Salir del programa
    mov eax, 1          ; Syscall número 1: sys_exit
    xor ebx, ebx        ; Código de salida 0 (éxito)
    int 0x80            ; Llamada al sistema
