.model small
.stack 100h
.data
    mensaje db 'resultado: $'
    resultado db '0$'   ; cadena para el resultado (en formato ascii)

.code
inicio:
    mov ax, @data        ; inicializa el segmento de datos
    mov ds, ax
    mov es, ax

    ; pasa los valores 5 y 3 a la pila
    mov ax, 3
    push ax             ; apilar el primer valor (3) sp + 4

    mov ax, 5
    push ax             ; apilar el segundo valor (5) sp + 2

    ; llama a la subrutina que realiza la suma  sp 
    call sumar

    ; el resultado de la suma queda en ax, lo convertimos a ascii
    add al, '0'          ; convierte el n?mero a car?cter ascii (solo d?gitos 0-9)
    mov resultado, al    ; guarda el resultado en la variable 'resultado'

    ; muestra el mensaje "resultado: " por pantalla
    mov dx, offset mensaje
    mov ah, 09h
    int 21h

    ; muestra el resultado por pantalla
    mov dx, offset resultado
    mov ah, 09h
    int 21h

    ; finaliza el programa
    mov ax, 4c00h
    int 21h

; -----------------------------------
; subrutina para sumar dos n?meros
; -----------------------------------
sumar:
    push bp            ; guarda el valor original de bp
    mov bp, sp         ; bp apunta al comienzo del marco de pila  

    ; recupera los par?metros desde la pila usando bp
    mov ax, [bp+4]     ; primer n?mero (5)
    mov bx, [bp+6]     ; segundo n?mero (3)

    ; realiza la suma y deja el resultado en ax
    add ax, bx

    pop bp             ; restaura el valor original de bp
    ret                ; vuelve al punto de llamada

end inicio
