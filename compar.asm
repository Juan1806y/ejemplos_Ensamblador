.model small
.stack 100h
.data
    mensaje1 db 'El valor es mayor.$'
    mensaje2 db 'El valor es menor.$'
    mensaje3 db 'El valor es igual.$'
    valor1 db 1
    valor2 db 2
.code
main: 
    mov ax, @data
    mov ds, ax

; Inicializamos los registros
    mov al, valor1   ; Valor 1 en AX
    mov bl, valor2   ; Valor 2 en BX
    cmp al, bl    ; compara el valor1 con el valor2
    jg es_mayor   ; Salta a 'es_mayor' si AX > BX
    jl es_menor   ; Salta a 'es_menor' si AX < BX
    je es_igual   ; Salta a 'es_igual' si AX = BX

es_mayor:
    ; Bloque IF (AX > BX)
    lea dx, mensaje1   ; Cargar mensaje "El valor es mayor."
    mov ah, 09h        ; Funci?n para mostrar cadena
    int 21h            ; Interrupci?n de DOS para imprimir
    
    jmp fin
    
es_menor:
    ; Bloque IF (AX < BX)
    lea dx, mensaje2
    mov ah, 09h        ; Funcion para mostrar cadena
    int 21h
    
    jmp fin
    
es_igual:
    ; Bloque IF (AX = BX)
    lea dx, mensaje3  
    mov ah, 09h        ; Funcion para mostrar cadena
    int 21h
    
    jmp fin

fin:
    ; Salida del programa
    mov ax, 4C00h        ; Funcion para salir
    int 21h            ; Interrupcion de DOS
        
end main