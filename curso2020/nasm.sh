#!/bin/bash

# Comprueba si se proporcionó un nombre de archivo como argumento
if [ $# -eq 0 ]; then
    echo "Uso: $0 <nombre_archivo_asm>"
    exit 1
fi

# Nombre del archivo de ensamblador
asm_file="$1"

# Comprueba si el archivo existe
if [ ! -f "$asm_file" ]; then
    echo "El archivo '$asm_file' no existe."
    exit 1
fi

# Extrae el nombre base del archivo sin la extensión
file_base=$(basename -s .asm "$asm_file")

# Crea una carpeta llamada "out" si no existe
mkdir -p out

# Compila el archivo de ensamblador
nasm -f elf64 -o "out/$file_base.o" "$asm_file"

# Enlaza el archivo objeto
ld "out/$file_base.o" -o "out/$file_base"

# Ejecuta el programa
"./out/$file_base"
