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

INIT_X == #40
INIT_Y == #60

VIEWPORT_WIDTH == 16
VIEWPORT_HEIGHT == 16
ScreenSizeX = 16*4
ScreenSizeY = 16*8
;X = Width * 4 / 4 <~ Múltiplo de 4
;Y = Height * 8 / 4 <~ Múltiplo de 6

LEFT    == 8+12
RIGHT   == 8+ScreenSizeX-12
TOP     == 30+30
BOTTOM  == 126

MAP_WIDTH == 30
MAP_HEIGHT == 30

;decompress_buffer       == 0x040
;levelMaxSize            = 0x384
;decompress_buffer_end   = decompress_buffer + levelMaxSize - 1
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

    ld hl, #_g_00
    ld c, #VIEWPORT_WIDTH        ;; Ancho
    ld b, #VIEWPORT_HEIGHT        ;; Alto
    ld de, #30
    call cpct_etm_setDrawTilemap4x8_ag_asm
.endm

;1 2 3 4 5
;6 7 8 9 9

;; Punto de entrada de la funcion main
_main::
    ; --> Realocate stack memory <-- ;
    ld sp, #0x8000

    init
    call drawMenu

    ;ld hl, #_level0_pack_end
    ;ld de, #decompress_buffer_end
    ;call cpct_zx7b_decrunch_s_asm

    loop_load::

      call load_control
      jr loop_load
      map_start::
      call drawMap

    ;; Comienza el bucle del juego
    loop::

        ;; CLIAR
        ;call bullet_clear
        ;call obs_clear
        ;call enemy_clear_ALL
        ;call hero_clear

        ;; DRO
        call bullet_inputs
        call drawMap
        call bullet_draw
        call enemy_draw_ALL
        call hero_draw

        ;; UPDEIT
        call enemy_update_ALL
        call hero_update
        call bullet_update

        call cpct_waitVSYNC_asm
        call swapBuffers
jr loop
