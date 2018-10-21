;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; MODELO PARA CADA ARCHIVO .s QUE SE CREE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; TODO:
;;    - Copiado de entidades?

.area _DATA
.area _CODE

.include "cpctelera.h.s"
.include "struct.h.s"

;;======================================================================
;;======================================================================
;; DATOS PRIVADOS
;;======================================================================
;;======================================================================
vector_size = 1
bullet_size = 10                    ;; Debe de ser parametrizado, CUANTO ANTES!

K_VEL_X = 2
K_VEL_Y = 4

vector_index:  .dw #0x0000
vector_init:                        ;; Marca el inicio de vector_bullets
DefineNBullets vector_bullets, vector_size
DefineBullet bullet_copy 0xFF, 0xFF, #1, #4, 0, 4, #0x0F, #20, bullet_checkUpdate

save_a:        .db #0x00            ;; Guarda el valor de A
flag_init:     .db #0x00            ;; if(flag_init==1) Hay una entidad bullet que se ha inicializado

vector_keys:
   .dw #Key_CursorUp,      #keyUp_ON      ;; Flecha de arriba
   .dw #Key_CursorDown,    #keyDown_ON    ;; Flecha de abajo
   .dw #Key_CursorRight,   #keyRight_ON   ;; Flecha de derecha
   .dw #Key_CursorLeft,    #keyLeft_ON    ;; Flecha de izquierda
   .db #0xFF                              ;; Fin
flag_vx:       .db #0
flag_vy:       .db #0
flag_shoot:    .db #0                     ;; Solo habra un disparo por cada vez que se pulse cada tecla
flag_key:      .db #0                     ;; Si ha pulsado alguna de las 4 teclas de disparo, flag_key = 1

k_update_count = 1
update_count:  .db #k_update_count        ;; Limita el update a cada 2 frames

;;======================================================================
;;======================================================================
;; FUNCIONES PUBLICAS
;;======================================================================
;;======================================================================

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DIBUJADO DE LA ENTIDAD BULLET
;; _______________________
;; DESTRUYE: HL
;;;;;;;;;;;;;;;;;;;;;;;;;;;
bullet_draw::
   ld    hl,   #bullet_checkDraw
   jp    bullet_search                 ;; Llamada al bucle

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; UPDATE DE TODAS LAS BALAS INICIALIZADAS
;; _______________________
;; DESTRUYE: HL
;;;;;;;;;;;;;;;;;;;;;;;;;;;
bullet_update::
   ld    a, (update_count)                ;; ======================== ;;
   dec   a                                ;;     POR SI AL FINAL      ;;
   ld    (update_count), a                ;;    SE QUIERE LIMITAR     ;;
   cp    #1                               ;;  EL UPDATE DE LAS BALAS  ;;
   ret   z                                ;; ======================== ;;

   ld    hl,   #bullet_searchUpdate
   call    bullet_search                  ;; Llamada al bucle

   ld    a, #k_update_count               ;; REINICIAR EL CONTADOR
   ld    (update_count), a                ;;       DEL UPDATE
   ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; COMPRUEBA LOS INPUTS
;; _______________________
;; DESTRUYE: AF, BC, DE, HL, IX
;;;;;;;;;;;;;;;;;;;;;;;;;;;
bullet_inputs::
   call cpct_scanKeyboard_asm

   ;; ¡¡¡¡¡¡¡¡HAY QUE ARREGLAR ESTO!!!!!!!!
   ;;ld    hl,   #vector_keys         ;; IX apunta al vector de codigos de teclado
   ;;loop:
   ;;   ld     a,   (hl)              ;; A = 0(ix)
   ;;   cp  #0xFF                     ;; El final del vector lo marca un FF
   ;;   jr     z,   end_loop          ;; Sale del bucle en caso que A == FF
   ;;      push  hl
   ;;      call  cpct_isKeyPressed_asm   ;; CPC
   ;;      pop   hl
   ;;   inc   hl                      ;; HL ++
   ;;   inc   hl                      ;; HL ++
   ;;   ld     c,   (hl)              ;; Guardo en BC el valor al que apunta HL
   ;;   inc   hl                      ;; HL ++
   ;;   ld     b,   (hl)              ;; Guardo en BC el valor al que apunta HL
   ;;   inc   hl                      ;; HL ++
   ;;   ld (k_custom), bc             ;;
   ;;      k_custom = . + 1           ;; CARGAR LA FUNCION PROPIA DE CADA KEY
   ;;      call nz, (0x0000)          ;;
   ;;   jr    loop                    ;; Vuelta arriba
   ;;end_loop:

   ;; Bucle mas costoso
   ld    ix,   #vector_keys         ;; IX apunta al vector de codigos de teclado
   loop:
      ld     a,   0(ix)             ;; A = 0(ix)
      cp  #0xFF                     ;; El final del vector lo marca un FF
      jr     z,   end_loop          ;; Sale del bucle en caso que A == FF

      ld     l,   0(ix)             ;; Cargo el codigo de la tecla en HL
      ld     h,   1(ix)             ;; Cargo el codigo de la tecla en HL
      call cpct_isKeyPressed_asm    ;; CPC
      ld     l,   2(ix)             ;; Cargo el codigo de la funcion en HL
      ld     h,   3(ix)             ;; Cargo el codigo de la funcion en HL
      ld (k_custom), hl
         k_custom = . + 1
         call nz, (0x0000)          ;; CUSTOM
         jr z, keep_looping         ;; Si no se ha pulsado ninguna tecla, pasa
            ld a, #1
            ld (flag_key), a        ;; flag_key = ON
      keep_looping:
      ld    de,   #4                ;; Sumo 4 para ir a la siguiente tecla
      add   ix,   de                ;; IX + 4
      jr    loop
   end_loop:

   ld a, (flag_key)                 ;; A = flag_key
   cp #0                            ;; Si A == 1: SE HA PULSADO ALGUNA DE LAS 4 TECLAS DE DISPARO
   jp nz, bullet_init               ;; Si A == 0: NO SE HA PULSADO NINGUNA TECLA DE DISPARO

   jp flag_shoot_off                ;; Volver flag_shoot a 0
