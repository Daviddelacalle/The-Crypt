.include "cpctelera.h.s"
.include "constants.h.s"

drawGameOver::
    ;; Reinicio las vidas del jugador
    ld a, #K_HERO_LIVES
    ld (HERO_LIVES), a

    ld de, #_GameOver
    call cpct_akp_musicInit_asm

    call fillAlternativeBuffer      ;; Lleno con #29 un "buffer" alternativo

    ld hl, #alternative_buffer      ;; Le digo a la funcion que pinta por columnas
    ld (map), hl                    ;; dónde está mi "mapa" lleno de #29
    call clearPlayableAreaAlt
    ;; Pintar GAMEOVER

    ;;
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