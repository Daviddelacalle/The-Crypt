;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ENTIDAD HEROE
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

CAMERA_TARGET_X = 3
CAMERA_TARGET_Y = 5

hero_x = .
hero_y = . + 1
DefineEntity hero, #INIT_X, #INIT_Y, #4, #8, 0x00, 0x00, #_sp_hero_00, 0x0000

HERO_LIVES: .db #3

;;======================================================================
;;======================================================================
;; FUNCIONES PUBLICAS
;;======================================================================
;;======================================================================



;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DIBUJADO DE LA ENTIDAD HERO
;;;;;;;;;;;;;;;;;;;;;;;;;;;
hero_draw::
    ld   ix,   #hero    ;; ix apunta a los datos del heroe
    ; ld   a, #0         ;; Por si las moscas
    jp dw_draw

hero_update::
    ld    ix,   #hero   ; Se puede borrar si hero es el ultimo en hacer dro
    ld e_vx(ix), #0
    ld e_vy(ix), #0

    call checkTeleporter

    call cpct_scanKeyboard_asm

    ld hl, #Key_A                           ;; Check Key A
    call cpct_isKeyPressed_asm

    jr z, a_no_pulsada

        ld hl, #CoordMapMin
        ld a, e_x(ix)                       ;; Pruebo la primera condicion
        sub (hl)
        cp #LEFT+1
        jr nc, move_the_character_A         ;; Si no estoy en el centro, muevo el jugador

        ld a, (cam_min)                    ;;
        cp #0                               ;; Borde izquierdo (0)
        jr z, move_the_character_A          ;; Si se ha pulsado la A y no estoy en el borde
                                            ;; muevo el mapa
        ;;  Set Camera Target X
            ld b, #-CAMERA_TARGET_X
            call setTargetX

        move_the_character_A:
            ;; Actualizo el sprite del heroe
            ld hl, #_sp_hero_01
            ld e_spr_l(ix), l
            ld e_spr_h(ix), h

            call getUpperLeftCorner
            dec l
            call check_colision
            cp #1
            jr z, d_no_pulsada
            call getLowerLeftCorner
            dec l
            call check_colision
            cp #1
            jr z, d_no_pulsada

            ld b, #-1                       ;; Cambio la velocidad del jugador a 2
            ld e_vx(ix), b



    jr d_no_pulsada             ;; Si se ha pulsado no compruebes la tecla D

    a_no_pulsada:
        ld hl, #Key_D               ;; Comprueba tecla D
        call cpct_isKeyPressed_asm
        jr z, d_no_pulsada

            ld hl, #CoordMapMin             ;; Le resto el borde izq de la cámara
            ld a, e_x(ix)
            sub (hl)
            cp #RIGHT-1                       ;; Para comprobar si está en el punto dónde debe hacer scroll
            jr c, move_the_character_D     ;; Si no es ese punto, simplemente mueve el personaje

            ld a, (cam_min)                 ;; Estamos en el punto!
            cp #LimitRight                  ;; Comprobemos ahora si la cámara no está en el borde ya
            jr z, move_the_character_D      ;; Estamos en el borde!, simplemente mueve el personaje

            ;;  Set Camera Target X         ;; Estamos en el punto y la cámara no está en el borde
                ld b, #CAMERA_TARGET_X      ;; Mueve la cámara 3 tiles a la derecha
                call setTargetX

            move_the_character_D:
                ;; Actualizo el sprite del heroe
                ld hl, #_sp_hero_02
                ld e_spr_l(ix), l
                ld e_spr_h(ix), h

                call getUpperRightCorner    ;; Obtengo la esquina superior derecha del personaje L = X
                inc l                       ;; Incremento 1 la X, para comprobar si en el siguiente frame chocamos
                call check_colision
                cp #1
                jr z, d_no_pulsada

                call getLowerRightCorner    ;; Repeat
                inc l
                call check_colision
                cp #1
                jr z, d_no_pulsada

                ld b, #1                    ;; Creo que esto no necesita explicación
                ld e_vx(ix), b              ;; Simplmente pon la velocidad a 1
            jr d_no_pulsada



    d_no_pulsada:
        ld hl, #Key_W
        call cpct_isKeyPressed_asm
        jr z, w_no_pulsada

            ld hl, #CoordMapMin+1
            ld a, e_y(ix)
            sub (hl)

            cp #TOP+1
            jr nc, move_the_character_W

            ld a, (cam_min+1)
            cp #0
            jr z, move_the_character_W

            ;;  Set Camera Target Y
                ld b, #-CAMERA_TARGET_Y
                call setTargetY

            move_the_character_W:
                ;; Actualizo el sprite del heroe
                ld hl, #_sp_hero_00
                ld e_spr_l(ix), l
                ld e_spr_h(ix), h

                ld d, #-4
                ld e, #0
                call getUpperRightCorner
                    add hl, de
                call check_colision
                cp #1
                jr z, s_no_pulsada

                ld d, #-4
                ld e, #0
                call getUpperLeftCorner
                    add hl, de
                call check_colision
                cp #1
                jr z, s_no_pulsada

                ld b, #-4
                ld e_vy(ix), b

        jr s_no_pulsada

    w_no_pulsada:
        ld hl, #Key_S
        call cpct_isKeyPressed_asm
        jr z, s_no_pulsada

            ld hl, #CoordMapMin+1
            ld a, e_y(ix)
            sub (hl)

            cp #BOTTOM-1
            jr c, move_the_character_S

            ld a, (cam_min+1)
            cp #LimitDown
            jr z, move_the_character_S

            ;;  Set Camera Target Y
                ld b, #CAMERA_TARGET_Y
                call setTargetY

            move_the_character_S:
                ;; Actualizo el sprite del heroe
                ld hl, #_sp_hero_03
                ld e_spr_l(ix), l
                ld e_spr_h(ix), h

                ld d, #4
                ld e, #0
                call getLowerLeftCorner
                    add hl, de
                call check_colision
                cp #1
                jr z, s_no_pulsada

                ld d, #4
                ld e, #0
                call getLowerRightCorner
                    add hl, de
                call check_colision
                cp #1
                jr z, s_no_pulsada

                ld b, #4
                ld e_vy(ix), b

            jr s_no_pulsada
    s_no_pulsada:

    ld  a, e_x(ix)
    add a, e_vx(ix)
    ld  e_x(ix), a

    ld a, e_y(ix)
    add a, e_vy(ix)
    ld e_y(ix), a


    jp update_cam                   ;; Recusión de cola! Actualiza la cámara

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CARGA EN LOS REGISTROS A,B LOS VALORES DE X,Y
;; _______________________
;; DESTRUYE: A, B
;;;;;;;;;;;;;;;;;;;;;;;;;;;
hero_get_position::
   ld    a,    (hero_y)
   ld    b,    a
   ld    a,    (hero_x)
   ret

