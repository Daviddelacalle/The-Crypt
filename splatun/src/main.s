.area _DATA
.area _CODE

;;====================================
;; INCLUDES
;;====================================

.include "cpctelera.h.s"
.include "cpcglbl.h.s"
.include "hero.h.s"
.include "bullet.h.s"

.globl _g_palette
.globl _tileset
.globl _nivel1

;==========================================================;
;   Disable firmware to avoid configuration override
;   Load custom palette
;==========================================================;
init:
    call cpct_disableFirmware_asm
    ld    c, #0
    call cpct_setVideoMode_asm

    ld hl, #_g_palette
    ld de, #16
    call cpct_setPalette_asm
ret

;==========================================================;
;   Draws the complete map
;==========================================================;
drawMap:
    ld hl, #_tileset
    call cpct_etm_setTileset2x4_asm

    ld hl, #_nivel1
    push hl
    ld hl, #0xC000
    push hl
    ld bc, #0000
    ld de, #0x3228
    ld a, #45
    call cpct_etm_drawTileBox2x4_asm
ret


;; Punto de entrada de la funcion main
_main::
    ; --> Realocate stack memory <-- ;
    ;ld sp, #0x8000

    call init
    call drawMap

    ;; Comienza el bucle del juego
    loop:
       ;;call hero_check_inputs
       call cpct_scanKeyboard_asm
       ld hl, #Key_Space
       call cpct_isKeyPressed_asm
       call nz, #bullet_init

       call hero_draw
       call bullet_draw

       call cpct_waitVSYNC_asm
jr loop
