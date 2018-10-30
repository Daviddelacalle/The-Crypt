.include "cpctelera.h.s"
.include "constants.h.s"

GameOverFragment1            = 0x610
GameOverFragment2            = 0x6D2

VictoryFragment1             = 0x6AE
VictoryFragment2             = 0x2AC

decompress_buffer == 0x1DB
buffer_end_gameOver = decompress_buffer + GameOverFragment1 - 1
buffer_end_gameOver2 = decompress_buffer + GameOverFragment2 - 1

buffer_end_Victory = decompress_buffer + VictoryFragment1 - 1
buffer_end_Victory2 = decompress_buffer + VictoryFragment2 - 1


drawGameOver::

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

drawVictory::
    call clearScreen

    ;; DRO GAMEOVER
    ld hl, #DIPwidth
    ld (hl), #15
    ld hl, #DIPheight
    ld (hl), #114

    ld hl, #_Victory1_end
    call uncompressVictory
    ld de, #0x0146          ; X12 Y41 = 0x50 * 0x4 + 0x6
    call drawImagePortion

    ld hl, #_Victory2_end
    call uncompressVictory
    ld de, #0x0155
    call drawImagePortion

    ld hl, #_Victory3_end
    call uncompressVictory
    ld de, #0x0164
    call drawImagePortion

    ld hl, #_Victory4_end
    call uncompressVictory
    ld de, #0x0173
    call drawImagePortion

    ld hl, #DIPwidth
    ld (hl), #6
    ld hl, #DIPheight
    ld (hl), #114

    ;; It has different resolution
    ld hl, #_Victory5_end
    ld de, #buffer_end_Victory2
    call cpct_zx7b_decrunch_s_asm

    ld de, #0x0182
    call drawImagePortion
ret

uncompressGameOver:
    ld de, #buffer_end_gameOver
    call cpct_zx7b_decrunch_s_asm
ret

uncompressVictory:
    ld de, #buffer_end_Victory
    call cpct_zx7b_decrunch_s_asm
ret
