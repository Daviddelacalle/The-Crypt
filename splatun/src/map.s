.area _DATA
.area _CODE

.include "struct.h.s"

cam_min::       .db #0, #0
CoordMapMin::   .db #0, #0

CameraTargetX:: .db #0
CameraTargetY:: .db #0

map_ptr:    .dw #decompress_buffer

decompress_buffer == 0x1DB
HUD_END_DECOMPRESSED = 499 + decompress_buffer
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
    inc hl                  ;; Aumento 2 veces el puntero para llegar al
    inc hl                  ;; minimo en coordenadas de mapa, no de tile
    ld a, (hl)              ;; A = CoordManMin
    add c                   ;; A += C, donde C será 4 o -4 en X, 8 o -8 en Y
    ld (hl), a

    ld hl, (map_ptr)        ;; Cambio el puntero del mapa
    add hl, de              ;; sumándole lo que le hay pasado en DE
    ld (map_ptr), hl

ret

;;============================================
;;  Calculate camera offset from hero position
;;  DESTROYS:   A, BC, HL, DE
;;============================================
recalculateCameraOffset::
    ld hl, #decompress_buffer
    ld de, #30

    ld a, e_x(ix)
    sub #32
    jr c, setCamMinXToZero
    jr z, setCamMinXToZero
    ld b, a
    ld a, #0        ;; CoordMapMin
    ld c, #0        ;; cam_min
    X_iterator:
        inc c
        add #4
        inc hl
        cp b
    jr c, X_iterator
        ld (CoordMapMin), a
        ld a, c
        ld (cam_min), a
    jr calculate_y
    setCamMinXToZero:
        ld a, #0
        ld (CoordMapMin), a
        ld (cam_min), a

    calculate_y:
    ld a, e_y(ix)
    sub #64
    jr c, setCamMinYToZero
    jr z, setCamMinYToZero
    ld b, a
    ld a, #0        ;; CoordMapMin
    ld c, #0        ;; cam_min
    Y_iterator:
        inc c
        add #8
        add hl, de
        cp b
    jr c, Y_iterator
        ld (CoordMapMin+1), a
        ld a, c
        ld (cam_min+1), a
    jr finish
    setCamMinYToZero:
        ld a, #0
        ld (CoordMapMin+1), a
        ld (cam_min+1), a
    finish:
    ld (map_ptr), hl

    ld a, #0
    ld (CameraTargetX), a
    ld (CameraTargetY), a
ret

;;  ENTRADA:    B -> Incremento molon de camara
setTargetX::
    ld a, (#CameraTargetX)
    add b
    ld (#CameraTargetX), a
ret

;;  ENTRADA:    B -> Incremento molon de camara
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
            ld b, #-1      ;;AAAAAAAAAAAAAAAAAAAAAAAAAAA
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
            ld b, #1       ;;AAAAAAAAAAAAAAAAAAAAAAAAAAA
            ld c, #8
            ld a, (CameraTargetY)
            dec a
            ld (CameraTargetY), a
        update_y:
        ld hl, #cam_min+1   ;; Ahora le paso la Y
        call inc_map
ret

openTeleporter::

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

;; DIBUJADO DEL HUD
drawHud::
    ld hl, #_g_00
    ld c, #20        ;; Ancho en tiles -> 20*8 = 160
    ld b, #25        ;; Alto en tiles  -> 25*8 = 200
    ld de, #20
    call cpct_etm_setDrawTilemap4x8_ag_asm

    ;; DECRUNCH
    ld de, #HUD_END_DECOMPRESSED
    ld hl, #_hud_end
    call cpct_zx7b_decrunch_s_asm

    ld a, (back_buffer)
    ld h, a
    ld l, #0
    ld de, #decompress_buffer
    call cpct_etm_drawTilemap4x8_ag_asm
ret