ret

;;======================================================================
;;======================================================================
;; FUNCIONES PRIVADAS
;;======================================================================
;;======================================================================
;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CAMBIA LOS FLAGS DE LA VELOCIDAD EN Y
;; _______________________
;; DESTRUYE: A
;;;;;;;;;;;;;;;;;;;;;;;;;;;
keyUp_ON:
   ld a, #-K_VEL_Y
   ld (flag_vy), a
   ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CAMBIA LOS FLAGS DE LA VELOCIDAD EN Y
;; _______________________
;; DESTRUYE: A
;;;;;;;;;;;;;;;;;;;;;;;;;;;
keyDown_ON:
   ld a, #K_VEL_Y
   ld (flag_vy), a
   ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CAMBIA LOS FLAGS DE LA VELOCIDAD EN X
;; _______________________
;; DESTRUYE: A
;;;;;;;;;;;;;;;;;;;;;;;;;;;
keyRight_ON:
   ld a, #K_VEL_X
   ld (flag_vx), a
   ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CAMBIA LOS FLAGS DE LA VELOCIDAD EN X
;; _______________________
;; DESTRUYE: A
;;;;;;;;;;;;;;;;;;;;;;;;;;;
keyLeft_ON:
   ld a, #-K_VEL_X
   ld (flag_vx), a
   ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CAMBIA flag_shoot A 1 E IMPIDE DISPARAR MAS, A MENOS QUE SUELTES LA TECLA
;; _______________________
;; DESTRUYE: A
;;;;;;;;;;;;;;;;;;;;;;;;;;;
flag_shoot_on:
   ld a, #1
   ld (flag_shoot), a
   ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CAMBIA flag_shoot A 0 Y PERMITE DISPARAR MAS VECES AL PULSAR
;; _______________________
;; DESTRUYE: A
;;;;;;;;;;;;;;;;;;;;;;;;;;;
flag_shoot_off:
   ld a, #0
   ld (flag_shoot), a
   ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; INICIALIZA UNA ENTIDAD BULLET
;; _______________________
;; DESTRUYE: HL, A
;;;;;;;;;;;;;;;;;;;;;;;;;;;
bullet_init:
   ;; Comprueba que solo se pueda disparar una vez por cada pulsacion de tecla
   ld a, (flag_shoot)               ;; A = flag_shoot
   cp #0                            ;; A - 0 = A
   jr nz, bullet_init_end           ;; Si flag_shoot == 1, vuelve

   ld    hl,   #bullet_checkInit
   call  bullet_search              ;; Llamada al bucle
   call  flag_shoot_on              ;; Si llega aqui, es que se ha pulsado alguna tecla, entonces flag = ON

   bullet_init_end:
   ;; Reset de los flags
   ld     a,   #0
      ld (flag_init), a
      ld   (flag_vx), a
      ld   (flag_vy), a
      ld  (flag_key), a
   ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; RECORRE vector_bullets
