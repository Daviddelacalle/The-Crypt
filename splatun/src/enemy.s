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

DefineEnemy enemy_copy, #10, #10, #1, #4, #0, #0, #0x0F, #enemy_randomGoal, #0, #0, #0

vector_init:                  ;; Etiqueta de inicio del vector
DefineNEnemies enemy, k_max_enemies
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
save_dX:    .dw #0x0000    ;; Para Bresenham
save_dY:    .dw #0x0000    ;; Para Bresenham
IncYr:      .db #0x00      ;; Serian el contrario de las VY de la entidad --> LLEVAR A DATOS PARAMETRIZABLES!!
IncXr:      .db #0x00      ;; Serian el contrario de las VX de la entidad --> LLEVAR A DATOS PARAMETRIZABLES!!
av:         .dw #0x0000    ;; VALORES DE INICIALIZACION DEL ALGORITMO
avR:        .dw #0x0000    ;; VALORES DE INICIALIZACION DEL ALGORITMO
avI:        .dw #0x0000    ;; VALORES DE INICIALIZACION DEL ALGORITMO
flag_vel:   .db #0x01      ;; 1 = Esta utilizando IncYi/IncXi |------------| 0 = Esta utilizando IncYr/IncXr
enemy_randomGoal:
   ld    a, (flag_move)          ;; Cargo en A un contador para que no busque todo el rato
   dec   a                       ;; A--
   ld    (flag_move), a          ;; Lo actualizo
   ret   nz                      ;; Si no ha llegado a 0 hace ret

   ld    a, #20                  ;; Inicio de nuevo el contador para despues
   ld (flag_move), a

   ;;RESET DE LOS VALORES
   ld hl, #0
   ld (save_dX),  hl
   ld (save_dY),  hl
   ld (IncXr),    hl
   ld (IncYr),    hl
   ld (av),       hl
   ld (avR),      hl
   ld (avI),      hl
   ;ld en_vx(ix),  #0
   ;ld en_vy(ix),  #0


   ;; PARTE 1 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   ;; X
   get_random_x:
      call cpct_getRandom_mxor_u8_asm        ;; Lo devuelve en L
      ld    a,    l                          ;; Cargo en A el random que se ha cargado en L
      cp    #80                              ;; Miro que este dentro del rango 0-80 (dec)
   jr    nc, get_random_x                    ;; Si no esta dentro del rango, lo vuelve a buscar

   ld en_g_x(ix), l                          ;; Cargo la posicion random en el enemigo

   ;; Saco vector VX del enemigo
   ld    a,    l              ;; Posicion X del objetivo
   sub   en_x(ix)             ;; Resto la posicion actual del enemigo
   ld    (save_dX), a       ;; Guardo el valor para despues, en A guardo la DISTANCIA
   ;cp    #80                  ;; |
   jr c, vx_neg              ;; Si C==1, la distancia es negativa
      ld    en_vx(ix), #1        ;; VX =  1
      jr continua_y
   vx_neg:
      ld    en_vx(ix), #-1       ;; VX = -1
      cpl                        ;; Invierto bites de A, que guarda la distancia
      inc   a                    ;; Le sumo 1 y entonces -> A = -A
      ld (save_dX) , a         ;; Lo guardo de nuevo
      ld    a,    #0xFF          ;; | A = 0xFF
      ld (save_dX+1), a            ;; Ya que es negativo -> FF**
   continua_y:

   ;; Y
   get_random_y:
      call cpct_getRandom_mxor_u8_asm        ;; Lo devuelve en L
      ld    a,    l                          ;; Cargo en A el random que se ha cargado en L
      cp    #200                             ;; Miro que este dentro del rango 0-200 (dec)
   jr    nc, get_random_y                    ;; Si no esta dentro del rango, lo vuelve a buscar

   ld en_g_y(ix), l                          ;; Cargo la posicion random en el enemigo

   ;; Saco vector VY del enemigo
   ld    a,    l                 ;; Posicion Y del objetivo
   sub   a, en_y(ix)             ;; Posicion Y del enemigo
   ld    (save_dY), a            ;; Guardo el valor para despues
   ;cp    #200                    ;; |
   jr c, vy_neg                 ;; Si C==0 la distancia es negativa -> COMPROBAR EN EJECUCION
         ld    en_vy(ix), #1        ;; VY =  1
         cpl                        ;; Invierto bites de A, que guarda la distancia
         inc   a                    ;; Le sumo 1 y entonces -> A = -A
         ld (save_dY), a          ;; Lo guardo de nuevo
         ld    a,    #0xFF          ;; | A = 0xFF
         ld (save_dY+1), a            ;; Ya que es negativo -> FF**
      jr continua_fin
   vy_neg:
      ld    en_vy(ix), #-1       ;; VY = -1
   continua_fin:

;;-------------------------------;

   ;;; X
   ;get_random_x:
   ;   call cpct_getRandom_mxor_u8_asm        ;; Lo devuelve en L
   ;   ld    a,    l                          ;; Cargo en A el random que se ha cargado en L
   ;   cp    #80                              ;; Miro que este dentro del rango 0-80 (dec)
   ;jr    nc, get_random_x                    ;; Si no esta dentro del rango, lo vuelve a buscar

   ;ld en_g_x(ix), l                          ;; Cargo la posicion random en el enemigo

   ;;; Saco vector VX del enemigo
   ;ld    a, en_x(ix)             ;; Posicion X del enemigo
   ;cp    en_g_x(ix)              ;; Resto la posicion X del goal
   ;;; Si C == 1, goal_x esta mas a la derecha
   ;jr nc, vx_neg
   ;   ld    en_vx(ix), #1        ;; VX =  1
   ;   jr continua_y
   ;vx_neg:
   ;   ld    en_vx(ix), #-1       ;; VX = -1
   ;continua_y:

   ;;; Y
   ;get_random_y:
   ;   call cpct_getRandom_mxor_u8_asm        ;; Lo devuelve en L
   ;   ld    a,    l                          ;; Cargo en A el random que se ha cargado en L
   ;   cp    #80                              ;; Miro que este dentro del rango 0-80 (dec)
   ;jr    nc, get_random_y                    ;; Si no esta dentro del rango, lo vuelve a buscar

   ;ld en_g_y(ix), l                          ;; Cargo la posicion random en el enemigo

   ;;; Saco vector VX del enemigo
   ;ld    a, en_y(ix)             ;; Posicion X del enemigo
   ;cp    en_g_y(ix)              ;; Resto la posicion X del goal
   ;;; Si C == 1, goal_y esta mas abajo
   ;jr nc, vy_neg
   ;   ld    en_vy(ix), #1        ;; VX =  1
   ;   jr continua_fin
   ;vy_neg:
   ;   ld    en_vy(ix), #-1       ;; VX = -1
   ;continua_fin:
;;-------------------------------;

   ;; PARTE 2 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   ld    hl, (save_dY)        ;; Cargo en HL el valor de dY
   ex    de,   hl             ;; -- DE = dY
   ld    hl, (save_dX)        ;; -- HL = dX
   jr    nc, no_carry         ;; Si C = 0, no hago nada
      ccf                     ;; Si entra aqui, C = 1, entonces invierto -> C = 0
   no_carry:
   sbc   hl,   de             ;; HL - DE = dX - dY ---> AL UTILIZAR TAMBIEN EL CARRY FLAG, LO PONGO A 0 ANTES DE HACER NADA
   jr nc, dy_es_mayor           ;;  >>--------------------->> MUCHA DUDA SOBRE ESTE nc <<---------------------<<
      ;;if dX>=dY
      ld    a,    #0          ;; A = 0
      ld (IncYr), a           ;; --> IncYr = 0
      ld    a, en_vx(ix)      ;; A = IncXi = VX
      ld (IncXr), a           ;; --> IncXr = IncXi ----> IncXi = VX = INCREMENTO QUE SE APLICA A LAS SECCIONES CON AVANCE INCLINADO
      jr continua_fin2
   dy_es_mayor:
      ;;if dY>dX
      ld    a,    #0          ;; A = 0
      ld (IncXr), a           ;; -- IncXr = 0
      ld    a, en_vy(ix)      ;; A = IncYi = VY
      ld (IncYr), a           ;; -- IncYr = IncYi ----> IncYi = VY = INCREMENTO QUE SE APLICA A LAS SECCIONES CON AVANCE INCLINADO

      ld    hl, (save_dX)     ;; =============================== ;;
      ex    de,   hl          ;; INTERCAMBIO LOS VALORES dX y dY ;;
      ld    hl, (save_dY)     ;;             k  = dX             ;;
      ld (save_dX), hl        ;;             dX = dY             ;;
      ex    de,   hl          ;;             dY =  k             ;;
      ld (save_dY), hl        ;; =============================== ;;
   continua_fin2:

   ;; INICIALIZAR VALORES RAROS
   ld    hl,   (save_dY)      ;; HL  = dY
   add   hl,   hl             ;; HL + HL = 2 * dY
   ld (avR),   hl             ;; --> avR = (2 * dY)

   ;; Hay que negar dX y luego sumarlo
   ;; En DE tendre el valor de dX y en HL ya he conseguido el valor de avR
   ;; av = (HL + (-DE))
   ld    a,    (save_dX+1)    ;; Consigo el valor 'negado' 00/FF
   cp    #0                   ;; A - 0
   ld    d,    #0             ;; D = 0 -> PARA QUITAR COMPROBACIONES EXTRAS
   jr    nz, dx_neg           ;; Si dX es 0, entro
      ld    d,    #0xFF       ;; D = FF
   dx_neg:
   ld    a,    (save_dX)      ;; A  = dX
   cpl                        ;; Invierto bites de A -> COMPLEMENTO A 1
   inc   a                    ;; Le sumo 1 y entonces -> A = -A
   ld    e,    a              ;; DE = (00**)/(FF**), donde ** = -dX
   add   hl,   de             ;; avR + -(dX)
   ld (av), hl                ;; --> av = (avR - dX)

   ;; En HL ya tengo av y en DE tengo -dX
   ;; Solo tengo que sumarlo
   add   hl,   de             ;; av + -(dX)
   ld (avI),   hl             ;; --> avI = (av - dX)

   ;; 'DEBUG'
   ld    de, #0xC000          ;;Comienzo memoria de video
   ld     c, en_g_x(ix)       ;; C = Entity X
   ld     b, en_g_y(ix)       ;; B = Entity Y
   call cpct_getScreenPtr_asm
   ;; SIN SPRITE
   ex    de,   hl             ;; Apunta a la posicion x,y
   ld     a,   #0xDD          ;; Código de color
   ld     c,   #1             ;; Ancho
   ld     b,   #4             ;; Alto
   call cpct_drawSolidBox_asm



   ;;; Cambio update
   ld hl, #enemy_checkGoal
   ld en_up_h(ix), h
   ld en_up_l(ix), l
   ret

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

   ld    hl,   (av)           ;; HL = av
   ld    de,   #0x7FFF        ;; DE = 7FFF
   jr    nc, no_carry2        ;; Si C = 0, no hago nada
      ccf                     ;; Si entra aqui, C = 1, entonces invierto -> C = 0
   no_carry2:
   sbc   hl,   de
   jr    c,    av_negativo
      ;; Aqui av, es positivo o 0
      ld    a,    (flag_vel)
      cp    #1
      jr    z, utiliza_i      ;; NECESITA UTILIZAR i
         ;; Cambiar de r a i
         ;; CAMBIO DE LAS Y
         ld    a,    (IncYr)     ;; A = IncYr
         ld    b,    a           ;; B = A = IncYr
         ld    a,    en_vy(ix)   ;; A = IncYi
         ld (IncYr), a           ;; Intercambio 1
         ld    a,    b           ;; A = B = IncYr
         ld en_vy(ix), a         ;; Intercambio 2

         ;; CAMBIO DE LAS X
         ld    a,    (IncXr)     ;; A = IncXr
         ld    b,    a           ;; B = A = IncXr
         ld    a,    en_vx(ix)   ;; A = IncXi
         ld (IncXr), a           ;; Intercambio 1
         ld    a,    b           ;; A = B = IncXr
         ld en_vx(ix), a         ;; Intercambio 2

         ld    a,    #1             ;; Finalmente cambio el flag de la velocidad
         ld (flag_vel), a           ;; flag_vel = 0
      utiliza_i:
         ;; Aqui no hace falta cambiar ninguna velocidad
         ld    hl,   (av)        ;; HL = av
         ex    de,   hl          ;; -- DE = av
         ld    hl,   (avI)       ;; -- HL = avI
         add   hl,   de          ;; DE + HL
         ld    (av), hl          ;; -- av = (av + avI)
      jr end_if
   av_negativo:
      ;; Aqui av, es negativo
      ;;     X = (X + IncXr)     // X aumenta en recto.
      ;;     Y = (Y + IncYr)     // Y aumenta en recto.
      ;;     av = (av + avR)     // Avance Recto
      ld    a,    (flag_vel)
      cp    #0
      jr    z, utiliza_r      ;; NECESITA UTILIZAR r
         ;; Cambiar de i a r
         ;; CAMBIO DE LAS Y
         ld    a,    (IncYr)     ;; A = IncYr
         ld    b,    a           ;; B = A = IncYr
         ld    a,    en_vy(ix)   ;; A = IncYi
         ld (IncYr), a           ;; Intercambio 1
         ld    a,    b           ;; A = B = IncYr
         ld en_vy(ix), a         ;; Intercambio 2

         ;; CAMBIO DE LAS X
         ld    a,    (IncXr)     ;; A = IncXr
         ld    b,    a           ;; B = A = IncXr
         ld    a,    en_vx(ix)   ;; A = IncXi
         ld (IncXr), a           ;; Intercambio 1
         ld    a,    b           ;; A = B = IncXr
         ld en_vx(ix), a         ;; Intercambio 2

         ld    a,    #0             ;; Finalmente cambio el flag de la velocidad
         ld (flag_vel), a           ;; flag_vel = 0
      utiliza_r:
         ;; Aqui no hace falta cambiar ninguna velocidad
         ld    hl,   (av)        ;; HL = av
         ex    de,   hl          ;; -- DE = av
         ld    hl,   (avR)       ;; -- HL = avR
         add   hl,   de          ;; DE + HL
         ld    (av), hl          ;; -- av = (av + avR)
   end_if:
   ret

















