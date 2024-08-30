BITS 32  ; Cambiar a modo de 32 bits

SYS_EXIT equ 1
SYS_READ equ 3
SYS_WRITE equ 4
STDIN equ 0
STDOUT equ 1

section .data
    msg_radius db "Ingrese el radio de la base del cilindro (0..9): ", 0xA, 0xD
    len_radius equ $ - msg_radius
    
    msg_height db "Ingrese la altura del cilindro (0..9): ", 0xA, 0xD
    len_height equ $ - msg_height
    
    msg_volume db "El volumen del cilindro es: ", 0xA, 0xD
    len_volume equ $ - msg_volume
    
    pi dd 314159        ; Aproximación de pi (3.14159) multiplicada por 100,000 para mantener precisión
                        ; (Pi * 100,000 para evitar el uso de números de punto flotante)
    
section .bss
    radius resb 2       ; Almacenará el radio ingresado por el usuario
    height resb 2       ; Almacenará la altura ingresada por el usuario
    volume resd 1       ; Almacenará el volumen calculado
    
section .text
    global _start
    
_start:
    ; Solicitar al usuario que ingrese el radio de la base del cilindro
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, msg_radius
    mov edx, len_radius
    int 0x80
    
    ; Leer el radio de la base del cilindro desde la entrada estándar
    mov eax, SYS_READ
    mov ebx, STDIN
    mov ecx, radius
    mov edx, 2
    int 0x80
    
    ; Solicitar al usuario que ingrese la altura del cilindro
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, msg_height
    mov edx, len_height
    int 0x80
    
    ; Leer la altura del cilindro desde la entrada estándar
    mov eax, SYS_READ
    mov ebx, STDIN
    mov ecx, height
    mov edx, 2
    int 0x80
    
    ; Convertir los valores ingresados a enteros
    mov eax, [radius]
    call convert_to_int
    mov dword [radius], eax
    
    mov eax, [height]
    call convert_to_int
    mov dword [height], eax
    
    ; Calcular el volumen del cilindro (V = pi * r^2 * h)
    mov eax, [radius]
    mul dword [radius]          ; r^2
    imul eax, dword [height]    ; r^2 * h
    imul eax, dword [pi]        ; pi * r^2 * h
    mov dword [volume], eax
    
    ; Mostrar el resultado del cálculo del volumen
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, msg_volume
    mov edx, len_volume
    int 0x80
    
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, volume
    call print_int
    int 0x80
    
    ; Salir del programa
    mov eax, SYS_EXIT
    xor ebx, ebx            ; Código de retorno (0 = sin errores)
    int 0x80

convert_to_int:
    ; Convierte la cadena ASCII en un número entero
    ; Entradas:
    ;   EAX: Puntero a la cadena ASCII
    ; Salidas:
    ;   EAX: Valor entero resultante
    ;   ECX: Puntero al siguiente carácter después del número
    xor eax, eax
    xor ecx, ecx
    .convert_loop:
        movzx edx, byte [eax + ecx]
        cmp edx, 0
        je .convert_done
        sub edx, '0'
        imul eax, 10
        add eax, edx
        inc ecx
        jmp .convert_loop
    .convert_done:
    ret

print_int:
    ; Imprime un número entero en stdout
    ; Entradas:
    ;   EAX: Número entero a imprimir
    ; Salidas:
    ;   Ninguna
    xor edx, edx
    mov ecx, 10
    .print_digit:
        xor ebx, ebx
        div ecx
        add dl, '0'
        push edx
        inc ecx
        test eax, eax
        jnz .print_digit
    .print_loop:
        pop edx
        mov eax, SYS_WRITE
        mov ebx, STDOUT
        mov ecx, edx
        mov edx, 1
        int 0x80
        loop .print_loop
    ret
