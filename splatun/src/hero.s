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



hero_x = .
hero_y = . + 1
DefineEntity hero, #40, #70, 0x02, 0x08, 0x00, 0x00, 0x0F, 0x0000

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

hero_clear::
    ld ix, #hero
    jp dw_clear

hero_update::
    ld    ix,   #hero   ; Se puede borrar si hero es el ultimo en hacer dro
    ld e_vx(ix), #0
    ld e_vy(ix), #0

    call cpct_scanKeyboard_asm

    ld b, #-2
    ld b, #-2
    ld hl, #Key_A                   ;; Comprueba tecla A
    call cpct_isKeyPressed_asm
    jr z, a_no_pulsada
        ld a, (OffsetX)
        cp #0
        jr nz, move_the_character_A

        ld a, (CameraMinX)
        cp #0
        jr nz, move_the_map_A

        move_the_character_A:
            ld b, #-2
            ld e_vx(ix), b
            ld a, (OffsetX)
            add b
            ld (OffsetX), a
        jr d_no_pulsada

        move_the_map_A:
            ld de, #-1
            call inc_map
            ld b, #-4
            add b
            ld (CameraMinX), a

    jr d_no_pulsada             ;; Si se ha pulsado no compruebes la tecla D

    a_no_pulsada:
        ld hl, #Key_D               ;; Comprueba tecla D
        call cpct_isKeyPressed_asm
        jr z, d_no_pulsada

        ld a, (OffsetX)
        cp #0
        jr nz, move_the_character_D

        ld a, (CameraMinX)
        cp #40
        jr nz, move_the_map_D

        move_the_character_D:
            ld b, #2
            ld e_vx(ix), b
            ld a, (OffsetX)
            add b
            ld (OffsetX), a
        jr d_no_pulsada

        move_the_map_D:
            ld de, #1
            call inc_map
            ld b, #4
            add b
            ld (CameraMinX), a


    d_no_pulsada:
        ld hl, #Key_W
        call cpct_isKeyPressed_asm
        jr z, w_no_pulsada

            ld a, (OffsetY)
            cp #0
            jr nz, move_the_character_W

            ld a, (CameraMinY)
            cp #0
            jr nz, move_the_map_W

            move_the_character_W:
                ld b, #-4
                ld e_vy(ix), b
                ld a, (OffsetY)
                add b
                ld (OffsetY), a
            jr s_no_pulsada

            move_the_map_W:
                ld de, #-30
                call inc_map
                ld b, #-8
                add b
                ld (CameraMinY), a

        jr s_no_pulsada

    w_no_pulsada:
        ld hl, #Key_S
        call cpct_isKeyPressed_asm
        jr z, s_no_pulsada

            ld a, (OffsetY)
            cp #0
            jr nz, move_the_character_S

            ld a, (CameraMinY)
            cp #80
            jr nz, move_the_map_S

            move_the_character_S:
                ld b, #4
                ld e_vy(ix), b
                ld a, (OffsetY)
                add b
                ld (OffsetY), a
            jr s_no_pulsada

            move_the_map_S:
                ld de, #30
                call inc_map
                ld b, #8
                add b
                ld (CameraMinY), a

    s_no_pulsada:

    ld a, e_x(ix)                    ;; Consigue la posicion del jugador
    add e_vx(ix)                     ;; Le sumo la velocidad, lo hago aqui en vez del update de jugador para evitar restar en clear
    ld e_x(ix), a                    ;; Lo guardo en su registro

    ld a, e_y(ix)                    ;; Repito para Y
    add e_vy(ix)
    ld e_y(ix), a

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







