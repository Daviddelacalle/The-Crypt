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
x_range = 29
y_range = 29
var_r_max   = 6
var_r_min   = 0
vector_init:                  ;; Etiqueta de inicio del vector
;DefineNEnemies enemy, k_max_enemies
DefineEnemy enemy1, #22, #25, #2, #8, #0, #0, #0x0F, #enemy_randomGoal, #0, #0, #0, #0x0000, #0x0000, #0, #0, #0x0000, #0x0000, #0x0000, #1
; DefineEnemy enemy2, #28, #28, #2, #8, #0, #0, #0x0F, #enemy_randomGoal, #0, #0, #0, #0x0000, #0x0000, #0, #0, #0x0000, #0x0000, #0x0000, #1
; DefineEnemy enemy3, #1, #28, #2, #8, #0, #0, #0x0F, #enemy_randomGoal, #0, #0, #0, #0x0000, #0x0000, #0, #0, #0x0000, #0x0000, #0x0000, #1
; DefineEnemy enemy4, #28, #1, #2, #8, #0, #0, #0x0F, #enemy_randomGoal, #0, #0, #0, #0x0000, #0x0000, #0, #0, #0x0000, #0x0000, #0x0000, #1
vector_end:    .db #0xFF      ;; Indico 0xFF como fin del vector

flag_move:     .db #20        ;; Cambia en cada frame [0,1] -> 1 = Se mueve
ptr_map:       .dw #decompress_buffer   ;; Puntero al array de id de tiles que forman el mapa

k_update_count = 5
update_count:  .db #k_update_count        ;; Limita el update a cada k_update_count frames

;;======================================================================
;;======================================================================
;; FUNCIONES PUBLICAS
;;======================================================================
;;======================================================================


;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ASIGNA LA FUNCION DE DIBUJADO EN HL Y RECORRE EL BUCLE
;; _______________________
;; DESTRUYE:   HL
;;;;;;;;;;;;;;;;;;;;;;;;;;;
enemy_draw_ALL::
    ld a, (NumberOfEnemies)
    cp #0
    ret z
   ld hl, #enemy_call_draw
   jp enemy_search

enemy_call_draw:
   ld a, #0xAA
   jp dw_draw

