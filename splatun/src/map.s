.area _DATA
.area _CODE

.include "struct.h.s"

CameraMinMax::
    .db #0, #0 ;Min X, Min Y

                ;   X    Y     W     H       VX     VY    COL
DefineEntity _obs, #10, #40, #0x04, #0x08, #0x00, #0x00, #0xFF, #0x0000


;Disrupción alienígeca
obs_draw::
    ld ix, #_obs
    jp dw_draw

obs_clear::
    ld ix, #_obs
    jp dw_clear


;===========================================
;   Move the camera
;   Input: A = Axix (X=0, Y=1), B = Velocity
;===========================================
move_camera::
    ld hl, #CameraMinMax
    cp #0
    jr z, not_y
        inc hl
    not_y:
    ld a, (hl)
    add a, b
    ld (hl), a
ret

;==========================================================;
;   Draws the complete map.in.include "drawable.h.s"clude "drawable.h.s"
;==========================================================;
drawMap::
    ld hl, #_g_0
    ld c, #20       ;40
    ld b, #25      ;100
    ld de, #30
    call cpct_etm_setDrawTilemap4x8_ag_asm

    ld hl, #0xC000
    ld de, #_nivel1
    call cpct_etm_drawTilemap4x8_ag_asm
ret

