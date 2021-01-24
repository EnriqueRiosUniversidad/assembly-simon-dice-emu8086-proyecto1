.model small 
.stack 256

CR equ 13d
LF equ 10d
.data                               
    enter db CR,LF,0,'$' 
                      ;---ORACIONES--;
  oracion_1             db "pepe*amarillo",0,'$'  
  oracion_2             db                      "alberto*rojo",0,'$'
  oracion_3             db "azul*juan",0,'$'
  
  oracion_4             db "tomas*rojo*juan",0,'$'
  oracion_5             db "ana*rojo*amarillo",0,'$'
  oracion_6             db "tierra*pasto*verde",0,'$'
  
  oracion_7             db "5*4*3",0,'$'
  oracion_8             db "2*azul*tomas",0,'$'
  oracion_9             db "angel*7*3",0,'$'
  
  oracion_10            db "tomas*rojo*juan",0,'$'
  oracion_11            db "tomas*rojo*juan",0,'$'
  oracion_12            db "tomas*rojo*juan",0,'$'
       
                      ;---STRINGS---; 
  stringNombreJuego         db "                                     The Root",0,'$' 
  stringNombreAutor         db "                        Auto: Enrique Emmanuel Rios Chyrnia",0,'$'
  stringExplicacion         db "     El juego consiste en memorizar oraciones en 10 segundos, cada 3 niveles el tiempo se reduce 2 segundos Si tienes 3 errores perderas el juego. Suscribete a mi canal: Enrique Rios",0,'$'
  stringNivelSuperado       db "NIVEL SUPERADO",0,'$'
  stringNivelNoSuperado     db "NIVEL NO SUPERADO, cantidad de derrotas: ",0,'$'  
  stringVictorias           db "  Numero de victorias: ",0,'$'
  stringDerrotas            db "  Numero de Derrotas: ",0,'$'
  stringContinuar           db "Oprimar / si desea salir o enter para continuar",0,'$' 
  stringTiempoReducido      db "Tiempo limite para memorizar reducido 2 segundos",0,'$'                                                          
  stringJuegoTerminado      db "Juego terminado, espero te haya gustado",0,'$'                                                                                       
                                                                                         
  respuesta db 80 dup (0)            
  nivel     db 80 dup (0)
  
  tiempoPausa db 10      ;Tiempo que tarda en desaparecer el texto.
  derrotas    db 0       ;derrotas que lleva el jugador
  victorias   db 0
  
  
