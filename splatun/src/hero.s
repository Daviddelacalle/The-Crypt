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

CENTER_X = 40
CENTER_Y = 70


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
            ld b, #-3
            call setTargetX

        move_the_character_A:
            ld b, #-1                       ;; Cambio la velocidad del jugador a 2
            ld e_vx(ix), b



    jr d_no_pulsada             ;; Si se ha pulsado no compruebes la tecla D

    a_no_pulsada:
        ld hl, #Key_D               ;; Comprueba tecla D
        call cpct_isKeyPressed_asm
        jr z, d_no_pulsada
            ld hl, #CoordMapMin
            ld a, e_x(ix)
            sub (hl)
            cp #RIGHT
            jr nz, move_the_character_D

            ld a, (cam_min)
            cp #LimitRight
            jr z, move_the_character_D

            ;;  Set Camera Target X
                ld b, #3
                call setTargetX

            move_the_character_D:
                ld b, #1
                ld e_vx(ix), b
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
                ld b, #-3
                call setTargetY

            move_the_character_W:
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
                ld b, #3
                call setTargetY

            move_the_character_S:
                ld b, #4
                ld e_vy(ix), b

            jr s_no_pulsada

    s_no_pulsada:

    ld a, e_x(ix)                   ;; Consigue la posicion del jugador
    add e_vx(ix)                    ;; Le sumo la velocidad, lo hago aqui en vez del update de jugador para evitar restar en clear
    ld e_x(ix), a                   ;; Lo guardo en su registro

    ld a, e_y(ix)                   ;; Repito para Y
    add e_vy(ix)
    ld e_y(ix), a

    jp update_cam
ret


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







