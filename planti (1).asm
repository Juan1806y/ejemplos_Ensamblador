.model small
.stack 100h
.data
    str1 db 'basta$' ; mensaje
.code
main: 
    mov ax, @data  ; mover los datos al registro
    mov ds, ax
    
    mov ah, 09h    ; Funcion de mostrar cadena
    lea dx, str1 ; Cargar direccion de la cadena
    int 21h
    
    jmp fin
    
fin:
    mov ax,4c00h ;terminacion
    int 21h
        
end main

; falta
; operaciones aritmeticas (+ - * /)
; profundizar en ciclos
; vectores y matrices (arreglos)
; entradas en consola (pantalla y teclado)
; corrimientos y rotaciones 