initEnemies::
    ld    iy,   #vector_init      ;; IX apunta al inicio de vector de enemigos (a la primera entidad)
    init_loop:
       ld     a,   0(iy)                ;; Compruebo que no he llegado al final del vector
       cp    #0xFF                      ;; A - 0xFF
       ret    z                         ;; if(A==0xFF) -> Sale del vector

       call spawnEnemies

       ld    de,   #enemy_size          ;; Cargo en DE el tamanyo de la entidad bullet para despues sumarlo a HL
       add   iy,   de                   ;; IX + DE = Apunta a la siguiente entidad bullet
    jr init_loop

    ld a, #0
    ld (SpawnOffset), a
ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ASIGNA LA FUNCION DE UPDATE EN HL Y RECORRE EL BUCLE
;; _______________________
;; DESTRUYE:   HL
;;;;;;;;;;;;;;;;;;;;;;;;;;;
enemy_update_ALL::
   ld    a, (update_count)                ;; ======================== ;;
   dec   a                                ;;     POR SI AL FINAL      ;;
   ld    (update_count), a                ;;    SE QUIERE LIMITAR     ;;
   cp    #0                               ;;  EL UPDATE DEL ENEMIGO   ;;
   ret   nz                               ;; ======================== ;;

   ld hl, #enemy_update
   call enemy_search

   ld    a, #k_update_count               ;; REINICIAR EL CONTADOR
   ld    (update_count), a                ;;       DEL UPDATE
   ret

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
   ld    ix,   #vector_init      ;; IX apunta al inicio de vector de enemigos (a la primera entidad)
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
;; LLAMA A LA FUNCION PROPIA DE UPDATE DE CADA ENEMIGO
;; _______________________
;; ENTRADA:    IX -> Puntero a entidad enemigo del bucle
;;;;;;;;;;;;;;;;;;;;;;;;;;;
enemy_update:
   call enemy_heroInRadius

   ld    l, en_up_l(ix)     ;; Cargo el byte bajo en L
   ld    h, en_up_h(ix)     ;; Cargo el byte alto en H
   jp    (hl)              ;; Llamo a la funcion

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; BUSCA UN PUNTO ALEATORIO PARA IR HACIA ALLI
;; _______________________
;; ENTRADA:    IX -> Puntero a entidad enemigo del bucle
;; DESTRUYE:   Se destruyen TODOS los registros, incluso BC',DE' y HL'
;;;;;;;;;;;;;;;;;;;;;;;;;;;
enemy_randomGoal:
   ld    a, (flag_move)          ;; Cargo en A un contador para que no busque todo el rato
   dec   a                       ;; A--
   ld    (flag_move), a          ;; Lo actualizo
   ret   nz                      ;; Si no ha llegado a 0 hace ret

   ld    a, #1                  ;; Inicio de nuevo el contador para despues
   ld (flag_move), a

   ;;RESET DE LOS VALORES
   ld en_incXr(ix), #0      ;; IncXr
   ld en_incYr(ix), #0      ;; IncYr
   ld en_vx(ix),    #0      ;; vx = IncXi
   ld en_vy(ix),    #0      ;; vy = IncYi

   ;; PARTE 1 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   ;; X


   ;; Miro si E = 0xEE
   ;; En ese caso, no se consigue ningun random en X nuevo
   ld    a,    e
   cp    #0xEE

   ;; Cargo en A la posicion en X que he conseguido para después
   ;; en el caso que no vaya a elegir una random
   ;; En otro caso, A sera sobreescrita
   ;; A = X
   ld    a,    c

   ;; Guardo los registros HL, BC y DE
   ;; Los que importan son BC y E
   exx
   jr z, dont_do_random_x
      call enemy_getRandom_X     ;; A = X_fin
   dont_do_random_x:

   ;; Saco vector VX del enemigo
   sub   en_x(ix)             ;; Resto la posicion actual del enemigo
   ld    en_dX_l(ix), a       ;; GUARDO el valor de dX
   jr c, vx_neg               ;; Si C==1, la distancia es negativa
      ld    en_vx(ix), #1        ;; VX =  1
      jr continua_y
   vx_neg:
      ld    en_vx(ix), #-1       ;; VX = -1
      neg
      ld en_dX_l(ix) , a         ;; Lo guardo de nuevo
      ld    a,    #0x00          ;; | A = 0xFF
      ld en_dX_h(ix), a          ;; Ya que es negativo -> FF**
   continua_y:

   ;; Recupero BC y E
   exx

   ;; Miro si E = 0xEE
   ;; En ese caso, no se consigue ningun random en X nuevo
   ld    a,    e
   cp    #0xEE

   ;; Cargo en A la posicion en X que he conseguido para después
   ;; en el caso que no vaya a elegir una random
   ;; En otro caso, A sera sobreescrita
   ;; A = Y
   ld    a,    b
   jr z, dont_do_random_y
      call enemy_getRandom_Y     ;; A = Y_fin
   dont_do_random_y:

   ;; Saco vector VY del enemigo
   sub   a, en_y(ix)             ;; Posicion Y del enemigo
   ld    en_dY_l(ix), a          ;; Guardo el valor para despues
   ;cp    #200                   ;; |
   jr c, vy_neg                  ;; Si C==0 la distancia es negativa -> COMPROBAR EN EJECUCION
      ld    en_vy(ix), #1        ;; VY =  1
      jr continua_fin
   vy_neg:
      ld    en_vy(ix), #-1       ;; VY = -1
      neg
      ld en_dY_l(ix), a          ;; Lo guardo de nuevo
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

   ;;; Cambio update
   ld hl, #enemy_checkGoal
   ld en_up_h(ix), h
   ld en_up_l(ix), l

   ; jp enemy_checkGoal
   ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CHECKEA SI HA LLEGADO A SU DESTINO
