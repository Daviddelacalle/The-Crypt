.area _DATA
.area _CODE

;;====================================
;; INCLUDES
;;====================================

.include "cpctelera.h.s"

.globl _g_palette
.globl _g_0
.globl _nivel1

; 0x40

;==========================================================;
;   Disable firmware to avoid configuration override
;   Load custom palette
;==========================================================;
.macro init
    call cpct_disableFirmware_asm
    ld    c, #0
    call cpct_setVideoMode_asm

    ld hl, #_g_palette
    ld de, #16
    call cpct_setPalette_asm
.endm



;; Punto de entrada de la funcion main
_main::
    ; --> Realocate stack memory <-- ;
    ;ld sp, #0x8000

    init

    call drawMap
    call enemy_create

    ;; Comienza el bucle del juego
    loop:

        call bullet_inputs

        ;; UPDEIT
        call enemy_update_ALL
        call hero_update
        call bullet_update

        call cpct_waitVSYNC_asm

        ;; CLIAR
        call enemy_clear_ALL
        call bullet_clear
        call obs_clear
        call hero_clear

        ;; DRO
        call enemy_draw_ALL
        call bullet_draw
        call obs_draw
        call hero_draw

jr loop