.code

    call cambiarDeColor ;Esto cambia el color de fondo y letra.
    mov ax, @data
    mov ds, ax
    
    call Introduccion  ;Da la introduccion al juego.
     
                             ;Oracion_1
                 ;Da un enter, muestra la oracion y da enter. 
    call saltoDeLinia  ; da un enter
    mov dx, offset oracion_1
    call showString          
    call saltoDeLinia  ;da un "Enter"       
    call pausarJuego   ;pausar el juego  
    call limpiar_pantalla ;deja la pantalla en negro.   
                 ;Obtiene la respuesta.
    call getString 
    call saltoDeLinia
                 ;Compara Respuestas.
    mov bx, offset oracion_1
    call comparar 
    call saltoDeLinia
                 ;Pregunta el usuario si desea continuar 
    call limpiarRespuesta
    call continuar?
    call limpiarRespuesta
                 ;limpia la pantalla y la respuesta. 
    call limpiar_pantalla           
    
            
                                      ;Oracion_2   
                                      
    call saltoDeLinia                                                                                                                                       
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
    call continuar?
    call limpiarRespuesta
    ;--
    call limpiar_pantalla
         
     
                                      ;Oracion_3  
    call saltoDeLinia                                                                                                                                       
    mov dx, offset oracion_3
    call showString 
    call saltoDeLinia
    call pausarJuego
    call limpiar_pantalla                                 
    ;---                                  
    call getString
    call saltoDeLinia
    ;---
    mov bx, offset oracion_3
    call comparar 
    call saltoDeLinia 
    ;--
    call limpiarRespuesta
    call continuar?
    call limpiarRespuesta
    ;--
    call limpiar_pantalla     
   

             cmp derrotas, 3      ;llega a 3 derrotas y termina el juego.
             jae endGame

                                      ;Oracion_4  
    mov dx, offset stringTiempoReducido   ;Esto avisa al usuario que el tiempo limite para memorizar se redujo 2 segundos.
    call showString
    
    call saltoDeLinia    ;enter                                  
    sub tiempoPausa, 2   ;disminuimos a la mitad el tiempo entre que se limpia pantalla                                                                                                       
    mov dx, offset oracion_4
    call showString 
    call saltoDeLinia
    call pausarJuego
    call limpiar_pantalla                                 
    ;---                                  
    call getString
    call saltoDeLinia
    ;---
    mov bx, offset oracion_4
    call comparar 
    call saltoDeLinia 
    ;--
    call limpiarRespuesta
    call continuar?
    call limpiarRespuesta
    ;--
    call limpiar_pantalla    
              
             cmp derrotas, 3      ;llega a 3 derrotas y termina el juego.
             jae endGame
    
                                      ;Oracion_5  
    call saltoDeLinia                                                                                                                                       
    mov dx, offset oracion_5
    call showString 
    call saltoDeLinia
    call pausarJuego
    call limpiar_pantalla                                 
    ;---                                  
    call getString
    call saltoDeLinia
    ;---
    mov bx, offset oracion_5
    call comparar 
    call saltoDeLinia 
    ;--
    call limpiarRespuesta
    call continuar?
    call limpiarRespuesta
    ;--
    call limpiar_pantalla    
    
             cmp derrotas, 3      ;llega a 3 derrotas y termina el juego.
             jae endGame
                                      ;Oracion_6  
    call saltoDeLinia                                                                                                                                       
    mov dx, offset oracion_6
    call showString 
    call saltoDeLinia
    call pausarJuego
    call limpiar_pantalla                                 
    ;---                                  
    call getString
    call saltoDeLinia
    ;---
    mov bx, offset oracion_6
    call comparar 
    call saltoDeLinia 
    ;--
    call limpiarRespuesta
    call continuar?
    call limpiarRespuesta
    ;--
    call limpiar_pantalla    
    
             cmp derrotas, 3      ;llega a 3 derrotas y termina el juego.
             jae endGame
        
                                      ;Oracion_7 
                                       
        mov dx, offset stringTiempoReducido
        call showString
    call saltoDeLinia    ;enter                                  
    sub tiempoPausa, 2   ;disminuimos a la mitad el tiempo entre que se limpia pantalla                                                                                                       
    mov dx, offset oracion_7
    call showString 
    call saltoDeLinia
    call pausarJuego
    call limpiar_pantalla                                 
    ;---                                  
    call getString
    call saltoDeLinia
    ;---
    mov bx, offset oracion_7
    call comparar 
    call saltoDeLinia 
    ;--
    call limpiarRespuesta
    call continuar?
    call limpiarRespuesta
    ;--
    call limpiar_pantalla    
             
             cmp derrotas, 3      ;llega a 3 derrotas y termina el juego.
             jae endGame    
                                      ;Oracion_8  
    call saltoDeLinia                                                                                                                                       
    mov dx, offset oracion_8
    call showString 
    call saltoDeLinia
    call pausarJuego
    call limpiar_pantalla                                 
    ;---                                  
    call getString
    call saltoDeLinia
    ;---
    mov bx, offset oracion_8
    call comparar 
    call saltoDeLinia 
    ;--
    call limpiarRespuesta
    call continuar?
    call limpiarRespuesta
    ;--
    call limpiar_pantalla    
    
             cmp derrotas, 3      ;llega a 3 derrotas y termina el juego.
             jae endGame 
                                     ;Oracion_9  
    call saltoDeLinia                                                                                                                                       
    mov dx, offset oracion_9
    call showString 
    call saltoDeLinia
    call pausarJuego
    call limpiar_pantalla                                 
    ;---                                  
    call getString
    call saltoDeLinia
    ;---
    mov bx, offset oracion_9
    call comparar 
    call saltoDeLinia 
    ;--
    call limpiarRespuesta
    call continuar?
    call limpiarRespuesta
    ;--
    call limpiar_pantalla    
    
            cmp derrotas, 3      ;llega a 3 derrotas y termina el juego.
            jae endGame
    
    
    
    
    
    
    

    
    
     
    call endGame                 ;Finaliza el juego.
    
    
    
    
    
    
    
