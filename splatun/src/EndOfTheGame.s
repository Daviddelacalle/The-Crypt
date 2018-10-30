;##-----------------------------LICENSE NOTICE------------------------------------
;##  This file is part of THE CRYPT
;##
;##  This game is free software: you can redistribute it and/or modify
;##  it under the terms of the GNU Lesser General Public License as published by
;##  the Free Software Foundation, either version 3 of the License, or
;##  (at your option) any later version.
;##
;##  This game is distributed in the hope that it will be useful,
;##  but WITHOUT ANY WARRANTY; without even the implied warranty of
;##  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;##  GNU Lesser General Public License for more details.
;##
;##  You should have received a copy of the GNU Lesser General Public License
;##  along with this program.  If not, see <http://www.gnu.org/licenses/>.
;##------------------------------------------------------------------------------

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
