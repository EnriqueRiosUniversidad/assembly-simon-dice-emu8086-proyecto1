.model small 
.stack 256

CR equ 13d
LF equ 10d
.data                               
    enter db CR,LF,0,'$' 
                      ;---ORACIONES--;
  oracion_1             db "pepe*amarillo",0,'$'  
  oracion_2             db "tomas*rojo*juan",0,'$'      
                      ;---STRINGS---;
  stringNivelSuperado       db "NIVEL SUPERADO",0,'$'
  stringNivelNoSuperado     db "NIVEL NO SUPERADO, cantidad de derrotas: ",0,'$'  
  stringVictorias           db "  Numero de victorias: ",0,'$'
  stringDerrotas            db "  Numero de Derrotas: ",0,'$'
                                                             
                                                             
  respuesta db 80 dup (0)            
  nivel     db 80 dup (0)
  
  tiempoPausa db 6      ;Tiempo que tarda en desaparecer el texto.
  derrotas    db 0       ;derrotas que lleva el jugador
  victorias   db 0
  
  
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
    call saltoDeLinia
                 ;limpia la pantalla y la respuesta.
    call limpiarRespuesta
    call limpiar_pantalla           
    
            
                                      ;Oracion_2  
                                      
    sub tiempoPausa, 2   ;disminuimos a la mitad el tiempo entre que se limpia pantalla                                                                                                       
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
    call saltoDeLinia
    ;--
    call limpiarRespuesta
    call limpiar_pantalla
    
    
     
     
     
   



    cmp derrotas, 3      ;llega a 3 derrotas y termina el juego.
    jae endGame 



    call endGame
    
    
    
    
    
    
    
    
    
    
    

showString:          ;Muestra un String cargado en dx.
    mov ah, 9h
    int 21h
    ret

saltoDeLinia:        ;da un salto de linia, Enter.
    mov dx, offset enter
    call showString
    ret



getString:          ;Leemos el String que mete el usuario por teclado
   mov bx, offset respuesta ;Cargamos el Array respuesta en bx
     loopGetString:
   call getC
   mov byte ptr [bx], al
   cmp byte ptr [bx], CR
   je retornoSimple  
     
     inc bx         ; bx+1
     jmp loopGetString
 
        
limpiarRespuesta:   ;Llena de null el array respuesta.
     mov bx, offset respuesta  ; bx = respuesta[]
      loopClearString:
     cmp byte ptr [bx], 0 ;Null es = 0 ASCII
     je retornoSimple     ; array[bx]== 0 then retornar
     mov byte ptr [bx], 0
     inc bx               ; bx+1
     jmp loopClearString




limpiar_pantalla:   ;limpia la pantalla
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





 
 
 
 

 
     
comparar:           ;la oracion del nivel se carga en bx
        mov SI, 0      
        
        loopComparar:    
        mov ch, byte ptr [bx]
     cmp respuesta [SI] , ch  
       
     jne nivelNoSuperado             ;Algun elemento no coincide.
     inc bx
     inc SI
     cmp oracion_1[si], 0            ; termino la oracion del nivel actual.
      je nivelSuperado               ;Todos los elementos coinciden.
     jmp loopComparar                ;Aun le quedan caracteres al nivel.
     
     
   nivelSuperado:   ;Cuando se acerto en todos los caracteres. 
      inc victorias                         ;Aumenta el numero de victorias.
      mov dx, offset stringNivelSuperado
      call showString                       ;Muestra el String nivel superado.  
      mov dx, offset stringVictorias        ;muestra el String cantidad de Victorias
      call showString                       
      mov dl, 48d                           
      add dl, victorias                     ;carga el numero de victorias
      call showC                            ;y lo muestra.
      call pausarJuego      ;Te permite leer el texto de cuantas veces acertaste
      
      ret 
      
      
   nivelNoSuperado: ;Cuando se erro en algun caracter. 
      inc derrotas          ;Aumenta el numero de Derrotas.  
      mov dx, offset stringNivelNoSuperado   ;Carga el mensaje de nivel no superado.      
      call showString       ;Muestra string         
                    
      mov  dl, 48d          ;Carga el numero de derrotas en dl.
      add  dl, derrotas     ;lo combierto en un numero ASCII
      call showC            ;Muestra dl
                        
     
      call pausarJuego      ;Te permite leer el texto de cuantas veces te equivocaste
      
      
      ret         
      
      
      
      
              
;---Metodos basicos 
getC:               ;Lee un caracter    
    mov ah, 1h
    int 21h
    ret
showC:              ;Muestra caracter.
    mov ah,2h
    int 21h
    ret             
retornoSimple:      ;Retorna
    ret
endGame:            ;Finaliza el juego y da puntajes.
    mov dx, offset stringVictorias 
    call showString                 ;Muestra numero de victorias.
    mov dl, victorias
    add dl, 48d                     ;Lo comvierte en numero ascii
    call showC
    
    mov dx, offset stringDerrotas   ;Muestra numero de Derrotas.
    call showString
    mov dl, derrotas 
    add dl, 48d                     ;Lo comvierte en numeros ascii
    call showC
    
    
    mov ax, 4c00h                   ;Libera al procesador.
    int 21H