;; _______________________
;; ENTRADA:    IX -> Puntero a entidad enemigo del bucle
;; DESTRUYE:   A,HL,DE,B
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

   ;; Primero hay que comprobar si la posicion
   ;; a la que se va a mover NO ES UN OBSTACULO
   ;; - OBSTACULO = EL BIT MAS SIGNIFICATIVO ES 0 (por ahora)

   call checkTileCollision
   jr nz, no_colision       ;; SI EL BIT 3 ES 1 -> HAY COLISION
      ld en_vx(ix),  #0          ;; Pongo a 0 -> RESET
      ld en_vy(ix),  #0          ;; Pongo a 0 -> RESET

      ld hl, #enemy_randomGoal      ;; Vuelvo a cambiar el update del enemigo
      ld en_up_h(ix), h
      ld en_up_l(ix), l
      ret
   no_colision:
   ld a, en_x(ix)          ;; Actualizo posicion en X
   add en_vx(ix)           ;; |
   ld en_x(ix), a          ;; x = x + vx

   ld a, en_y(ix)          ;; Actualizo posicion en Y
   add en_vy(ix)           ;; |
   ld en_y(ix), a          ;; y = y + vy
   ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CONSIGUE UN VALOR ALEATORIO CORRESPONDIENTE CON LA POSICION EN X
;; _________________________________________________________________
;; ENTRADA:    IX -> Puntero a entidad enemigo
;; DESTRUYE:   A,BC
;; SALIDA:     A  -> Posicion aleatoria  en X
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
enemy_getRandom_X:
   ld a, en_x(ix)              ;; Cojo la X actual del jugador
   sub #var_r_max              ;; Le resto la distancia maxima a la que quiero ir para sacar el minimo
   ld b, a
   jr nc, not_negative_x       ;; Si el mínimo es menor que 0
       ld b, #0                ;; Se pone a 0
   not_negative_x:

   ld a, en_x(ix)              ;; Cojo la X actual de nuevo
   add #var_r_max              ;; Le sumo la distancia maxima para sacar el maximo
   ld c, a
   cp #MAP_WIDTH               ;; Si el maximo es mayor que el ancho del mapa
   jr c, not_over_Map_Max_x
       ld c, #MAP_WIDTH        ;; Lo pongo al ancho total del mapa
   not_over_Map_Max_x:
   call getRandomInRange       ;; Genero un numero aleatorio entre MIN y MAX

   ld en_g_x(ix), a             ;; Cargo la posicion random en el enemigo
   ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CONSIGUE UN VALOR ALEATORIO CORRESPONDIENTE CON LA POSICION EN Y
