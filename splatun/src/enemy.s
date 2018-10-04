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

;DefineEntity enemy_copy, #10, #10, #1, #4, #0, #0, #0x0F, #enemy_randomGoal
;
;vector_init:                  ;; Etiqueta de inicio del vector
;DefineNEntities enemy, k_max_enemies
;vector_end:    .db #0xFF      ;; Indico 0xFF como fin del vector

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
enemy_randomGoal:
   ld    a, (flag_move)          ;; Cargo en A un contador para que no busque todo el rato
   dec   a                       ;; A--
   ld    (flag_move), a          ;; Lo actualizo
   ret   nz                      ;; Si no ha llegado a 0 hace ret

   ld    a, #20                  ;; Inicio de nuevo el contador para despues
   ld (flag_move), a

   ;; X
   get_random_x:
      call cpct_getRandom_mxor_u8_asm        ;; Lo devuelve en L
      ld    a,    l                          ;; Cargo en A el random que se ha cargado en L
      cp    #80                              ;; Miro que este dentro del rango 0-80 (dec)
   jr    nc, get_random_x                    ;; Si no esta dentro del rango, lo vuelve a buscar

   ld en_g_x(ix), l                          ;; Cargo la posicion random en el enemigo

   ;; Saco vector VX del enemigo
   ld    a, en_x(ix)             ;; Posicion X del enemigo
   cp    en_g_x(ix)              ;; Resto la posicion X del goal
   ;; Si C == 1, goal_x esta mas a la derecha
   jr nc, vx_neg
      ld    en_vx(ix), #1        ;; VX =  1
      jr continua_y
   vx_neg:
      ld    en_vx(ix), #-1       ;; VX = -1
   continua_y:

   ;; Y
   get_random_y:
      call cpct_getRandom_mxor_u8_asm        ;; Lo devuelve en L
      ld    a,    l                          ;; Cargo en A el random que se ha cargado en L
      cp    #80                              ;; Miro que este dentro del rango 0-80 (dec)
   jr    nc, get_random_y                    ;; Si no esta dentro del rango, lo vuelve a buscar

   ld en_g_y(ix), l                          ;; Cargo la posicion random en el enemigo

   ;; Saco vector VX del enemigo
   ld    a, en_y(ix)             ;; Posicion X del enemigo
   cp    en_g_y(ix)              ;; Resto la posicion X del goal
   ;; Si C == 1, goal_y esta mas abajo
   jr c, vy_pos
      ld    en_vy(ix), #-1       ;; VX = -1
      jr continua_fin
   vy_pos:
      ld    en_vy(ix), #1        ;; VX =  1
   continua_fin:

   ;; Cambio update
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
   ld    b,    #2                   ;; Mini flags para X e Y
   ;; COMPROBACION EN X ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   ld    a,    en_g_x(ix)           ;; Cargo la posicion del goal
   cp    en_x(ix)                   ;; Le resto la posicion del enemigo
   jr nz, check_goal_y
      ld en_vx(ix), #0              ;; VX = 0
      dec b

   check_goal_y:
   ;; COMPROBACION EN Y ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   ld    a,    en_g_y(ix)           ;; Cargo la posicion del goal
   cp    en_y(ix)                   ;; Le resto la posicion del enemigo
   jr nz, no_goal_yet
      ld en_vy(ix), #0              ;; VY = 0
      dec b

      ld    a,    b
      cp    #0                         ;; Si se ha decrementado 2 veces, ya llegado a su destino en X e Y
      jr    nz, no_goal_yet

         ld hl, #enemy_randomGoal      ;; Vuelvo a cambiar el update del enemigo
         ld en_up_h(ix), h
         ld en_up_l(ix), l
   no_goal_yet:
   ;; El spaghetti code de @daNNi
   ret



















