.model small
.stack 100h

.data
    str1 db '10000', 0         ; Primera cadena
    str2 db '8000', 0         ; Segunda cadena
    result dw 0             ; Resultado num?rico
    resultStr db 'Resultado: $'
    buffer db 6 dup(0)      ; Buffer para resultado (5 d?gitos + '$')

.code
main proc
    mov ax, @data
    mov ds, ax              ; Inicializar segmento de datos

    ; Convertir str1 a n?mero
    lea si, str1
    xor ax, ax              ; Limpiar AX

convert_loop1:
    mov cl, [si]            ; Cargar un byte en CL
    test cl, cl             ; Verificar fin de cadena cx = 0000 0000 0000 0011
    jz convert_str2

    sub cl, '0'             ; Convertir ASCII a n?mero
    
    ; Multiplicar AX por 10
    mov dx, ax              ; Guardar valor original
    shl ax, 3               ; AX * 8
    add ax, dx              ; + AX original (AX * 9)
    add ax, dx              ; + AX original (AX * 10)
    
    xor ch, ch              ; Limpiar CH
    add ax, cx              ; A?adir nuevo d?gito

    inc si
    jmp convert_loop1

convert_str2:
    mov cx, ax              ; Guardar primer n?mero
    lea si, str2
    xor ax, ax              ; Limpiar AX para segundo n?mero

convert_loop2:
    mov bl, [si]            ; Cargar un byte en BL
    test bl, bl             ; Verificar fin de cadena
    jz sum_numbers

    sub bl, '0'             ; Convertir ASCII a n?mero
    
    ; Multiplicar AX por 10
    mov dx, ax              ; Guardar valor original
    shl ax, 3               ; AX * 8
    add ax, dx              ; + AX original (AX * 9)
    add ax, dx              ; + AX original (AX * 10)
    
    xor bh, bh              ; Limpiar BH
    add ax, bx              ; A?adir nuevo d?gito

    inc si
    jmp convert_loop2

sum_numbers:
    add ax, cx              ; Sumar los dos n?meros
    mov result, ax

    ; Convertir resultado a string
    mov bx, 10              ; Divisor
    lea si, buffer
    add si, 5               ; Apuntar al final del buffer
    mov byte [si], '$'      ; Agregar terminador
    dec si

convert_to_string:
    xor dx, dx
    div bx                  ; Dividir por 10
    add dl, '0'            ; Convertir a ASCII
    mov [si], dl           ; Guardar en buffer
    dec si
    test ax, ax            ; Verificar si terminamos
    jnz convert_to_string

    ; Mostrar resultado
    mov dx, offset resultStr
    mov ah, 9
    int 21h                ; Mostrar "Resultado: "

    inc si                 ; Mover al primer d?gito
    mov dx, si
    mov ah, 9
    int 21h                ; Mostrar el n?mero

    mov ax, 4C00h
    int 21h                ; Terminar programa
main endp
end main