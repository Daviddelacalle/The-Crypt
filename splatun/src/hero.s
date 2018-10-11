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
DefineEntity hero, #40, #50, 0x02, 0x08, 0x00, 0x00, 0x0F, 0x0000

;;======================================================================
;;======================================================================
;; FUNCIONES PUBLICAS
;;======================================================================
;;======================================================================


hero_init::
    ld ix, #hero
    ld a, e_x(ix)
    ld pe_x(ix), a
    ld ppe_x(ix), a
    ld a, e_y(ix)
    ld pe_y(ix), a
    ld ppe_y(ix), a
ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DIBUJADO DE LA ENTIDAD HERO
;;;;;;;;;;;;;;;;;;;;;;;;;;;
hero_draw::
    ld    ix,   #hero    ;; ix apunta a los datos del heroe
    jp dw_draw


hero_clear::
    ld ix, #hero
    jp dw_clear

hero_update::
    ld    ix,   #hero   ; Se puede borrar si hero es el ultimo en hacer dro
    ld e_vx(ix), #0
    ld e_vy(ix), #0

    ld a, e_x(ix)
    ld pe_x(ix), a
    ld a, e_y(ix)
    ld pe_y(ix), a

    call cpct_scanKeyboard_asm

    ld hl, #Key_A                   ;; Comprueba tecla A
    call cpct_isKeyPressed_asm
    jr z, a_no_pulsada
        ;ld b, #-1
        ;ld e_vx(ix), b
        ld de, #-1
        call inc_map
        jr d_no_pulsada             ;; Si se ha pulsado no compruebes la tecla D

    a_no_pulsada:
<<<<<<< HEAD
=======

>>>>>>> 2acca47970c5e61d6eef8e18d4dc69a41bf01afa
        ld hl, #Key_D               ;; Comprueba tecla D
        call cpct_isKeyPressed_asm
        jr z, d_no_pulsada
            ;ld b, #1
            ;ld e_vx(ix), b
            ld de, #1
            call inc_map

    d_no_pulsada:
<<<<<<< HEAD
=======

>>>>>>> 2acca47970c5e61d6eef8e18d4dc69a41bf01afa
        ld hl, #Key_W
        call cpct_isKeyPressed_asm
        jr z, w_no_pulsada
            ;ld b, #-2
            ;ld e_vy(ix), b
            ld de, #-29
            call inc_map
            jr s_no_pulsada

    w_no_pulsada:
<<<<<<< HEAD
=======

>>>>>>> 2acca47970c5e61d6eef8e18d4dc69a41bf01afa
        ld hl, #Key_S
        call cpct_isKeyPressed_asm
        jr z, s_no_pulsada
            ;ld b, #2
            ;ld e_vy(ix), b
            ld de, #29
            call inc_map

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







