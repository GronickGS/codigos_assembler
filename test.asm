section .bss
    digitSpace resb 100
    digitSpacePos resb 8

section .text
    global _start

_start:
    mov rax, 123
    call _printRAX

    mov rax, 60
    mov rdi, 0
    syscall

_printRAX:
    mov rsi, digitSpace   ; Usar rsi para mantener la dirección del buffer
    mov rbx, 10
    mov [rsi], rbx
    inc rsi               ; Incrementar rsi para apuntar al siguiente byte
    mov [digitSpacePos], rsi

    xor rdx, rdx
_printRAXLoop:
    mov rbx, 10
    div rbx
    add dl, 48

    mov rsi, [digitSpacePos]
    dec rsi               ; Retroceder una posición en el buffer
    mov [rsi], dl
    mov [digitSpacePos], rsi

    test rax, rax
    jnz _printRAXLoop

_printRAXLoop2:
    mov rsi, [digitSpacePos]

    mov rax, 1
    mov rdi, 1
    mov rdx, 1
    syscall

    dec rsi
    cmp rsi, digitSpace
    jge _printRAXLoop2

    ret
