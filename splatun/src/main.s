.area _DATA
.area _CODE

;;====================================
;; INCLUDES
;;====================================

;; ================================================================================================ ;;
;; HAY QUE CAMBIAR LAS OPCIONES DE COMPILADO, PARA LOS .globl, Y EL INICIO DEL PROGRAMA A LA 0x0040 ;;
;; ================================================================================================ ;;

.include "cpctelera.h.s"
.include "cpcglbl.h.s"
.include "hero.h.s"
.include "bullet.h.s"
.include "map.h.s"

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

;==========================================================;
;   Draws the complete map
;==========================================================;
drawMap:
    ld hl, #_g_0
    ld c, #20       ;40
    ld b, #25      ;100
    ld de, #30
    call cpct_etm_setDrawTilemap4x8_ag_asm

    ld hl, #0xC000
    ld de, #_nivel1
    call cpct_etm_drawTilemap4x8_ag_asm
ret


;; Punto de entrada de la funcion main
_main::
    ; --> Realocate stack memory <-- ;
    ;ld sp, #0x8000

    init
    ;;call drawMap
    call enemy_create

    ;; Comienza el bucle del juego
    loop:
        call bullet_inputs

        ;; CLIAR
        call enemy_clear_ALL
        call bullet_clear
        call obs_clear
        call hero_clear

        ;; UPDEIT
        call enemy_update_ALL
        call hero_update
        call bullet_update

        ;; DRO
        call enemy_draw_ALL
        call hero_draw
        call bullet_draw
        call obs_draw

        call cpct_waitVSYNC_asm
jr loop
