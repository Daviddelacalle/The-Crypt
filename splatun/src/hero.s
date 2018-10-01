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
DefineEntity hero, #40, #110, 0x02, 0x08, 0x00, 0x00, 0x0F, 0x0000

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
    ld    de,   #0xC000     ;; Apunta al inicio de la memoria de video
    ld     c,   #40      ;; x  [0-79]
    ld     b,   #100      ;; y  [0-199]
    call cpct_getScreenPtr_asm

    ;; SIN SPRITE
    ex    de,   hl          ;; Apunta a la posicion x,y
    ld     a,   e_col(ix)    ;; Código de color
    ld     c,   e_w(ix)      ;; Ancho
    ld     b,   e_h(ix)      ;; Alto
    call cpct_drawSolidBox_asm
ret

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
;;======================================================================
;;======================================================================
;; FUNCIONES PRIVADAS
;;======================================================================
;;======================================================================







