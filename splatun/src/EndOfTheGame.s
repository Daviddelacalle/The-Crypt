.include "cpctelera.h.s"
.include "constants.h.s"

imageMaxSize             = 0x610
imageMaxSize2            = 0x6D2
PRESSANYSize            == 0xB4

decompress_buffer == 0x022E
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
    call drawMessageSwapAndWaitInput
    ;;
ret

loadVictory::
    ;; Reinicio las vidas del jugador
    ld a, #K_HERO_LIVES
    ld (HERO_LIVES), a

    ld de, #_win
    call cpct_akp_musicInit_asm
    
    call drawVictory
    call swapBuffers
    call drawVictory
    call drawMessageSwapAndWaitInput

ret

drawMessageSwapAndWaitInput:
    ld de, #0x06A7          ; X12 Y41 = 0x50 * 0x15 + 0x17
    call drawPressAnyKey
    ld d, #8
    call setTimeOut
    call swapBuffers

    ld de, #menu
    call waitInput
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

    pop de
    call drawImagePortion
ret


uncompressGameOver:
    ld de, #buffer_end_gameOver
    call cpct_zx7b_decrunch_s_asm
ret
