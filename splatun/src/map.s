.area _DATA
.area _CODE

.include "struct.h.s"

map_ptr:    .dw #_nivel1
                ;   X    Y     W     H       VX     VY    COL
DefineEntity _obs, #10, #40, #0x04, #0x08, #0x00, #0x00, #0xFF, #0x0000


;Disrupción alienígeca
obs_draw::
    ld ix, #_obs
    jp dw_draw

obs_clear::
    ld ix, #_obs
    jp dw_clear

;========================================================================;
;   Inreases ptr to map
;========================================================================;
inc_map_y::

    ld hl, (map_ptr)

    cp #1
    jr nz, up
        ld de, #60
        jr continue
    up:
    ld de, #-60

    continue:
        add hl, de
    ld (map_ptr), hl
    call drawMap
ret

;========================================================================;
;   Draws the complete map.in.include "drawable.h.s"clude "drawable.h.s"
;========================================================================;
drawMap::
    ld hl, #_g_0
    ld c, #20       ;40
    ld b, #25      ;100
    ld de, #30
    call cpct_etm_setDrawTilemap4x8_ag_asm

    ld hl, #0xC000
    ld de, (map_ptr)
    call cpct_etm_drawTilemap4x8_ag_asm
ret

