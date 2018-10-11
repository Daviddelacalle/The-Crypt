.area _DATA
.area _CODE

;;====================================
;; INCLUDES
;;====================================

.include "cpctelera.h.s"

.macro setBorder color
    ;ld hl, #0x'color'10
    ;call cpct_setPALColour_asm
.endm

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

    ;; Clean 16K: 0x8000 -> 0xC000
    ld  hl,  #0x8000
    ld (hl), #0
    ld  de,  #0x8000 + 1
    ld  bc,  #0x4000 - 1
    ldir

    call hero_init
    
    ld hl, #_g_000
    ld c, #20
    ld b, #25
    ld de, #29
    call cpct_etm_setDrawTilemap4x8_ag_asm
.endm

;1 2 3 4 5
;6 7 8 9 9

;; Punto de entrada de la funcion main
_main::
    ; --> Realocate stack memory <-- ;
    ld sp, #0x8000

    init

    call drawMap
    ;call enemy_create

    ;; Comienza el bucle del juego
    loop:

        ;; CLIAR
        ;call bullet_clear
        ;call obs_clear
        call hero_clear


        ;; DRO
        call drawMap
        ;call bullet_inputs
        ;call bullet_draw
        ;call obs_draw
        call hero_draw

        ;; UPDEIT
        call enemy_update_ALL
        call hero_update
        call bullet_update

        call cpct_waitVSYNC_asm
<<<<<<< HEAD
        call swapBuffers

=======

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
>>>>>>> 2acca47970c5e61d6eef8e18d4dc69a41bf01afa

jr loop
