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


save_xm: .db #0x00      ;; Guarda
save_ym: .db #0x00

hero_x = .
hero_y = . + 1
DefineEntity hero, #INIT_X, #INIT_Y, 0x02, 0x08, 0x00, 0x00, 0x0F, 0x0000

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

    ;; Reset
    ld hl, #0x0000
    ld (save_xm), hl

    call cpct_scanKeyboard_asm


    ld hl, #Key_A                           ;; Check Key A
    call cpct_isKeyPressed_asm

    jr z, a_no_pulsada

        ld hl, #CoordMapMin
        ld a, e_x(ix)                       ;; Pruebo la primera condicion
        sub (hl)
        cp #LEFT
        jr nz, move_the_character_A         ;; Si no estoy en el centro, muevo el jugador

        ld a, (cam_min)                    ;;
        cp #0                               ;; Borde izquierdo (0)
        jr z, move_the_character_A          ;; Si se ha pulsado la A y no estoy en el borde
                                            ;; muevo el mapa
        ;;  Set Camera Target X
            ld b, #-CAMERA_TARGET_X
            call setTargetX

        move_the_character_A:
            ld a, #-1                       ;; Para la comprobacion de colisiones
            ld (save_xm), a

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
            cp #RIGHT                       ;; Para comprobar si está en el punto dónde debe hacer scroll
            jr nz, move_the_character_D     ;; Si no es ese punto, simplemente mueve el personaje

            ld a, (cam_min)                 ;; Estamos en el punto!
            cp #LimitRight                  ;; Comprobemos ahora si la cámara no está en el borde ya
            jr z, move_the_character_D      ;; Estamos en el borde!, simplemente mueve el personaje

            ;;  Set Camera Target X         ;; Estamos en el punto y la cámara no está en el borde
                ld b, #CAMERA_TARGET_X      ;; Mueve la cámara 3 tiles a la derecha
                call setTargetX

            move_the_character_D:
                ld a, #1                       ;; Para la comprobacion de colisiones
                ld (save_xm), a

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

            cp #TOP
            jr nz, move_the_character_W

            ld a, (cam_min+1)
            cp #0
            jr z, move_the_character_W

            ;;  Set Camera Target Y
                ld b, #-CAMERA_TARGET_Y
                call setTargetY

            move_the_character_W:
                ld a, #-1                       ;; Para la comprobacion de colisiones
                ld (save_ym), a

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

            cp #BOTTOM
            jr nz, move_the_character_S

            ld a, (cam_min+1)
            cp #LimitDown
            jr z, move_the_character_S

            ;;  Set Camera Target Y
                ld b, #CAMERA_TARGET_Y
                call setTargetY

            move_the_character_S:
                ld a, #8                       ;; Para la comprobacion de colisiones
                ld (save_ym), a

                ld b, #4
                ld e_vy(ix), b

            jr s_no_pulsada
    s_no_pulsada:

    ;; Consigo los valores según se hayan guardado
    ;; Depende de si se han pulsado algunas teclas de movimiento
    ld hl, (save_xm)
    ;;  - EN L TENGO 4 (derecha)    o -4 (izquierda)
    ;;  - EN H TENGO 8 (abajo)      o -8 (arriba)

    ld  a, e_x(ix)                  ;; Consigue la posicion del jugador
    add a, l                        ;; Le sumo la velocidad, lo hago aqui en vez del update de jugador para evitar restar en clear
    ld  e_x(ix), a                  ;; Lo guardo en su registro

    ld a, e_y(ix)                   ;; Repito para Y
    add a, h
    ld e_y(ix), a

    ;; Comprueba la colision con las tiles del mapa
    call    checkTileCollision_m
    ;; L = C
    ;; H = D
    ld hl, (save_xm)
    jr nz, hero_no_colisiona
        ;; Hago reset de las posiciones
        ld  a, e_x(ix)
        sub a, l
        ld  e_x(ix), a

        ld a, e_y(ix)
        sub a, h
        ld e_y(ix), a

        ret
    hero_no_colisiona:
    ld  a, e_x(ix)
    sub a, l
    add a, e_vx(ix)
    ld  e_x(ix), a

    ld a, e_y(ix)
    sub a, h
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







