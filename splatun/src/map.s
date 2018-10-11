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
;   Input: DE = Incremento
;========================================================================;
inc_map::
    ld hl, (map_ptr)
    add hl, de
    ld (map_ptr), hl
ret

;========================================================================;
;   Draws the complete map.in.include "drawable.h.s"clude "drawable.h.s"
;========================================================================;
drawMap::

    ld a, (back_buffer)                  ;; Apunta al inicio de la memoria de video
    ld h, a
    ld l, #0
    ld de, (map_ptr)
    call cpct_etm_drawTilemap4x8_ag_asm
ret

