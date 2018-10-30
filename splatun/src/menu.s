;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; MODELO PARA CADA ARCHIVO .s QUE SE CREE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; TODO:
;;    - Copiado de entidades?

.area _DATA
.area _CODE

.include "cpctelera.h.s"
.include "struct.h.s"

;menu_ptr:    .dw #_g_tile_tileset

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; BUCLE PARA EL MENU
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

decompress_buffer == 0x022E
imageMaxSize             = 0x71C
buffer_end_menu = decompress_buffer + imageMaxSize - 1


loadMenu::

    call clearScreen
    call drawImage
    call swapBuffers
    call drawImage
    ld de, #0x23D9          ; X12 Y41 = (0x50 * 0xC + 0x800*0x4)(Y) + 0x19(X)
    call drawPressAnyKey
    call swapBuffers
    call menuInput
ret

menuInput:
    swap:
        ld d, #6
        WaitB:
            ld e, #0xFF
            Timeout:
                push de
                    call cpct_nextRandom_mxor_u8_asm
                    push hl
                        call cpct_scanKeyboard_asm
                        call cpct_isAnyKeyPressed_asm
                    pop hl
                pop de
                ret nz
                dec e
            jr nz, Timeout
            dec d
        jr nz, WaitB
        ld d, #2
        push hl
            push de
                call swapBuffers
            pop de
        pop hl
    jr swap
ret

drawImage:
    ld hl, #DIPwidth
    ld (hl), #20
    ld hl, #DIPheight
    ld (hl), #91

    ld hl, #_Menu_1_end
    call uncompressMenu
    ld de, #0x10A0
    call drawImagePortion

    ld hl, #_Menu_2_end
    call uncompressMenu
    ld de, #0x10B4
    call drawImagePortion

    ld hl, #_Menu_3_end
    call uncompressMenu
    ld de, #0x10C8
    call drawImagePortion

    ld hl, #_Menu_4_end
    call uncompressMenu
    ld de, #0x10DC
    call drawImagePortion
    ;==========
    ld hl, #_Menu_5_end
    call uncompressMenu
    ld de, #0x2C10
    call drawImagePortion

    ld hl, #_Menu_6_end
    call uncompressMenu
    ld de, #0x2C24
    call drawImagePortion

    ld hl, #_Menu_7_end
    call uncompressMenu
    ld de, #0x2C38
    call drawImagePortion

    ld hl, #_Menu_8_end
    call uncompressMenu
    ld de, #0x2C4C
    call drawImagePortion
ret
;; 0x50 + 0x50 + 0x800 + 0x800 = 0x10A0
;; 0x50 * 0xD + 0x800 * 0x5 = 2C10

uncompressMenu:
    ld de, #buffer_end_menu
    call cpct_zx7b_decrunch_s_asm
ret

clearScreen::

    call fillAlternativeBuffer
    ld hl, #_g_00
    ld de, #30
    ld b, #25
    ld c, #20
    call cpct_etm_setDrawTilemap4x8_ag_asm

    ld de, #alternative_buffer
    ld a, (back_buffer)
    ld h, a
    ld l, #0x00

    call cpct_etm_drawTilemap4x8_ag_asm

ret
