.model small
.stack 100h
.data
    num1 db ?
    num2 db ?
    linea_vacia db 0Dh, 0Ah, '$'
    msg1 db 'Inserte primer numero$', 0Dh, 0Ah
    msg2 db 'Inserte segundo numero$', 0Dh, 0Ah
    resultado db 'Resultado: $'
    buffer db 5, 0
.code
main: 
    mov ax, @data  ; mover los datos al registro 
    mov ds, ax
    
    mov dx, offset msg1
    call imprimir
    
    call leer_dato
    
    sub al, '0'
    mov [num1], al
    
    mov dx, offset msg2
    call imprimir
    
    call leer_dato
    
    sub al, '0'      
    mov [num2], al
    
    mov al, [num1]
    add al, [num2]   ; AL = num1 + num2  ah = 0000 0000 al = 0000 0000 ax = ah + al
    
    ; Guardar el resultado en AX para dividir
    xor ah, ah       ; Limpiar AH (usar AX completo)
    mov bx, 10       ; Divisor para separar d?gitos

    ; Convertir a ASCII y almacenar en el buffer
    lea si, [buffer + 4] ; Apuntar al final del buffer 
    
convertir:
    xor dx, dx       ; Limpiar DX para dividir
    div bx           ; AX / BX -> Cociente en AL, residuo en DL
    add dl, '0'      ; Convertir residuo a ASCII
    mov [si], dl     ; Guardar d?gito en el buffer
    dec si           ; Mover al siguiente espacio en el buffer
    cmp ax, 0        ; ?Quedan m?s d?gitos?
    jne convertir

    ; Imprimir "Resultado: "
    mov dx, offset resultado
    call imprimir

    ; Imprimir los d?gitos del buffer
    lea si, [si + 1] ; Ajustar puntero al inicio del n?mero
    
imprimir_buffer:
    mov dl, [si]
    cmp dl, 0        ; ?Fin del n?mero?
    je fin
    mov ah, 02h      ; Funci?n para imprimir un car?cter
    int 21h
    inc si           ; Mover al siguiente car?cter
    jmp imprimir_buffer
    
      
fin:
    mov ax,4c00h ;terminacion
    int 21h
    
leer_dato:
    mov ah, 01h
    int 21h
    
    mov ah, 09h    ; Funcion de mostrar cadena
    lea dx, linea_vacia   ; Cargar direccion de la cadena
    int 21h
    ret

imprimir:
    mov ah, 09h     ; Interrupci?n DOS para imprimir cadena
    int 21h
    
    mov ah, 09h    ; Funcion de mostrar cadena
    lea dx, linea_vacia   ; Cargar direccion de la cadena
    int 21h
    ret
        
end main
