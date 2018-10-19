
current_level:   .db #0     ;; Offset desde el inicio de la lista de niveles
                            ;; Como cada nivel son 2 bytes, aumentará de 2 en 2

level_list:
    .dw #_level1_end
    .dw #_level2_end
    .dw #_level3_end

;   Public
;=================================

;;  ---
;;  Loads the first level
;;  DESTROYS: A, B, DE, HL
;;========================================================
loadLevel1::
    ld a, #0                ;; Pongo un 0 en el offset
    ld (current_level), a
    jp loadCurrentLevel

;;  ---
;;  Loads the next level from the current one
;;  DESTROYS: A, B, DE, HL
;;========================================================
loadNextLevel::
    ld a, (current_level)
    inc a
    inc a
    ld (current_level), a
    jp loadCurrentLevel


;   Private
;=================================

;;  ---
;;  Loads the level that current_level adding the offset
;;  DESTROYS: A, B, DE, HL
;;========================================================
loadCurrentLevel::
    ld d, #0            ;; Cargo en DE el offset
    ld e, a
    ld hl, #level_list  ;; HL apunta al inicio de la lista de mapas
    add hl, de          ;; Sumo el offset a HL

    ld a, (hl)
    inc hl
    ld b, (hl)

    ld l, a
    ld h, b             ;; HL contiene el puntero al mapa a descomprimir

    ld de, #decompress_buffer_end
    call cpct_zx7b_decrunch_s_asm
ret