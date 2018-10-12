;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ENTIDAD ENEMIGO
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.area _DATA
.area _CODE

.include "cpctelera.h.s"
.include "struct.h.s"
;;======================================================================
;;======================================================================
;; DATOS PRIVADOS
;;======================================================================
;;======================================================================
enemy_size = en_size           ;; Tamanyo parametrizado
k_max_enemies = 1

DefineEnemy enemy_copy, 39, 50, #1, #4, #0, #0, #0x0F, #enemy_randomGoal, #0, #0, #0, #0x0000, #0x0000, #0, #0, #0x0000, #0x0000, #0x0000, #1

;; ANCHO:   0 - 79
;; ALTO:    0 - ~100 -> COMO ESTAMOS EN MODO 0, SE CONSIGUE LA MITAD DE RESOLUCION EN Y
x_range  = 79
y_range  = 100
var_r_max    = 20
var_r_min    = 10
vector_init:                  ;; Etiqueta de inicio del vector
;DefineNEnemies enemy, k_max_enemies
DefineEnemy enemy1, #0x27, #0x10, #2, #8, #0, #0, #0x0F, #enemy_randomGoal, #0, #0, #0, #0x0000, #0x0000, #0, #0, #0x0000, #0x0000, #0x0000, #1
vector_end:    .db #0xFF      ;; Indico 0xFF como fin del vector

flag_move:     .db #20        ;; Cambia en cada frame [0,1] -> 1 = Se mueve

;;======================================================================
;;======================================================================
;; FUNCIONES PUBLICAS
;;======================================================================
;;======================================================================
;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; COPIA LOS ENEMIGOS DEL BUCLE CON UNA ENTIDAD "MODELO"
;; _______________________
;; DESTRUYE:   HL
;;;;;;;;;;;;;;;;;;;;;;;;;;;
enemy_create::
   ld hl, #enemy_init
   jp enemy_search

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ASIGNA LA FUNCION DE DIBUJADO EN HL Y RECORRE EL BUCLE
;; _______________________
;; DESTRUYE:   HL
;;;;;;;;;;;;;;;;;;;;;;;;;;;
enemy_draw_ALL::
   ld hl, #dw_draw
   jp enemy_search

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ASIGNA LA FUNCION DE CLEAR EN HL Y RECORRE EL BUCLE
;; _______________________
;; DESTRUYE:   HL
;;;;;;;;;;;;;;;;;;;;;;;;;;;
enemy_clear_ALL::
   ld hl, #dw_clear
   jp enemy_search

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ASIGNA LA FUNCION DE UPDATE EN HL Y RECORRE EL BUCLE
;; _______________________
;; DESTRUYE:   HL
;;;;;;;;;;;;;;;;;;;;;;;;;;;
enemy_update_ALL::
   ld hl, #enemy_update
   jp enemy_search

;;======================================================================
;;======================================================================
;; FUNCIONES PRIVADAS
;;======================================================================
;;======================================================================
;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; RECORRE EL BUCLE DE ENEMIGOS
;; _______________________
;; ENTRADA:    HL -> Puntero a funcion custom
;; DESTRUYE:   A, DE, IX
;;;;;;;;;;;;;;;;;;;;;;;;;;;
enemy_search:
   ld    ix,   #vector_init      ;; IX apunta al inicio de vector_bullets (a la primera entidad)
   ld    (f_custom), hl          ;; Cargo en el call de abajo la funcion a la que quiero llamar en cada momento determinado
   search_loop:
      ld     a,   0(ix)                ;; Compruebo que no he llegado al final del vector
      cp    #0xFF                      ;; A - 0xFF
      ret    z                         ;; if(A==0xFF) -> Sale del vector

      f_custom = . +1                  ;; . apunta a 'call' y con el '+1' apunta a '(0x0000)' -> (siempre va a cambiar)
      call (0x0000)                    ;; LLAMADA A FUNCION PERSONALIZABLE
      ld    de,   #enemy_size          ;; Cargo en DE el tamanyo de la entidad bullet para despues sumarlo a HL
      add   ix,   de                   ;; IX + DE = Apunta a la siguiente entidad bullet
   jr search_loop

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; COPIA LA ENTIDAD EN IX CON EL ENEMIGO POR DEFECTO
;; _______________________
;; ENTRADA:    IX -> Puntero a entidad enemigo del bucle
;;;;;;;;;;;;;;;;;;;;;;;;;;;
enemy_init:
   push  ix                ;; El valor de IX va a la pila
   pop   de                ;; DE ahora tiene el valor de IX
   ld    hl, #enemy_copy   ;; HL apunta al destino de la copia
   ld    bc, #enemy_size   ;; BC tiene el tamanyo del enemigo
   ldir                    ;; ELEDIR
   ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; LLAMA A LA FUNCION PROPIA DE UPDATE DE CADA ENEMIGO