;;======================================================================
;;======================================================================
;; FUNCIONES PRIVADAS
;;======================================================================
;;======================================================================


getUpperRightCorner:
    ld a, e_x(ix)       ;; Si mi personaje está en X = 0
        add e_w(ix)     ;; y le sumo el ancho que es 8, X = 8
        dec a           ;; que es el inicio del siguiente tile
    ld l, a             ;; por eso le resto 1, el border derecho
    ld h, e_y(ix)       ;; seria 7 realmente, [0, 7]
ret

getLowerRightCorner:
    ld a, e_x(ix)
        add e_w(ix)
        dec a
    ld l, a
    ld a, e_y(ix)
        add e_h(ix)
        dec a
    ld h, a
ret

getUpperLeftCorner:
    ld l, e_x(ix)
    ld h, e_y(ix)
ret

getLowerLeftCorner:
    ld l, e_x(ix)
    ld a, e_y(ix)
        add e_h(ix)
        dec a
    ld h, a
ret

check_colision::
    call    checkTileCollision_m
    ld a, #1
    ret z
    ld a, #0
ret

checkTeleporter:
    ld a, (NumberOfEnemies)
    cp #0
    ret nz

    ld h, e_y(ix)
    ld l, e_x(ix)
    call mapa_a_tile

    ld a, (Teleporter)
    cp c
    ret nz
    ld a, (Teleporter+1)
    cp b
    ret nz
    push ix
    call loadNextLevel
    pop ix
ret

resetHero::
    ld ix, #hero
    ld e_x(ix), #INIT_X
    ld e_y(ix), #INIT_Y
    ld a, #3
    ld (HERO_LIVES), a
ret

hero_get_iy::
  ld iy, #hero
ret