;; _________________________________________________________________
;; ENTRADA:    IX -> Puntero a entidad enemigo
;; DESTRUYE:   A,BC
;; SALIDA:     A  -> Posicion aleatoria  en Y
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
enemy_getRandom_Y:
   ld a, en_y(ix)               ;; Cojo la Y actual del jugador
   sub #var_r_max               ;; Le resto la distancia maxima a la que quiero ir para sacar el minimo
   ld b, a
   jr nc, not_negative_y        ;; Si el mínimo es menor que 0
       ld b, #0                 ;; Lo pongo a 0
   not_negative_y:

   ld a, en_y(ix)               ;; Cojo la Y actual de nuevo
   add #var_r_max               ;; Le sumo la distancia maxima para sacar el maximo
   ld c, a
   cp #MAP_HEIGHT               ;; Si el maximo es mayor que el ancho del mapa
   jr c, not_over_Map_Max_y
       ld c, #MAP_HEIGHT        ;; Lo pongo al ancho total del mapa
   not_over_Map_Max_y:
   call getRandomInRange

   ld en_g_y(ix), a                          ;; Cargo la posicion random en el enemigo
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DETERMINA SI HA COLISIONADO CON ALGUN TILE CON COLISION DEL MAPA
;; NOTA:       Aplicar una comprobacion de z despues del call para comprobar colision
;; ___________________________________________________________________________________
;; ENTRADA:    IX -> Entidad a comprobar con COORDENADAS en TILES
;; DESTRUYE:   A,BC,DE,HL -> LA DETRUCCIONE E TOTALE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
checkTileCollision::
   ;; Guardo en C,A (x,y) para las comprobaciones
   ld a, en_y(ix)          ;; Guardo posicion Y nueva en A
   add en_vy(ix)           ;; |

   ;; Miro en el array del mapa comprobando cada tile
   ld    l,    a        ;; L = A \
   ld    h,    #0       ;; H = 0 | -> HL = A

   ld    c,    a        ;; C = A = enemy_y
   ld    b,    #0       ;; B = 0 ----------------> BC = A

   ld    d,    #29      ;; Multiplicar por 30
   loop_mult_y:
      add hl, bc        ;; HL += BC
      dec d             ;; D--
   jr nz, loop_mult_y

   ex    de,   hl          ;; DE = Aumento 'vertical' del array

   ld    hl, (ptr_map)     ;; HL apunta a nivel1
   add   hl, de            ;; HL + incremento en vertical

   ld    a,    en_x(ix)    ;; |
   add en_vx(ix)           ;; E  = Aumento 'horizontal' del array
   ld    e,    a
   ld    d,    #0          ;; DE = Aumento 'horizontal' del array
   add   hl, de

   ;; Ahora HL apunta al tile en concreto donde se va a mover el enemigo
   bit 4, (hl)
   ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; COLISION DE MAPA CON IX EN COORDENADAS DE PANTALLA
;; NOTA:       Aplicar una comprobacion de z despues del call para comprobar colision
;; ___________________________________________________________________________________
;; ENTRADA:    IX -> Entidad a comprobar con COORDENADAS en TILES
;; DESTRUYE:   A,BC,DE,HL -> LA DETRUCCIONE E CASI TOTALE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
checkTileCollision_m::
   ;; ================================ ;;
   ;; IX EN COORDENADAS DE PANTALLA !! ;;
   ;; ================================ ;;
   ;; Guardar en AF' las coordenadas para que no se pierdan
   ld    l,    en_x(ix)       ;; L = X_pantalla
   ld    h,    en_y(ix)       ;; H = Y_pantalla
   call mapa_a_tile           ;; B = X, C = Y

   ;; Guardo en C,A (x,y) para las comprobaciones
   ld    a,    b              ;; Guardo posicion Y nueva en A
   exx                        ;; Guardo el valor de BC en BC' para no destruirlo
   ; add en_vy(ix)              ;; |

   ;; Miro en el array del mapa comprobando cada tile
   ld    l,    a        ;; L = A \
   ld    h,    #0       ;; H = 0 | -> HL = A

   ld    c,    a        ;; C = A = enemy_y actualizada con vy
   ld    b,    #0       ;; B = 0 ----------------> BC = A

   ld    d,    #29      ;; Multiplicar por 30
   loop_mult_y_m:
      add hl, bc        ;; HL += BC
      dec d             ;; D--
   jr nz, loop_mult_y_m

   ex    de,   hl          ;; DE = Aumento 'vertical' del array

   ld    hl, (ptr_map)     ;; HL apunta a nivel1
   add   hl, de            ;; HL + incremento en vertical

   exx                     ;; Devuelvo de nuevo el valor de BC
   ld    a,    c
   exx

   ; add en_vx(ix)
   ld    e,    a           ;; E  = Aumento 'horizontal' del array
   ld    d,    #0          ;; DE = Aumento 'horizontal' del array
   add   hl, de

   ;; Ahora HL apunta al tile en concreto donde se va a mover el enemigo
   bit 4, (hl)

   ;; COMPROBAR
   ;;    |
   ;;    v
   ;;  0 0 0 0
   ;;  0 0 0 1
   ;;  0 0 1 0
   ;;  0 0 1 1
   ;;  0 1 0 0
   ;;  0 1 0 1
   ;;  0 1 1 0
   ;;  0 1 1 1

   ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; MIRA SI EL HEROE ESTA POR DEBAJO DE UNA CIERTA DISTANCIA EN X E Y
