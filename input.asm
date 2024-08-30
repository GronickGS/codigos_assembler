section .data
    numero1 dd 10       ; Primer número a sumar
    numero2 dd 20       ; Segundo número a sumar
    resultado dd 0      ; Variable para almacenar el resultado de la suma

section .text
    global _start

_start:
    ; Cargar los valores de los números en registros
    mov eax, [numero1]   ; Cargar el primer número en el registro eax
    mov ebx, [numero2]   ; Cargar el segundo número en el registro ebx
    
    ; Sumar los números
    add eax, ebx         ; Sumar el contenido de eax y ebx
    
    ; Guardar el resultado en la variable resultado
    mov [resultado], eax ; Almacenar el resultado en la variable resultado

    ; Salir del programa
    mov eax, 60          ; Cargar el número de syscall para salir del programa en eax
    xor edi, edi         ; Limpiar edi (código de salida)
    syscall              ; Realizar la llamada al sistema para salir del programa
