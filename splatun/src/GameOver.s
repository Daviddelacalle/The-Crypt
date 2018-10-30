.include "cpctelera.h.s"
.include "constants.h.s"

imageMaxSize             = 0x610
imageMaxSize2            = 0x6D2
PRESSANYSize            == 0xB4

decompress_buffer == 0x1DB
buffer_end_gameOver = decompress_buffer + imageMaxSize - 1
buffer_end_gameOver2 = decompress_buffer + imageMaxSize2 - 1
buffer_end_PRESSANY = decompress_buffer + PRESSANYSize - 1

loadGameOver::
    ;; Reinicio las vidas del jugador
    ld a, #K_HERO_LIVES
    ld (HERO_LIVES), a

    ld de, #_GameOver
    call cpct_akp_musicInit_asm

    call drawGameOver
    call swapBuffers

    call drawGameOver
    ld de, #0x06F7          ; X12 Y41 = 0x50 * 0x16 + 0x17
    call drawPressAnyKey
    ld d, #8
    call setTimeOut
    call swapBuffers

    ld de, #menu
    call waitInput
    ;;
ret

drawGameOver:

    call clearScreen

    ;; DRO GAMEOVER
    ld hl, #DIPwidth
    ld (hl), #16
    ld hl, #DIPheight
    ld (hl), #97

    ld hl, #_GameOver1_end
    call uncompressGameOver
    ld de, #0x0196          ; X12 Y41 = 0x50 * 0x5 + 0x6
    call drawImagePortion

    ld hl, #_GameOver2_end
    call uncompressGameOver
    ld de, #0x01A6
    call drawImagePortion

    ld hl, #_GameOver3_end
    call uncompressGameOver
    ld de, #0x01B6
    call drawImagePortion

    ld hl, #DIPwidth
    ld (hl), #18
    ld hl, #DIPheight
    ld (hl), #97

    ;; It has different resolution
    ld hl, #_GameOver4_end
    ld de, #buffer_end_gameOver2
    call cpct_zx7b_decrunch_s_asm

    ld de, #0x01C6
    call drawImagePortion
ret

drawPressAnyKey::
    push de
    ;; PRESS ANY KEY message
    ld hl, #_PRESSANY_end
    ld de, #buffer_end_PRESSANY
    call cpct_zx7b_decrunch_s_asm

    ;; 60x6 pixels
    ld hl, #DIPwidth
    ld (hl), #30
    ld hl, #DIPheight
    ld (hl), #6
    call swapBuffers

    pop de
    call drawImagePortion
ret


uncompressGameOver:
    ld de, #buffer_end_gameOver
    call cpct_zx7b_decrunch_s_asm
ret

drawVictory::
    ;; Reinicio las vidas del jugador
    ld a, #K_HERO_LIVES
    ld (HERO_LIVES), a

    ld de, #_GameOver
    call cpct_akp_musicInit_asm

    call fillAlternativeBuffer      ;; Lleno con #29 un "buffer" alternativo

    ld hl, #alternative_buffer      ;; Le digo a la funcion que pinta por columnas
    ld (map), hl                    ;; dónde está mi "mapa" lleno de #29
    call clearPlayableAreaAlt

ret