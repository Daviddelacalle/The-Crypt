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

HERO_LIVES:: .db #K_HERO_LIVES

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
    call checkFinalaco

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

            ld b, #-1                       ;Speed
            call checkLeftBorderForTilemapCollision
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

                ld b, #1                        ;Speed
                call checkRightBorderForTilemapCollision
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

                ld b, #-4                       ;Speed
                call checkUpperBorderForTilemapCollision
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

                ld b, #4                       ;Speed
                call checkLowerBorderForTilemapCollision
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


checkTeleporter::
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
        call teleport_sfx
        call loadNextLevel
    pop ix
ret

resetHero::
    ld hl, #HeroSpawn
    ld ix, #hero
    ld a, (hl)
    ld e_x(ix), a
    inc hl
    ld a, (hl)
    ld e_y(ix), a
    ; ld a, #K_HERO_LIVES
    ; ld (HERO_LIVES), a
ret

hero_get_iy::
  ld iy, #hero
ret

teleport_sfx::
    ;SALVO TODOS LOS REGISTROS PARA NO SOBREESRIBIR NADA

    push ix
    push af
    push bc
    push de
    push hl
    push iy
    ld l, #2  ;INSRUMENTO
    ld h, #15  ;VOLUMEN
    ld e, #22 ;NOTA
    ld d, #05   ;VELOCIDAD
    ld bc, #0  ;PITCH
    ld a, #2   ;CANAL
    call cpct_akp_SFXPlay_asm

    pop iy
    pop hl
    pop de
    pop bc
    pop af
    pop ix

  ret

checkFinalaco:
    ;; Primero miro si el nivel es el 21
    ld a, (current_level_1by1)
    cp #19
    ret nz

    ;; Miro si el heroe pisa el tile en concreto
    ld l, e_x(ix)
    ld h, e_y(ix)
    call checkTileCollision_m

    ;; En HL tengo el tile en concreto
    ;; Miro si es el 24 -> COFRE
    ld a, (hl)
    cp #24
    ret nz
    call loadVictory
    ld a, #0xFF
ret