;; _______________________
;; ENTRADA:    HL -> Puntero a funcion custom
;; DESTRUYE:   A, DE, IX
;;;;;;;;;;;;;;;;;;;;;;;;;;;
bullet_search:
   ld     a,   #0                ;; Cargo en A el valor inicial 0
   ld    ix,   #vector_init      ;; IX apunta al inicio de vector_bullets (a la primera entidad)
   ld    (f_custom), hl          ;; Cargo en el call de abajo la funcion a la que quiero llamar en cada momento determinado
   search_loop:
      ld (save_a),  a            ;; Guardo el valor de A, porque la llamada a la funcion puede destruirlo

      f_custom = . +1                  ;; . apunta a 'call' y con el '+1' apunta a '(0x0000)' -> (valor arbitrario, puesto que siempre va a cambiar)
      call (0x0000)                    ;; LLAMADA A FUNCION PERSONALIZABLE

      ld    de,   #bullet_size         ;; Cargo en DE el tamanyo de la entidad bullet para despues sumarlo a HL
      add   ix,   de                   ;; IX + DE = Apunta a la siguiente entidad bullet

      ld     a,   (save_a)             ;; Recupero el valor de a
      inc    a                         ;; A++
   cp #vector_size
   jr nz, search_loop
   ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; COMPROBAR SI EN LA ENTIDAD BULLET alive > 0
;; _______________________
;; ENTRADA:    IX -> Puntero a entidad BULLET
;; DESTRUYE:   A
;;;;;;;;;;;;;;;;;;;;;;;;;;;
bullet_checkDraw::
   ld     a,   b_alive(ix)       ;; Cargo el valor de alive en A
   cp    #0                      ;; Si el valor es 0 y le resto 0 -> Z=1
   ; ld a, #0xAA                 ;; Se le manda A = AA a dw_draw ya que LAS COORDEADAS DE LAS BALAS ESTAN EN TILES
   call  nz,   #dw_draw          ;; Llama a la funcion de dibujado
   ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; COMPROBAR SI EN LA ENTIDAD BULLET alive = 0
;; _______________________
;; ENTRADA:    IX -> Puntero a entidad BULLET
;; DESTRUYE:   A, HL, DE, BC
;;;;;;;;;;;;;;;;;;;;;;;;;;;
bullet_checkInit:
   ld     a,   (flag_init)       ;; Si no se ha iniciado ninguna entidad bullet A==0
   cp    #0
   ret   nz                      ;; Si es 1 (1!=0), vuelve y no inicia mas entidades

   ;; Comprueba el atributo alive
   ld     a,   b_alive(ix)       ;; Cargo el valor de alive en A
   cp    #0                      ;; Si el valor es 0 y le resto 0 -> Z=1 -> INICIALIZO
   ret   nz                      ;; Si ya esta inicializada, hago ret

   ;; REALIZA UNA COPIA DE LA ENTIDAD POR DEFECTO
   push  ix                      ;; Guardo IX en la pila
   pop   de                      ;; Entidad DESTINO
   ld    hl,   #bullet_copy      ;; Entidad ORIGEN
   ld    bc,   #bullet_size      ;; Tamanyo de la entidad
   ldir


   ;; DEBO CONSEGUIR UNAS POSICIONES DE TILE DEL HERO
   call hero_get_position           ;; A = hero_x // B = hero_y
   ; ld l, a                       ;; L = X
   ; ld h, b                       ;; H = Y
   ; call mapa_a_tile              ;; Aplica el offset de la camara automaticamente

   ;; Si debo cambiar algo de la entidad, aqui
   ld    b_x(ix), a              ;; Asigno X
   ld    b_y(ix), b              ;; Asigno Y

   ld    a,    (flag_vx)         ;;
   ld    b_vx(ix), a             ;; Asigno VX
   ld    a,    (flag_vy)         ;;
   ld    b_vy(ix), a             ;; Asigno VX

   ld     a,   #1                ;; flag_init = 1
   ld (flag_init), a             ;; YA NO SE PODRA INICIALIZAR NINGUNA ENTIDAD MAS
                                 ;;   EN EL RECORRIDO DE ESTE BUCLE, AHORA MISMO
   ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; LLAMA A CADA FUNCION DE ACTUALIZACION DE CADA ENTIDAD
