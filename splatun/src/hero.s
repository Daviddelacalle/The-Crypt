;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ENTIDAD HEROE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.area _DATA
.area _CODE

.include "cpctelera.h.s"
.include "cpcglbl.h.s"
.include "struct.h.s"
.include "drawable.h.s"

.globl CameraMinMax

;;======================================================================
;;======================================================================
;; DATOS PRIVADOS
;;======================================================================
;;======================================================================

hero_x = .
hero_y = . + 1
DefineEntity hero, #40, #100, 0x02, 0x08, 0x00, 0x00, 0x0F, 0x0000

;;======================================================================
;;======================================================================
;; FUNCIONES PUBLICAS
;;======================================================================
;;======================================================================

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DIBUJADO DE LA ENTIDAD HERO
;;;;;;;;;;;;;;;;;;;;;;;;;;;
hero_draw::
    ld    ix,   #hero    ;; ix apunta a los datos del heroe
    jp dw_draw_movable


hero_clear::
    ld ix, #hero
    jp dw_clear

hero_update::
    ld e_vx(ix), #0
    ld e_vy(ix), #0

    call cpct_scanKeyboard_asm
    ld hl, #Key_A
    call cpct_isKeyPressed_asm
    jp z, a_no_pulsada
        ld a, (CameraMinMax)
        dec a
        ld (CameraMinMax), a


    a_no_pulsada:
        call cpct_scanKeyboard_asm
        ld hl, #Key_D
        call cpct_isKeyPressed_asm
        jp z, d_no_pulsada
            ld a, (CameraMinMax)
            inc a
            ld (CameraMinMax), a

    d_no_pulsada:
        call cpct_scanKeyboard_asm
        ld hl, #Key_W
        call cpct_isKeyPressed_asm
        jp z, w_no_pulsada
            ld a, (CameraMinMax+1)
            ld b, #2
            sub b
            ld (CameraMinMax+1), a

    w_no_pulsada:
        call cpct_scanKeyboard_asm
        ld hl, #Key_S
        call cpct_isKeyPressed_asm
        jp z, s_no_pulsada
            ld a, (CameraMinMax+1)
            ld b, #2
            add b
            ld (CameraMinMax+1), a

    s_no_pulsada:


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







