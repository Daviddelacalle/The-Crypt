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

.area _DATA
.area _CODE

;;====================================
;; INCLUDES
;;====================================

.include "cpctelera.h.s"

.macro setBorder color
    ;ld hl, #0x'color'10
    ;call cpct_setPALColour_asm
.endm

;==========================================================;
;   Disable firmware to avoid configuration override
;   Load custom palette
;==========================================================;
.macro init
    call cpct_disableFirmware_asm
    ld    c, #0
    call cpct_setVideoMode_asm

    ld hl, #_g_palette
    ld de, #16
    call cpct_setPalette_asm

    ;; Clean 16K: 0x8000 -> 0xC000
    ld  hl,  #0x8000
    ld (hl), #0
    ld  de,  #0x8000 + 1
    ld  bc,  #0x4000 - 1
    ldir

.endm

unavariable: .db #5

isr:

  ex af,af';'
  exx

  push ix
  push af
  push bc
  push de
  push hl
  push iy

  ld a, (unavariable)
  dec a
  ld (unavariable), a
  jr nz, return

  call z, cpct_akp_musicPlay_asm
  ld a, #5
  ld (unavariable), a

  return:
    ; ld a, #_cpct_akp_songLoopTimes
    ; cp #1
    ; jr nz, noparar
    ; call cpct_akp_stop_asm
    ; noparar:
    pop iy
    pop hl
    pop de
    pop bc
    pop af
    pop ix

    exx
    ex af,af';'

ret


;; Punto de entrada de la funcion main
_main::
    ; --> Realocate stack memory <-- ;
    ld sp, #0x8000

    init
    ld hl, #isr
    call cpct_setInterruptHandler_asm

    ld de, #_sfx
    call cpct_akp_SFXInit_asm

    menu::
    ld de, #_song_ingame
    call cpct_akp_musicInit_asm
    ld hl, #SEED    ;; SEED
    call loadMenu

    map_start::

        call recalculateCameraOffset
        call drawHud
        call dw_drawHearts
        ;; Switch buffers and draw the same
        call swapBuffers
        call drawHud
        call dw_drawHearts
        ;; Back to the original buffer
        call swapBuffers

        call resetTilemap

        call loadLevel1       ;; Loads level 1

    ;; GAME LOOP
    loop::

        ;; DRO
        call drawMap
        call enemy_draw_ALL
        call bullet_draw
        call hero_draw

        ;; UPDEIT
        call enemy_update_ALL
        call hero_update
        call bullet_inputs
        call bullet_update

        call cpct_waitVSYNC_asm
        call swapBuffers
jr loop
