section .data
    D dd 10000   ; Distancia a recorrer en metros
    x dd 120     ; Velocidad de la persona 1 en metros/minuto (liebre)
    y dd 100     ; Velocidad de la persona 2 en metros/minuto (tortuga)
    mensaje_persona1 db "Persona 1 (Liebre) gana la carrera", 0xA  ; Mensaje de ganador para persona 1
    mensaje_persona2 db "Persona 2 (Tortuga) gana la carrera", 0xA  ; Mensaje de ganador para persona 2
    mensaje_empate db "La carrera termina en empate", 0xA  ; Mensaje de empate

section .text
    global _start

_start:
    ; Calcular tiempos
    mov eax, D       ; Cargar la distancia en eax
    mov ebx, x       ; Cargar la velocidad de la persona 1 en ebx
    div ebx          ; Dividir la distancia por la velocidad de la persona 1
    mov ecx, eax     ; Almacenar el tiempo de la persona 1 (liebre) en ecx

    mov eax, D       ; Cargar la distancia en eax
    mov ebx, y       ; Cargar la velocidad de la persona 2 en ebx
    div ebx          ; Dividir la distancia por la velocidad de la persona 2
    mov edx, eax     ; Almacenar el tiempo de la persona 2 (tortuga) en edx

    ; Comparar velocidades
    cmp x, y         ; Comparar las velocidades de las personas
    jg persona1_gana  ; Si la velocidad de la persona 1 (liebre) es mayor, salta a persona1_gana
    jl persona2_gana  ; Si la velocidad de la persona 2 (tortuga) es mayor, salta a persona2_gana

    ; Si no, es un empate
    mov eax, 4                 ; syscall número 4: sys_write
    mov ebx, 1                 ; descriptor de archivo 1: STDOUT
    mov ecx, mensaje_empate    ; dirección del mensaje
    mov edx, 29                ; longitud del mensaje
    int 0x80                   ; Llamada al sistema
    jmp fin                    ; Salir del programa

persona1_gana:
    ; Imprimir mensaje de ganador (Persona 1 - Liebre)
    mov eax, 4                 ; syscall número 4: sys_write
    mov ebx, 1                 ; descriptor de archivo 1: STDOUT
    mov ecx, mensaje_persona1 ; dirección del mensaje
    mov edx, 40                ; longitud del mensaje
    int 0x80                   ; Llamada al sistema
    jmp fin                    ; Salir del programa

persona2_gana:
    ; Imprimir mensaje de ganador (Persona 2 - Tortuga)
    mov eax, 4                 ; syscall número 4: sys_write
    mov ebx, 1                 ; descriptor de archivo 1: STDOUT
    mov ecx, mensaje_persona2 ; dirección del mensaje
    mov edx, 40                ; longitud del mensaje
    int 0x80                   ; Llamada al sistema

fin:
    ; Salir del programa
    mov eax, 1                 ; syscall número 1: sys_exit
    xor ebx, ebx               ; código de salida 0 (éxito)
    int 0x80                   ; Llamada al sistema
