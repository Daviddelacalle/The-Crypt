.area _DATA
.area _CODE

.include "struct.h.s"

CameraMinX::  .db #8
CameraMinY::  .db #32

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
;   Inreases ptr for the map
;   Input:  DE => Incremento
;            B => Incremento de CameraMinX/Y
;           HL => Puntero a CameraMinX/Y
;========================================================================;
inc_map::
    add b
    ld (hl), a              ;; Incremento el min de la camara

    ld hl, (map_ptr)        ;; Cambio el puntero del mapa
    add hl, de              ;; sumándole lo que le hay pasado en DE
    ld (map_ptr), hl

    call update_cam
ret

;========================================================================;
;   Draws the complete map.in.include "drawable.h.s"clude "drawable.h.s"
;========================================================================;
drawMap::
    ld a, (back_buffer)                  ;; Apunta al inicio de la memoria de video
    inc a
    ld h, a
    ld l, #0x48
    ld de, (map_ptr)
    call cpct_etm_drawTilemap4x8_ag_asm
ret
