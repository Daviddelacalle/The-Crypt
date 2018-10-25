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



decompress_buffer       == 0x175
imageMaxSize             = 0x14A0
buffer_end_img = decompress_buffer + imageMaxSize - 1

;===========0xdc===============================================;
;   Disable firmware to avoid configuration override
;   Load custom palette
;==========================================================;
.macro init
    call cpct_disableFirmware_asm
    ld    c, #0
    call cpct_setVideoMode_asm

    ld de, #_song_ingame
    call cpct_akp_musicInit_asm

    ld de, #_sfx
    call cpct_akp_SFXInit_asm

    ld hl, #_g_palette
    ld de, #16
    call cpct_setPalette_asm

    ;; Clean 16K: 0x8000 -> 0xC000
    ld  hl,  #0x8000
    ld (hl), #0
    ld  de,  #0x8000 + 1
    ld  bc,  #0x4000 - 1
    ldir

    ld hl, #_g_00
    ld c, #VIEWPORT_WIDTH        ;; Ancho
    ld b, #VIEWPORT_HEIGHT        ;; Alto
    ld de, #30
    call cpct_etm_setDrawTilemap4x8_ag_asm
.endm

unavariable: .db #5

isr:
  ex af, af';'
  exx
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
    pop iy
    pop hl
    pop de
    pop bc
    pop af

  exx
  ex af,af';'

ret
;; Punto de entrada de la funcion main
_main::
    ; --> Realocate stack memory <-- ;
    ld sp, #0x8000

    init
    call drawMenu

    ld hl, #_titleScreen_end
    ld de, #buffer_end_img
    call cpct_zx7b_decrunch_s_asm

    loop_load::

      call load_control
      jr loop_load
      map_start::
      ld hl, #isr
      call cpct_setInterruptHandler_asm
      call loadLevel1       ;; Cargo el nivel 1
      call drawMap

    ;; Comienza el bucle del juego
    loop::

        ;; CLIAR
        ;call bullet_clear
        ;call obs_clear
        ;call enemy_clear_ALL
        ;call hero_clear

        ;; DRO
        call drawMap
        call bullet_draw
        call enemy_draw_ALL
        call hero_draw

        ;; UPDEIT
        call enemy_update_ALL
        call hero_update
        call bullet_inputs
        call bullet_update

        call cpct_waitVSYNC_asm
        call swapBuffers
        call kill
jr loop
