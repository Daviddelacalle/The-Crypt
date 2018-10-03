;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ENTIDAD HEROE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.area _DATA
.area _CODE

.include "cpctelera.h.s"
.include "struct.h.s"

.globl CameraMinMax

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


    call cpct_scanKeyboard_asm
    ld hl, #Key_A                   ;; Comprueba tecla A
    call cpct_isKeyPressed_asm
    jr z, a_no_pulsada
        ld a, #0
        ld b, #-1
        ;call move_camera
        ld e_vx(ix), b
        jr d_no_pulsada             ;; Si se ha pulsado no compruebes la tecla D

    a_no_pulsada:
        call cpct_scanKeyboard_asm
        ld hl, #Key_D               ;; Comprueba tecla D
        call cpct_isKeyPressed_asm
        jr z, d_no_pulsada
            ld a, #0
            ld b, #1
            ;call move_camera
            ld e_vx(ix), b

    d_no_pulsada:
        call cpct_scanKeyboard_asm
        ld hl, #Key_W
        call cpct_isKeyPressed_asm
        jr z, w_no_pulsada
            ld a, #1
            ld b, #-2
            ;call move_camera
            ld e_vy(ix), b
            jr s_no_pulsada

    w_no_pulsada:
        call cpct_scanKeyboard_asm
        ld hl, #Key_S
        call cpct_isKeyPressed_asm
        jr z, s_no_pulsada
            ld a, #1
            ld b, #2
            ;call move_camera
            ld e_vy(ix), b

    s_no_pulsada:


    ld a, e_y(ix)
    add e_vy(ix)
    ld e_y(ix), a

    ld a, e_x(ix)
    add e_vx(ix)
    ld e_x(ix), a
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







