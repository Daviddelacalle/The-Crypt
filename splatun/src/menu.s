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

decompress_buffer       == 0x176
imageMaxSize             = 0x71C
buffer_end_menu = decompress_buffer + imageMaxSize - 1

setMenuPalette:

ret

loadMenu::

    ld hl, #_Menu_1_end
    call uncompress
    ld de, #0x10A0
    call drawMenu

    ld hl, #_Menu_2_end
    call uncompress
    ld de, #0x10B4
    call drawMenu

    ld hl, #_Menu_3_end
    call uncompress
    ld de, #0x10C8
    call drawMenu

    ld hl, #_Menu_4_end
    call uncompress
    ld de, #0x10DC
    call drawMenu
    ;==========
    ld hl, #_Menu_5_end
    call uncompress
    ld de, #0x2C10
    call drawMenu

    ld hl, #_Menu_6_end
    call uncompress
    ld de, #0x2C24
    call drawMenu

    ld hl, #_Menu_7_end
    call uncompress
    ld de, #0x2C38
    call drawMenu

    ld hl, #_Menu_8_end
    call uncompress
    ld de, #0x2C4C
    call drawMenu
    call swapBuffers
ret

;; 0x50 + 0x50 + 0x800 + 0x800 = 0x10A0
;; 0x50 * 0xD + 0x800 * 0x5 = 2C10

drawMenu:
    ld a, (back_buffer)
    ld h, a
    ld l, #0x00
    add hl, de
    ex de, hl
    ld c, #20
    ld b, #91
    ld hl,#decompress_buffer
    call cpct_drawSprite_asm  ;; Inicio del buffer de descompresión ¬
ret

load_control::
  call cpct_scanKeyboard_asm     ;; scanear el teclado para ver si hay alguna tecla pulsada
  ld 		hl, #Key_A 			 ;; Cargamos en el registro HL la tecla que quermos comprobar
  call cpct_isKeyPressed_asm
  jp nz, map_start
ret


uncompress:
    ld de, #buffer_end_menu
    call cpct_zx7b_decrunch_s_asm
ret