;; ASIGNA, ADEMAS, LA POSICION FINAL DEL MOVIMIENTO Y LLAMA A enemy_randomGoal
;; ¡¡ IMPORTANTE !! -> COMPRUEBA LAS DISTANCIAS EN TILES
;; ________________________________________________________________________________
;; ENTRADA:    IX -> Apunta a la entidad enemigo
;; DESTRUYE:   LA DETRUCCIONE E TOTALE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
enemy_heroInRadius:
   ;; Guardo la funcion update
   ;; que se encuentra en HL
   ;; mediante un push a la pila
   ld h, en_up_h(ix)
   ld l, en_up_l(ix)
   push hl

   ;; Consigo los datos del heroe
   ;;          A = X
   ;;          B = Y
   call hero_get_position

   ;; ==============================================================================
   ;; Paso las coordenadas del heroe
   ;;     a coordenadas de tile
   ;;          L = X
   ;;          H = Y
   ld    l,    a
   ld    a,    b
   ld    h,    a
   call mapa_a_tile
   ;; Ahora tengo las coordenadas
   ;;     del heroe en tiles
   ;;          C = X
   ;;          B = Y
   ;; ==============================================================================

   ;; ==============================================================================
   ;; Comparo las posiciones de X
   ;; y consigo la distancia en el eje X
   ld    a,    c
   sub   en_x(ix)
   jr nc, hIR_x_positive
      neg
   hIR_x_positive:

   ;; Aplico el rango que se elija
   ;;       RANGE = 4
   cp    #5
   jr    nc, hIR_end
      jr hIR_check_y
   ;; ==============================================================================

   hIR_check_y:
   ;; ==============================================================================
   ;; Comparo las posiciones de Y
   ;; y consigo la distancia en el eje Y
   ld    a,    b
   sub   en_y(ix)
   jr    nc, hIR_y_positive
      neg
   hIR_y_positive:

   ;; Aplico el rango que se elija
   ;;       RANGE = 6
   cp    #7
   jr    nc, hIR_end
      ld en_col(ix), #0xFE
      jr hIR_doThings
      ;; ==============================================================================

   hIR_end:
   ld en_col(ix), #0x0F

   ;; Actualizo la funcion de update
   ;; y asigno la funcion por defecto
   pop hl
   ld en_up_h(ix), h
   ld en_up_l(ix), l
   ret

   hIR_doThings:

   ;; ============================================================================================
   ;; V1: Sigue al personaje
   ;; Consigo los datos del heroe
   ;;          A = X
   ;;          B = Y
   call hero_get_position
   ;; ===============================
   ;; Paso las coordenadas del heroe
   ;;     a coordenadas de tile
   ;;          L = X
   ;;          H = Y
   ld    l,    a
   ld    a,    b
   ld    h,    a
   call mapa_a_tile

   ;; Libero el registro del
   ;; contenido de la pila
   ;; que he almacenado al
   ;; principio de la funcion
   pop hl

   ;; Ahora se:
   ;;    - d(hero,enemy) <= 4
   ;;    - Posicion del heroe = (B,C) = (X,Y) = posicion final del movimiento
   ld    e, #0xEE          ;; Senyal a enemy_randomGoal para que no busque ningun random
   jp enemy_randomGoal
   ;; ============================================================================================

;=================================
; Generates random number in range
; Return: A = Random
; Input: [B = MIN, C = MAX]
;=================================
getRandomInRange::
    exx
    call cpct_getRandom_mxor_u8_asm
    ld a, l
    exx
    reduce_max:
    cp c
    jr c, ensure_min
    sub c
    jr reduce_max
    ensure_min:
    add b
ret

enemy_load::
   ld iy, #vector_init
   ret

get_enemy_size::
   ld a, #enemy_size
   ret









