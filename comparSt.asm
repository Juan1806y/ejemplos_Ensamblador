.model small
.stack 100h
.data
    string1 db 'Hola$', 0  ; Cadena 1 terminada en '$'
    string2 db 'Hola$', 0  ; Cadena 2 terminada en '$'
    iguales  db 'Las cadenas son iguales.$'
    diferentes db 'Las cadenas son diferentes.$'

.code
main:
    ; Inicializa registros y segmentos
    mov ax, @data
    mov ds, ax

    ; Comienza la comparaci?n de las dos cadenas
    lea si, string1      ; Cargar direccion de string1 en SI [i = 0]
    lea di, string2      ; Cargar direccion de string2 en DI [j = 0]

comparar:
    mov al, [si]         ; Cargar caracter actual de string1 en AL
    mov bl, [di]         ; Cargar caracter actual de string2 en BL
    cmp al, bl           ; Comparar ambos caracteres
    jne son_diferentes   ; Si son diferentes, saltar a "son_diferentes"

    ; Si encontramos el final de ambas cadenas, son iguales
    cmp al, '$'          ; ?Es el final de la cadena?
    je son_iguales       ; Si es '$', son iguales

    ; Avanzar al siguiente car?cter
    inc si ;i++
    inc di ;j++
    jmp comparar         ; Volver al inicio del bucle

son_diferentes:
    lea dx, diferentes   ; Cargar mensaje "diferentes"
    jmp imprimir

son_iguales:
    lea dx, iguales      ; Cargar mensaje "iguales"

imprimir:
    mov ah, 09h          ; Funcion DOS para imprimir cadena
    int 21h              ; Llamada a interrupcion

    ; Salir del programa
    mov ax, 4C00h
    int 21h

end main
