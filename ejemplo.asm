.model small                   ; Define el modelo de memoria como peque?o.
.stack 100h                    ; Reserva 256 bytes para la pila (100h en hexadecimal).

.data

    ; Declaracion de los mensajes 
    msj1 db 'Ejemplo suma$', 0Dh, 0Ah          
    msj2 db 'Ejemplo resta$', 0Dh, 0Ah         
    msj3 db 'Ejemplo resta negativa$', 0Dh, 0Ah
    msj4 db 'Ejemplo multiplicacion$', 0Dh, 0Ah
    msj5 db 'Ejemplo multiplicacion negativa$', 0Dh, 0Ah
    msj6 db 'Ejemplo division$', 0Dh, 0Ah       
    msj7 db 'Ejemplo division negativa$', 0Dh, 0Ah
    resultado db 'Resultado: $'   
    
    buffer db '     $'            ; Buffer para almacenar el resultado convertido a caracteres (5 espacios).
    signo db '-$'              
    linea_vacia db 0Dh, 0Ah, '$' 

.code
main:

    mov ax, @data              ; Cargar el segmento de datos en AX.
    mov ds, ax                 ; Mover el contenido de AX al registro DS para acceder a los datos.

suma:
    
    mov dx, offset msj1       ; Cargar la direcci?n del mensaje
    call imprimir              ; Llamar a la rutina para imprimir el mensaje.
    
    ; Realizar la suma
    mov al, 30                 ; al = 30
    add al, 10                 ; al = 40 (30 + 10)
    
    mov dx, offset resultado   
    call imprimir              ; Imprimir el resultado de la suma.
    
    call limpiar_buffer         ; Llamar a la rutina para limpiar el buffer antes de usarlo.
    xor ah, ah                 ; Limpiar AH (ponerlo a cero).
    mov bx, 10                 ; Configurar el divisor para la conversi?n a decimal.

    lea si, [buffer + 1]       ; Cargar la direcci?n del buffer (desplazado 1) en SI.
    call convertir              ; Llamar a la rutina para convertir el resultado a ASCII.
    mov si, offset buffer       
    call imprimir_buffer        ; Imprimir el buffer con el resultado.

resta:
    
    mov dx, offset msj2        
    call imprimir              ; Imprimir el mensaje de resta.
    
    ; Realizar la resta
    mov al, 10                 ; al = 10
    sub al, 4                  ; al = 6 (10 - 4)
    
    mov dx, offset resultado   
    call imprimir              ; Imprimir el resultado de la resta.
    
    call limpiar_buffer         ; Limpiar el buffer antes de usarlo.
    xor ah, ah                 
    mov bx, 10                 ; Configurar el divisor para la conversi?n a decimal.

    lea si, [buffer + 1]       ; Cargar la direcci?n del buffer en SI.
    call convertir              ; Convertir el resultado a ASCII.
    
    mov si, offset buffer       
    call imprimir_buffer        ; Imprimir el buffer con el resultado.

resta_con_signo:
    
    mov dx, offset msj3        
    call imprimir              ; Imprimir el mensaje de resta con signo.
    
    ; Realizar la resta que da un resultado negativo
    mov al, 4                  ; al = 4
    sub al, 5                  ; al = -1 (4 - 5)
    
    mov dx, offset resultado    
    call imprimir              ; Imprimir el resultado de la resta negativa.
    
    ; Imprimir signo negativo
    mov ah, 09h                
    lea dx, signo              ; Cargar la direcci?n del signo en DX.
    int 21h                    ; Interrupci?n para imprimir el signo.

    call limpiar_buffer         ; Limpiar el buffer antes de usarlo.
    xor ah, ah                 
    mov bx, 10                 ; Configurar el divisor para la conversi?n a decimal.

    lea si, [buffer + 1]       ; Cargar la direcci?n del buffer en SI.
    neg al                     ; Negar el valor en AL (hacerlo negativo). 
    call convertir              ; Convertir el resultado a ASCII.
    
    mov si, offset buffer       
    call imprimir_buffer        ; Imprimir el buffer con el resultado.

multiplicacion:
    
    mov dx, offset msj4        
    call imprimir              ; Imprimir el mensaje de multiplicaci?n.
    
    ; Realizar la multiplicaci?n
    mov al, 5                  ; Cargar el valor 5 en AL.
    mov bl, 2                  ; Cargar el valor 2 en BL.
    mul bl                     ; Multiplicar AL por BL (ax = al * bl), resultado en AX.
    
    mov dx, offset resultado    
    call imprimir              ; Imprimir el resultado de la multiplicaci?n.
    
    call limpiar_buffer         ; Limpiar el buffer antes de usarlo.
    xor ah, ah                 
    mov bx, 10      
    
    lea si, [buffer + 1]       
    call convertir              ; Convertir el resultado a ASCII.
    
    mov si, offset buffer       
    call imprimir_buffer        ; Imprimir el buffer con el resultado.

