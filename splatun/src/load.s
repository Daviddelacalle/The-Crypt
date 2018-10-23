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


load_control::
  call cpct_scanKeyboard_asm   ;;scanear el teclado para ver si hay alguna tecla pulsada
  ld 		hl, #Key_A 			 ;; Cargamos en el registro HL la tecla que quermos comprobar
  call cpct_isKeyPressed_asm
  jp nz, map_start


      ;;ld hl, #_m_000
      ;;ld c, #20       ;40
      ;;ld b, #25      ;100
      ;;ld de, #22
      ;;call cpct_etm_setDrawTilemap4x8_ag_asm

      ;;ld hl, #0xC000
      ;;ld de, (menu_ptr)
      ;;call cpct_etm_drawTilemap4x8_ag_asm

      ld hl,#decompress_buffer
      ld de,#0xC280
      ld c, #40
      ld b, #66
      call cpct_drawSprite_asm  ;; Inicio del buffer de descompresión ¬
      ld hl,#0xA90              ;;              Offeset = 2640 + 64 (0x40) = 2704 = 0xA90
      ld de, #0xC2A8
      ld c, #40
      ld b, #66
      call cpct_drawSprite_asm


  ret
