.area _DATA
.area _CODE

.include "struct.h.s"

cam_min::       .db #0, #0
cam_max::       .db #16, #16
CoordMapMin::   .db #0, #0

CameraTargetX:: .db #0
CameraTargetY:: .db #0

map_ptr:    .dw #_nivel1

;========================================================================;
;   Inreases ptr for the map
;   Input:  DE => Incremento del mapa
;            B => Incremento de CameraMinX/Y
;            C => Incremento de CameraMinX/Y en coordenadas de mapa
;           HL => Puntero a CameraMinX/Y
;========================================================================;
inc_map::
    ld a, (hl)
    add b
    ld (hl), a              ;; Incremento el min de la camara
    inc hl
    inc hl
    ld a, (hl)
    add b
    ld (hl), a              ;; Incremento el min de la camara

    inc hl
    inc hl
    ld a, (hl)
    add c
    ld (hl), a

    ld hl, (map_ptr)        ;; Cambio el puntero del mapa
    add hl, de              ;; sumándole lo que le hay pasado en DE
    ld (map_ptr), hl

ret

setTargetX::
    ld a, (#CameraTargetX)
    add b
    ld (#CameraTargetX), a
ret

setTargetY::
    ld a, (#CameraTargetY)
    add b
    ld (#CameraTargetY), a
ret


update_cam::
    ld a, (#CameraTargetX)
    cp #0
    jr z, noTargetX
        ;; Tenemos target en X
        cp #0xF0
        ld a, (cam_min)
        jr c, is_positive_x
            ;; Negativo
            ;; Comprueba que no se salga del mapa
                cp #0
                jr nz, not_on_limit_left
                ld b, #0            ;; Se sale del mapa! Pon el target a 0
                call setTargetX
                jr noTargetX
            not_on_limit_left:
            ld b, #-1
            ld c, #-4
            ld de, #-1
            ld a, (CameraTargetX)
            inc a
            ld (CameraTargetX), a
            jr update_x
        is_positive_x:
            ;; Positivo
            ;; Comprueba que no se salga del mapa
                cp #LimitRight
                jr nz, not_on_limit_right
                ld b, #0            ;; Se sale del mapa! Pon el target a 0
                call setTargetX
                jr noTargetX

            not_on_limit_right:
            ld b, #1
            ld c, #4
            ld de, #1
            ld a, (CameraTargetX)
            dec a
            ld (CameraTargetX), a
        update_x:
        ld hl, #cam_min
        call inc_map

    noTargetX:
    ld a, (CameraTargetY)
    cp #0
    ret z
        ;; Tenemos target en Y
        ;; Comprueba que no se salga del mapa
        cp #0xF0
        ld a, (cam_min+1)
        jr c, is_positive_y
            ;; Negativo
            ;; Comprueba que no se salga del mapa
                cp #0
                jr nz, not_on_limit_up
                ld b, #0            ;; Se sale del mapa! Pon el target a 0
                call setTargetY
                ret
            not_on_limit_up:
            ld b, #-1
            ld c, #-8
            ld de, #-30
            ld a, (CameraTargetY)
            inc a
            ld (CameraTargetY), a
            jr update_y
        is_positive_y:
            ;; Positivo
            ;; Comprueba que no se salga del mapa
                cp #LimitDown
                jr nz, not_on_limit_down
                ld b, #0            ;; Se sale del mapa! Pon el target a 0
                call setTargetY
                ret

            not_on_limit_down:
            ld de, #30
            ld b, #1
            ld c, #8
            ld a, (CameraTargetY)
            dec a
            ld (CameraTargetY), a
        update_y:
        ld hl, #cam_min+1
        call inc_map


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