multiplicacion_con_signo:
    
    mov dx, offset msj5        
    call imprimir              ; Imprimir el mensaje de multiplicaci?n con signo.
    
    ; Realizar la multiplicaci?n que da un resultado negativo
    mov al, 5                  ; Cargar el valor 5 en AL.
    mov bl, -3                 ; Cargar el valor -3 en BL.
    imul bl                    ; Multiplicar AL por BL (5 * -3 = -15).
    
    mov dx, offset resultado    
    call imprimir              ; Imprimir el resultado de la multiplicaci?n negativa.
    
    ; Imprimir signo negativo
    mov ah, 09h                
    lea dx, signo              
    int 21h                    ; Interrupci?n para imprimir el signo.

    call limpiar_buffer         ; Limpiar el buffer antes de usarlo.
    xor ah, ah                 
    mov bx, 10 
    
    lea si, [buffer + 1]       
    neg al                     ; Negar el valor en AL (hacerlo negativo).
    call convertir              ; Convertir el resultado a ASCII.
    
    mov si, offset buffer       
    call imprimir_buffer        ; Imprimir el buffer con el resultado.

division:
    
    mov dx, offset msj6        
    call imprimir              ; Imprimir el mensaje de divisi?n.
    
    ; Realizar la divisi?n
    mov ax, 10                 ; Cargar el valor 10 en AX (dividendo).
    mov bl, 2                  ; Cargar el valor 2 en BL (divisor).
    div bl                     ; Dividir AX por BL (cociente en AL, resto en AH).
    
    mov dx, offset resultado    
    call imprimir              ; Imprimir el resultado de la divisi?n.
    
    call limpiar_buffer         ; Limpiar el buffer antes de usarlo.
    xor ah, ah                 
    mov bx, 10
    
    lea si, [buffer + 1]     
    call convertir              ; Convertir el resultado a ASCII.
    
    mov si, offset buffer       
    call imprimir_buffer        ; Imprimir el buffer con el resultado.

division_con_signo:
    
    mov dx, offset msj7        
    call imprimir              ; Imprimir el mensaje de divisi?n con signo.
    
    ; Realizar la divisi?n que da un resultado negativo
    mov ax, -14                ; Cargar el valor -14 en AX (dividendo).
    mov bl, 2                  ; Cargar el valor 2 en BL (divisor).
    idiv bl                    ; Dividir AX por BL, cociente en AL, resto en AH.
    
    mov dx, offset resultado    
    call imprimir              ; Imprimir el resultado de la divisi?n negativa.
    
    ; Imprimir signo negativo
    mov ah, 09h                
    lea dx, signo              
    int 21h                    ; Interrupci?n para imprimir el signo.

    call limpiar_buffer         ; Limpiar el buffer antes de usarlo.
    xor ah, ah                 
    mov bx, 10                 
    
    lea si, [buffer + 1]       
    neg al                     ; Negar el valor en AL (hacerlo negativo). 
    call convertir              ; Convertir el resultado a ASCII.
   
    mov si, offset buffer       
    call imprimir_buffer        ; Imprimir el buffer con el resultado.

fin:
    
    mov ax, 4c00h              ; Terminar el programa y devolver al DOS.
    int 21h                    ; Interrupci?n para salir.

imprimir:
    
    mov ah, 09h                ; Configurar AH para imprimir un string.
    int 21h                    ; Interrupci?n para imprimir el string en DX.
    lea dx, linea_vacia        ; Cargar la l?nea vac?a en DX.
    int 21h                    ; Imprimir la l?nea vac?a.
    ret                         ; Retornar a la llamada.

convertir:
    
    xor dx, dx                 ; Limpiar DX (necesario para la divisi?n).
    div bx                     ; Dividir AX por BX (el residuo va a DL).
    add dl, '0'                ; Convertir el n?mero en DL a car?cter ASCII.
    mov [si], dl               ; Almacenar el car?cter en el buffer.
    dec si                     ; Decrementar SI para apuntar a la siguiente posici?n.
    cmp ax, 0                  ; Verificar si AX es cero.
    jne convertir               ; Si no es cero, seguir dividiendo y convirtiendo.
    lea si, [si + 1]           ; Ajustar SI para apuntar al primer car?cter del n?mero.
    ret                         ; Retornar a la llamada.

imprimir_buffer:
    
    mov dl, [si]               ; Cargar el car?cter apuntado por SI en DL.
    cmp dl, '$'                ; Comprobar si es el final del buffer.
    je retorno                 ; Si es el final, retornar.
    mov ah, 02h                ; Configurar AH para imprimir un car?cter.
    int 21h                    ; Interrupci?n para imprimir el car?cter en DL.
    inc si                     ; Incrementar SI para apuntar al siguiente car?cter.
    jmp imprimir_buffer        ; Volver a imprimir el siguiente car?cter.

retorno:
    
    mov ah, 09h                ; Configurar AH para imprimir un string.
    lea dx, linea_vacia        ; Cargar la l?nea vac?a en DX.
    int 21h                    ; Imprimir la l?nea vac?a.
    ret                         ; Retornar a la llamada.

limpiar_buffer:
    
    mov cx, 5                  ; Configurar el contador para limpiar 5 caracteres.
    lea di, buffer             ; Cargar la direcci?n del buffer en DI.
    
llenar: 
    
    mov byte ptr [di], ' '     ; Llenar el buffer con espacios.
    inc di                     ; Incrementar DI para la siguiente posici?n.
    loop llenar                ; Repetir hasta que CX llegue a cero.
    ret                         ; Retornar a la llamada.

end main