;; _______________________
;; ENTRADA:    IX -> Puntero a entidad enemigo del bucle
;;;;;;;;;;;;;;;;;;;;;;;;;;;
enemy_update:
   ld    l, en_up_l(ix)     ;; Cargo el byte bajo en L
   ld    h, en_up_h(ix)     ;; Cargo el byte alto en H
   jp    (hl)              ;; Llamo a la funcion

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; BUSCA UN PUNTO ALEATORIO PARA IR HACIA ALLI
;; _______________________
;; ENTRADA:    IX -> Puntero a entidad enemigo del bucle
;;;;;;;;;;;;;;;;;;;;;;;;;;;
; save_dX:    .dw #0x0000    ;; Para Bresenham
; save_dY:    .dw #0x0000    ;; Para Bresenham
; IncYr:      .db #0x00      ;; Serian el contrario de las VY de la entidad --> LLEVAR A DATOS PARAMETRIZABLES!!
; IncXr:      .db #0x00      ;; Serian el contrario de las VX de la entidad --> LLEVAR A DATOS PARAMETRIZABLES!!
; av:         .dw #0x0000    ;; VALORES DE INICIALIZACION DEL ALGORITMO
; avR:        .dw #0x0000    ;; VALORES DE INICIALIZACION DEL ALGORITMO
; avI:        .dw #0x0000    ;; VALORES DE INICIALIZACION DEL ALGORITMO
; flag_vel:   .db #0x01      ;; 1 = Esta utilizando IncYi/IncXi |------------| 0 = Esta utilizando IncYr/IncXr
enemy_randomGoal:
   ld    a, (flag_move)          ;; Cargo en A un contador para que no busque todo el rato
   dec   a                       ;; A--
   ld    (flag_move), a          ;; Lo actualizo
   ret   nz                      ;; Si no ha llegado a 0 hace ret

   ld    a, #1                  ;; Inicio de nuevo el contador para despues
   ld (flag_move), a

   ;;RESET DE LOS VALORES
   ld en_dX_l(ix), #0      ;; dX
   ld en_dX_h(ix), #0      ;; \
   ld en_dY_l(ix), #0      ;; dY
   ld en_dY_h(ix), #0      ;; \
   ld en_incXr(ix), #0     ;; IncXr
   ld en_incYr(ix), #0     ;; IncYr
   ld en_vx(ix),  #0       ;; vx = IncXi
   ld en_vy(ix),  #0       ;; vy = IncYi
   ld en_av_l(ix), #0      ;; av
   ld en_av_h(ix), #0      ;; \
   ld en_avR_l(ix), #0     ;; avR
   ld en_avR_h(ix), #0     ;; \
   ld en_avI_l(ix), #0     ;; avI
   ld en_avI_h(ix), #0     ;; \



   ;; PARTE 1 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   ;; X
   get_random_x:
      call cpct_getRandom_mxor_u8_asm        ;; Lo devuelve en L
      ld    a,    l                          ;; Cargo en A el random que se ha cargado en L
      cp    #x_range                         ;; Miro que este dentro del rango 0-80 (dec)

      sub   en_x(ix)                         ;; Resto la posicion actual del enemigo
      jr    nc, no_carry_x
         cpl
         inc a
      no_carry_x:
      ;; Ahora tengo la distancia arreglada
      cp    #var_r_max
   jr    nc, get_random_x                    ;; Si no esta dentro del rango max, lo vuelve a buscar
      cp    #var_r_min
   jr    c, get_random_x                     ;; Si esta dentro del rango min, lo vuelve a buscar

   ld en_g_x(ix), l                          ;; Cargo la posicion random en el enemigo

   ;; Saco vector VX del enemigo
   ld    a,    l              ;; Posicion X del objetivo
   sub   en_x(ix)             ;; Resto la posicion actual del enemigo
   ld    en_dX_l(ix), a       ;; GUARDO el valor de dX
   jr c, vx_neg               ;; Si C==1, la distancia es negativa
      ld    en_vx(ix), #1        ;; VX =  1
      jr continua_y
   vx_neg:
      ld    en_vx(ix), #-1       ;; VX = -1
      cpl                        ;; Invierto bites de A, que guarda la distancia
      inc   a                    ;; Le sumo 1 y entonces -> A = -A
      ld en_dX_l(ix) , a         ;; Lo guardo de nuevo
      ld    a,    #0x00          ;; | A = 0xFF
      ld en_dX_h(ix), a          ;; Ya que es negativo -> FF**
   continua_y:

   ;; Y
   get_random_y:
      call cpct_getRandom_mxor_u8_asm        ;; Lo devuelve en L
      ld    a,    l                          ;; Cargo en A el random que se ha cargado en L
      cp    #y_range                         ;; Miro que este dentro del rango 0-200 (dec)

      sub   en_y(ix)                         ;; Resto la posicion actual del enemigo
      jr    nc, no_carry_y
         cpl
         inc a
      no_carry_y:
      ;; Ahora tengo la distancia arreglada
      cp    #var_r_max
   jr    nc, get_random_y                    ;; Si no esta dentro del rango, lo vuelve a buscar
      cp    #var_r_min
   jr    c, get_random_y                     ;; Si esta dentro del rango min, lo vuelve a buscar

   ld en_g_y(ix), l                          ;; Cargo la posicion random en el enemigo

   ;; Saco vector VY del enemigo
   ld    a,    l                 ;; Posicion Y del objetivo
   sub   a, en_y(ix)             ;; Posicion Y del enemigo
   ld    en_dY_l(ix), a          ;; Guardo el valor para despues
   ;cp    #200                   ;; |
   jr c, vy_neg                  ;; Si C==0 la distancia es negativa -> COMPROBAR EN EJECUCION
      ld    en_vy(ix), #1        ;; VY =  1
      jr continua_fin
   vy_neg:
      ld    en_vy(ix), #-1       ;; VY = -1
      cpl                        ;; Invierto bites de A, que guarda la distancia
      inc   a                    ;; Le sumo 1 y entonces -> A = -A
      ld en_dY_l(ix), a            ;; Lo guardo de nuevo
      ld    a,    #0x00          ;; | A = 0xFF
      ld en_dY_h(ix), a          ;; Ya que es negativo -> FF**
   continua_fin:

   ;; PARTE 2 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

   ;; Primero miro si los numeros estan en un valor absoluto
   ld    l, en_dY_l(ix)       ;; Cargo en HL el valor de dY
   ld    h, en_dY_h(ix)       ;; Cargo en HL el valor de dY
   call enemy_get_positive
   ex    de,   hl             ;; -- DE = dY
   ld    l, en_dX_l(ix)        ;; Cargo en HL el valor de dX
   ld    h, en_dX_h(ix)        ;; Cargo en HL el valor de dX
   call enemy_get_positive    ;; -- HL = dX

   jr    nc, no_carry         ;; Si C = 0, no hago nada
      ccf                     ;; Si entra aqui, C = 1, entonces invierto -> C = 0
   no_carry:
   sbc   hl,   de             ;; HL - DE = dX - dY ---> AL UTILIZAR TAMBIEN EL CARRY FLAG, LO PONGO A 0 ANTES DE HACER NADA
   jr c, dy_es_mayor          ;; dX - dY = 0013 - 0000 = 13 -> dX ES MAYOR, C=0
      ;;if dX>=dY
      ld    a,    #0          ;; A = 0
      ld en_incYr(ix), a      ;; --> IncYr = 0
      ld    a, en_vx(ix)      ;; A = IncXi = VX
      ld en_incXr(ix), a      ;; --> IncXr = IncXi ----> IncXi = VX = INCREMENTO QUE SE APLICA A LAS SECCIONES CON AVANCE INCLINADO
      jr continua_fin2
   dy_es_mayor:
      ;;if dY>dX
      ld    a,    #0          ;; A = 0
      ld en_incXr(ix), a      ;; -- IncXr = 0
      ld    a, en_vy(ix)      ;; A = IncYi = VY
      ld en_incYr(ix), a      ;; -- IncYr = IncYi ----> IncYi = VY = INCREMENTO QUE SE APLICA A LAS SECCIONES CON AVANCE INCLINADO

      ;; =============================== ;;
      ;; INTERCAMBIO LOS VALORES dX y dY ;;
      ;;             k  = dX             ;;
      ;;             dX = dY             ;;
      ;;             dY =  k             ;;
      ;; =============================== ;;
      ld    l, en_dX_l(ix)
      ld    h, en_dX_h(ix)
      ex    de,   hl
      ld    l, en_dY_l(ix)
      ld    h, en_dY_h(ix)
      ld en_dX_l(ix), l
      ld en_dX_h(ix), h
      ex    de,   hl
      ld en_dY_l(ix), l
      ld en_dY_h(ix), h

   continua_fin2:

   ;; INICIALIZAR VALORES RAROS
   ld    l, en_dY_l(ix)       ;; HL = dY
   ld    h, en_dY_h(ix)       ;; |
   add   hl,   hl             ;; HL + HL = 2 * dY
   ld en_avR_l(ix), l         ;; --> avR = (2 * dY)
   ld en_avR_h(ix), h         ;; |

   ;; Hay que negar dX y luego sumarlo
   ;; En DE tendre el valor de dX y en HL ya he conseguido el valor de avR
   ;; av = (HL + (-DE))
   ;; av = (avR - dX)
   ld    l, en_dX_l(ix)       ;; HL =  dX
   ld    h, en_dX_h(ix)       ;; |
   call enemy_get_negative    ;; HL = -dX
   ex    de,   hl             ;; -- DE = -dX
   ld    l, en_avR_l(ix)      ;; -- HL = avR
   ld    h, en_avR_h(ix)      ;; |
   add   hl,   de             ;; HL + DE = avR - dX
   ld en_av_l(ix), l          ;; av = avR - dX
   ld en_av_h(ix), h          ;; |

   ;; En HL ya tengo av y en DE tengo -dX
   ;; Solo tengo que sumarlo
   add   hl,   de             ;; av + -(dX)
   ld en_avI_l(ix), l         ;; --> avI = (av - dX)
   ld en_avI_h(ix), h         ;; |



   ; ;; 'DEBUG'
   ; ld    de, #0xC000          ;;Comienzo memoria de video
   ; ld     c, en_g_x(ix)       ;; C = Entity X
   ; ld     b, en_g_y(ix)    ;; B = Entity Y
   ; call cpct_getScreenPtr_asm
   ; ;; SIN SPRITE
   ; ex    de,   hl             ;; Apunta a la posicion x,y
   ; ld     a,   #0xEE          ;; Código de color
   ; ld     c,   #1             ;; Ancho
   ; ld     b,   #4             ;; Alto
   ; call cpct_drawSolidBox_asm



   ;;; Cambio update
   ld hl, #enemy_checkGoal
   ld en_up_h(ix), h
   ld en_up_l(ix), l

   jp enemy_checkGoal

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CHECKEA SI HA LLEGADO A SU DESTINO
;; _______________________
;; ENTRADA:    IX -> Puntero a entidad enemigo del bucle
;;;;;;;;;;;;;;;;;;;;;;;;;;;
enemy_checkGoal:
   ;; Si ha llegado al destino -> NO MUEVO
   ;; COMPROBACION EN X ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   ld    a,    en_g_x(ix)           ;; Cargo la posicion del goal
   cp    en_x(ix)                   ;; Le resto la posicion del enemigo
   jr nz, no_goal_yet
      ld en_vx(ix),  #0          ;; Pongo a 0 -> RESET
      ld en_vy(ix),  #0          ;; Pongo a 0 -> RESET

      ld hl, #enemy_randomGoal      ;; Vuelvo a cambiar el update del enemigo
      ld en_up_h(ix), h
      ld en_up_l(ix), l
      ret
   no_goal_yet:
   ;; El spaghetti code de @daNNi
   ;; THE FINAL BOSS: Actualizo Bresenham

   ld    l, en_av_l(ix)       ;; HL = av
   ld    h, en_av_h(ix)       ;; |
   ld    de,   #0x8000        ;; DE = 7FFF
   jr    nc, no_carry2        ;; Si C = 0, no hago nada
      ccf                     ;; Si entra aqui, C = 1, entonces invierto -> C = 0
   no_carry2:
   sbc   hl,   de
   jr    nc,    av_negativo
      ;; Aqui av, es positivo o 0
      ld    a,    en_flagVel(ix)
      cp    #1
      jr    z, utiliza_i      ;; NECESITA UTILIZAR i
         ;; Cambiar de r a i
         ;; CAMBIO DE LAS Y
         ld    a,    en_incYr(ix)   ;; A = IncYr
         ld    b,    a              ;; B = A = IncYr
         ld    a,    en_vy(ix)      ;; A = IncYi
         ld en_incYr(ix), a         ;; Intercambio 1
         ld    a,    b              ;; A = B = IncYr
         ld en_vy(ix), a            ;; Intercambio 2

         ;; CAMBIO DE LAS X
         ld    a,    en_incXr(ix)   ;; A = IncXr
         ld    b,    a              ;; B = A = IncXr
         ld    a,    en_vx(ix)      ;; A = IncXi
         ld en_incXr(ix), a         ;; Intercambio 1
         ld    a,    b              ;; A = B = IncXr
         ld en_vx(ix), a            ;; Intercambio 2

         ld    a,    #1             ;; Finalmente cambio el flag de la velocidad
         ld en_flagVel(ix), a       ;; flag_vel = 1
      utiliza_i:
         ;; Aqui no hace falta cambiar ninguna velocidad
         ld    l, en_av_l(ix)       ;; HL = av
         ld    h, en_av_h(ix)       ;; |
         ex    de,   hl             ;; -- DE = av
         ld    l, en_avI_l(ix)      ;; -- HL = avI
         ld    h, en_avI_h(ix)      ;; |
         add   hl,   de             ;; DE + HL
         ld en_av_l(ix), l          ;; -- av = (av + avI)
         ld en_av_h(ix), h          ;; |
      jr end_if
   av_negativo:
      ;; Aqui av, es negativo
      ;;     X = (X + IncXr)     // X aumenta en recto.
      ;;     Y = (Y + IncYr)     // Y aumenta en recto.
      ;;     av = (av + avR)     // Avance Recto
      ld    a,    en_flagVel(ix)
      cp    #0
      jr    z, utiliza_r      ;; NECESITA UTILIZAR r
         ;; Cambiar de i a r
         ;; CAMBIO DE LAS Y
         ld    a,    en_incYr(ix)   ;; A = IncYr
         ld    b,    a              ;; B = A = IncYr
         ld    a,    en_vy(ix)      ;; A = IncYi
         ld en_incYr(ix), a         ;; Intercambio 1
         ld    a,    b              ;; A = B = IncYr
         ld en_vy(ix), a            ;; Intercambio 2

         ;; CAMBIO DE LAS X
         ld    a,    en_incXr(ix)   ;; A = IncXr
         ld    b,    a              ;; B = A = IncXr
         ld    a,    en_vx(ix)      ;; A = IncXi
         ld en_incXr(ix), a         ;; Intercambio 1
         ld    a,    b              ;; A = B = IncXr
         ld en_vx(ix), a            ;; Intercambio 2

         ld    a,    #0             ;; Finalmente cambio el flag de la velocidad
         ld en_flagVel(ix), a       ;; flag_vel = 0
      utiliza_r:
         ;; Aqui no hace falta cambiar ninguna velocidad
         ld    l, en_av_l(ix)       ;; HL = av
         ld    h, en_av_h(ix)       ;; |
         ex    de,   hl             ;; -- DE = av
         ld    l, en_avR_l(ix)      ;; -- HL = avI
         ld    h, en_avR_h(ix)      ;; |
         add   hl,   de             ;; DE + HL
         ld en_av_l(ix), l          ;; -- av = (av + avI)
         ld en_av_h(ix), h          ;; |
   end_if:


   ld a, en_x(ix)
   add en_vx(ix)
   ld en_x(ix), a

   ld a, en_y(ix)
   add en_vy(ix)
   ld en_y(ix), a


   ret


;; ENTRADA:    HL -> Valor de 2 bytes a llevar a valor positivo, en caso que sea negativo
;; DESTRUYE:   A, HL
;; SALIDA:     HL -> Valor negativo negado = valor positivo
enemy_get_positive:
   ld     a, h                ;; A = 00/FF
   cp    #0                   ;; |
   ret     z
      ld    a, l              ;; A = -dY
      cpl
      inc a                   ;; A =  dY -> Aqui ya tengo dY en positivo
      ld    h, #0             ;; H = 00
      ld    l, a              ;; L = dY --> HL = 00**, donde ** = dY
   ret

;; Lo mismo que enemy_get_positive pero con negativos
enemy_get_negative:
   ld    a, h                ;; A = FF/00
   cp    #0xFF               ;; |
   ret   z
      ld    a,    l          ;; A = -dY
      cpl
      inc   a                ;; A =  dY -> Aqui ya tengo dY en positivo
      ld    h,    #0xFF      ;; H = FF
      ld    l,    a          ;; L = dY --> HL = FF**, donde ** = dY
   ret