cambiarDeColor:    ;Esto cambia el color de fondo y letra. 
                   ;Link de la wikipedia donde saque la informacion de int 10h
                   ;    https://en.wikipedia.org/wiki/INT_10H
                   ;Utilice la tabla de colores de Wikipedia 
                   ; https://en.wikipedia.org/wiki/BIOS_color_attributes 
                   
    mov ah, 09h    ;Escribir caracter y atributo en la posicion del cursor
    mov cx, 2000h 
    mov al, 10h    ;Imprime un monton de flechas en la pantalla.
    mov bl, 02     ;Primer digito el fondo, segundo la letra: negro/verde    
    int 10h
    ret            ;bl color, al caracter, cx numero de veces que se imprimira el caracter.
         
         
         
    
Introduccion:  ;Da un mensaje de Introduccion y explica mecanicas dle juego               
    call saltoDeLinia     ;Seria un Enter
    call saltoDeLinia     ;Seria un Enter
    mov dx, offset stringNombreJuego    ;Carga el estring en DX
    call showString       ;Imprime el estring dentor de DX
    call saltoDeLinia     ;Seria un Enter
    
    mov dx, offset stringNombreAutor
    call showString
    call saltoDeLinia
    
    mov dx, offset stringExplicacion
    call showString
    call saltoDeLinia
    mov tiempoPausa, 7    ;La pausa del juego durara 5 segundos.
    
    call pausarJuego      ;Pausa el Juego
    call limpiar_pantalla ;Limpia la pantalla
    mov tiempoPausa, 10   ;Restablece el tiempo de pausa en 10 segundos.
    ret                   ;Retorna
   
   
   
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
     jmp loopClearString  ;Repite el bucle




limpiar_pantalla:   ;limpia la pantalla
    push ax         ;guarda AX
    mov ax, 00h     ;Fijar modo de video
    mov al, 03h     ;Modo de video
    int 10h         ;Ejecuta
    pop ax          ;restablece AX
    ret             ;Retorna




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

    jmp loopPausa   ;repite el bucle



continuar?:         ;Esta etiqueta pregunta el usuario si desea continuar
  mov dx, offset stringContinuar         ;Mensaje continuar
  call showString                    ;Muestra el mensaje
  call saltoDeLinia                  ; enter
  call getString                     ;lee la respuesta
      mov SI, 0                      ;puntero SI en 0
         cmp respuesta[SI], '/'      ;pregunta si es igual a /
         je endGame                  ;Termina el juego si el usuario lo quiere
  ret                                ;continua el juego.


 
 
 
 

 
     
comparar:           ;la oracion del nivel se carga en bx
        mov SI, 0      
        
        loopComparar:    
        mov ch, byte ptr [bx]
     cmp respuesta [SI] , ch  
       
     jne nivelNoSuperado             ;Algun elemento no coincide.
     inc bx
     inc SI
     cmp byte ptr [bx], 0            ; termino la oracion del nivel actual.
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
      
      
      ret 
      
      
   nivelNoSuperado: ;Cuando se erro en algun caracter. 
      inc derrotas          ;Aumenta el numero de Derrotas.  
      mov dx, offset stringNivelNoSuperado   ;Carga el mensaje de nivel no superado.      
      call showString       ;Muestra string         
                    
      mov  dl, 48d          ;Carga el numero de derrotas en dl.
      add  dl, derrotas     ;lo combierto en un numero ASCII
      call showC            ;Muestra dl
                                
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
    call saltoDeLinia
    mov dx, offset stringJuegoTerminado      ;Mensaje de cierre del juego
    call showString                          ;Muestra el mensaje
    call saltoDeLinia                        ;Da un enter
    
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