;; _______________________
;; ENTRADA:    IX -> Puntero a entidad BULLET
;; DESTRUYE:   HL, A
;;;;;;;;;;;;;;;;;;;;;;;;;;;
bullet_searchUpdate:
   ld     a,   b_alive(ix)       ;; Cargo el valor de alive en A
   cp    #0                      ;; Si el valor es 0 y le resto 0 -> Z=1
   ret    z                      ;; Si no se ha inicialiado, poco podemos hacer

   ; call checkTileCollision
   call checkTileCollision_m
   jr nz, no_tile_collision
      ld hl, #bullet_death
      ld b_up_h(ix), h
      ld b_up_l(ix), l
   no_tile_collision:

   call bullet_checkBorderCollision

   call bullet_check_death

   ld l, b_up_l(ix)           ;; Carga el byte bajo en L
   ld h, b_up_h(ix)           ;; Carga el byte alto en H
   jp (hl)                    ;; Llama a la funcion propia de cada entidad

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; COMPROBAR SI EN LA ENTIDAD BULLET alive > 0 Y LO ACTUALIZO
;; _______________________
;; ENTRADA:    IX -> Puntero a entidad BULLET
;; DESTRUYE:   A
;;;;;;;;;;;;;;;;;;;;;;;;;;;
bullet_checkUpdate:
   ;; UPDATE ALIVE
   dec   b_alive(ix)            ;; Decrementar el valor de alive y si llega a 1 matar la bala -> alive = 0

   ;; UPDATE POSICION
   ld     a,   b_x(ix)           ;; Cargo en A la posicion en X
   add b_vx(ix)                  ;; Le aumento la velocidad en X
   ld  b_x(ix), a                ;; Guardo el dato actualizado

   ld     a,   b_y(ix)           ;; Cargo en A la posicion en Y
   add b_vy(ix)                  ;; Le aumento la velocidad en Y
   ld  b_y(ix), a                ;; Guardo el dato actualizado

   ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; MUERTE DE LA BALA
;; ____________________________________________________
;; ENTRADA:    IX -> Puntero a la entidad BULLET
;; DESTRUYE:   A
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
bullet_death:
   ld a, #0
   ld b_alive(ix), a
   ret



;;;;;
bullet_checkBorderCollision::
   ld hl, #CoordMapMin
   ld a, b_x(ix)            ;; A = Posición X  de la bala
   sub (hl)                 ;; A -= CoordMapMin
   ld b, a                  ;; B = A, Tiene la X corregida (de 0 palante)

   ld    a, e_vx(ix)
   cp    #-K_VEL_X
   jr nz , check_right
      ld    a,    #10
      cp    b               ;; En vez de hacer cp de la posición actual, lo hago con la
                            ;; posición actual menos la posición de la cámara
      ret c
         ld hl, #bullet_death
         ld b_up_h(ix), h
         ld b_up_l(ix), l
         ret
   check_right:

   ld    a, e_vx(ix)
   cp    #K_VEL_X
   jr nz , check_up
      ld    a,    #68
      cp    b
      ret nc
         ld hl, #bullet_death
         ld b_up_h(ix), h
         ld b_up_l(ix), l
         ret
   check_up:

   inc hl
   ld a, b_y(ix)
   sub (hl)
   ld b, a

   ld    a, e_vy(ix)
   cp    #-K_VEL_Y
   jr nz , check_down
      ld    a,    #34
      cp    b
      ret c
         ld hl, #bullet_death
         ld b_up_h(ix), h
         ld b_up_l(ix), l
         ret
   check_down:

   ld    a, e_vy(ix)
   cp    #K_VEL_Y
   ret nz
      ld    a,    #152
      cp    b
      ret nc
         ld hl, #bullet_death
         ld b_up_h(ix), h
         ld b_up_l(ix), l
         ret


;; COLISION ENEMIGO-BALA
bullet_check_death::
  ;;tengo que comparar las variables b_x(ix)/b_y(ix) con la posicion de cada enemigo y ver si coinciden

   call enemy_load
   loop_bullet:
   ld a, 0(iy)
      cp #0xFF
      ret z

   ld     h, e_y(iy)
   ld     l, e_x(iy)
   call tile_a_mapa

   ld     a, b_x(ix)
   cp c
   jr nc, death_check_left ;; si el carry es mayor el numero de cp es mas grande
        jr death_check_right

   death_check_left:
      ld a, c
      ld    c, b_x(ix)
      cp c
      jr c, end_loop_bullet
           jr death_check_vertical
   death_check_right:
      ld a, b_x(ix)
      cp c
      jr c, end_loop_bullet
           jr death_check_vertical


   death_check_vertical:
   ld     a, b_y(ix)
   cp b
   jr c, death_check_down ;; si el carry es mayor el numero de cp es mas grande
        jr death_check_up

   death_check_down:
      ld a, b_y(ix)
      add a,#8
      cp b
      jr c, end_loop_bullet
         call bullet_set_death
         ld e_y(iy),#15
         ld e_x(iy),#15
         ret
   death_check_up:
      ld a, b
      add a,#4
      ld    b, b_y(ix)
      cp b
      jr c, end_loop_bullet
         call bullet_set_death
         ld e_y(iy),#15
         ld e_x(iy),#15
         ret

   end_loop_bullet:
      call get_enemy_size
      ld h, #0
      ld l, a
      ex de,hl
      add iy,de
   jr loop_bullet
ret


bullet_set_death:
   ld hl, #bullet_death
   ld b_up_h(ix), h
   ld b_up_l(ix), l
   ret






