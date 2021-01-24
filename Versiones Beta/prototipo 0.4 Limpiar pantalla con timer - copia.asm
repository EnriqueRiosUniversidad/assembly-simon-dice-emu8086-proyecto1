.model small 
.stack 256

CR equ 13d
LF equ 10d
.data                               
    enter db CR,LF,0,'$'
  oracion_1 db "pepe*amarillo",0,'$'  
  oracion_2 db "tomas*rojo*juan",0,'$' 
  stringNivelSuperado db "NIVEL SUPERADO",CR,LF,0,'$'
  
  respuesta db 80 dup (0)            
  nivel     db 80 dup (0)
  
  tiempoPausa db 12
  
  
.code
    mov ax, @data
    mov ds, ax                         ;Oracion_1
                 ;Muestra la oracion y da enter.
    mov dx, offset oracion_1
    call showString          
    call saltoDeLinia  ;da un "Enter" 
    mov BL, 12         ;pausar el juego 12s     
    call pausarJuego 
    call limpiar_pantalla ;deja la pantalla en negro.   
                 ;Obtiene la respuesta.
    call getString 
    call saltoDeLinia
                 ;Compara Respuestas.
    mov bx, offset oracion_1
    call comparar
                 ;limpia pantalla si todo esta bien.
    call limpiarRespuesta
    
                                      ;Oracion_2  
                                      
    sub tiempoPausa, 6   ;disminuimos a la mitad el tiempo entre que se limpia pantalla                                                                                                       
    mov dx, offset oracion_2
    call showString 
    call saltoDeLinia
    call pausarJuego
    call limpiar_pantalla                                 
    ;---                                  
    call getString
    call saltoDeLinia
    ;---
    mov bx, offset oracion_2
    call comparar
    ;--
    call limpiarRespuesta
    
    
    
    
    call endGame









showString: ;Muestra un String cargado en dx.
    mov ah, 9h
    int 21h
    ret

saltoDeLinia:  ;da un salto de linia, Enter.
    mov dx, offset enter
    call showString
    ret



getString:
   mov bx, offset respuesta ;Cargamos el Array respuesta en bx
     loopGetString:
   call getC
   mov byte ptr [bx], al
   cmp byte ptr [bx], CR
   je retornoSimple  
     
     inc bx         ; bx+1
     jmp loopGetString
 
        
limpiarRespuesta:
     mov bx, offset respuesta  ; bx = respuesta[]
      loopClearString:
     cmp byte ptr [bx], 0 ;Null es = 0 ASCII
     je retornoSimple     ; array[bx]== 0 then retornar
     mov byte ptr [bx], 0
     inc bx               ; bx+1
     jmp loopClearString




limpiar_pantalla: ;limpia la pantalla
    push ax
    mov ax, 00h
    mov al, 03h
    int 10h
    pop ax
    ret




pausarJuego:        ;Saque este fracmento de codigo de la pagina
                    ;https://stackoverflow.com/questions/15201955/how-to-set-1-second-time-delay-at-assembly-language-8086
                    ;el codigo era corto y permitia pausar 1s, lo mejore para poder pausar un tiempo X que varie durante la
                    ;ejecusion 
    mov bl,  tiempoPausa                
    MOV     CX, 0FH
    MOV     DX, 4240H
    MOV     AH, 86H  
      loopPausa:
    cmp bl, 0
    je retornoSimple
    dec bl  
    INT     15H     ;ejecuta la interrupcion

    jmp loopPausa




cargarNivel: ;Suponiendo que el nivel esta cargado en ax
    
    mov SI, 0 
    mov bx, offset oracion_1
    
      loopCargarNivel:
    cmp byte ptr [bx], 0 
    
    je retornoSimple     
    mov al, byte ptr [bx]
    mov nivel [si], al
    jmp loopCargarNivel
     
 
 
 
 

 
     
comparar: ; la oracion del nivel se carga en bx
        mov SI, 0      
        
        loopComparar:    
        mov ch, byte ptr [bx]
     cmp respuesta [SI] , ch  
       
     jne endGame ;Termina el juego.
     inc bx
     inc SI
     cmp oracion_1[si], 0; termino la oracion del nivel actual.
      je nivelSuperado   ;Todos los elementos coinciden.
     jmp loopComparar ;Aun le quedan caracteres al nivel.
     
     
   nivelSuperado:
      mov dx, offset stringNivelSuperado
      call showString
      ret
              
              
              
              
;---Metodos basicos 
getC:                   
    mov ah, 1h
    int 21h
    ret
showC: ;Muestra caracter.
    mov ah,2h
    int 21h
    ret             
retornoSimple:
    ret
endGame:
    mov ax, 4c00h
    int 21H