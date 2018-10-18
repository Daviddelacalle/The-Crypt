.area _DATA
.area _CODE

.include "struct.h.s"

cam_min::       .db #0, #0
cam_max::       .db #16, #16
CoordMapMin::   .db #0, #0

CameraTargetX:: .db #0
CameraTargetY:: .db #0

map_ptr:    .dw #decompress_buffer

;========================================================================;
;   Inreases ptr for the map
;   Input:  DE => Incremento del mapa
;            B => Incremento de cam_min/max
;            C => Incremento de CameraMinX/Y en coordenadas de mapa
;           HL => Puntero a CameraMinX/Y
;========================================================================;
inc_map::
    ld a, (hl)              ;; Cargo en a cam_min o cam_max,
                            ;; depende de lo que me hayan pasado
    add b                   ;; Le añado B, que será 1 o -1
    ld (hl), a              ;; Lo guardo
    inc hl
    inc hl                  ;; Aumento 2 veces el puntero para llegar al max
    ld a, (hl)              ;; Hago lo mismo
    add b
    ld (hl), a              ;; Incremento el min de la camara

    inc hl                  ;; Vuelvo a aumentar 2 para llegar al
    inc hl                  ;; minimo en coordenadas de mapa, no de tile
    ld a, (hl)              ;; A = CoordManMin
    add c                   ;; A += C, donde C será 4 o -4 en X, 8 o -8 en Y
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

;========================================================================;
;   Comprueba si la cámara debe hacer scroll y cambia las variables
;   de mínimos y máximos automáticamente
;   Destroys: A, BC, DE, HL
;========================================================================;
update_cam::
    ld a, (#CameraTargetX)
    cp #0                   ;; Hay algún target para la cámara?
    jr z, noTargetX
        ;; Tenemos target en X
        cp #0xF0            ;; Compruebo si el target es negativo
        ld a, (cam_min)     ;; Cargo el camera min ahora, porque
                            ;; lo voy a tener que cargar igualmente
                            ;; tanto si es positivo como negativo
        jr c, is_positive_x
            ;; Negativo
            ;; Comprueba que no se salga del mapa
                cp #0
                jr nz, not_on_limit_left
                ld b, #0            ;; Se sale del mapa! Pon el target a 0
                call setTargetX
                jr noTargetX        ;; Y no hagas nada más, ve a comprobar Y
            not_on_limit_left:
            ;; No nos salimos del mapa al aumentar! ʕ ͡° ͜ʖ ͡°ʔ
            ld b, #-1               ;;  B aumentará cam_min/max
            ld c, #-4               ;;  C aumentará CoordMapMin
            ld de, #-1              ;; DE aumentará el puntero del mapa
            ld a, (CameraTargetX)   ;; Como estamos en target negativo
            inc a                   ;; Le sumo uno para ir llevándolo a 0
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
            ;; Mismo de antes pero en positivo
            ld b, #1
            ld c, #4
            ld de, #1
            ld a, (CameraTargetX)
            dec a           ;; Ahora es positivo, resto para llevarlo a 0
            ld (CameraTargetX), a
        update_x:
        ld hl, #cam_min     ;; Cargo en hl cam_min, que es la que tiene la X
        call inc_map

    ;; Repetimos el mismo proceso para Y
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
        ld hl, #cam_min+1   ;; Ahora le paso la Y
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
