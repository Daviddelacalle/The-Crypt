
current_level:   .db #0     ;; Offset desde el inicio de la lista de niveles
                            ;; Como cada nivel son 2 bytes, aumentará de 2 en 2

TIMEOUT         = 2         ;; Segundos (aprox.)
CLEAR_COLOR     = 0

decompress_buffer        = 0x176
MapSize                  = 0x384
EnemiesSize              = 0x1
MapSize                  = 0x384
SpawnPointsSize          = 0xA

levelMaxSize             = 0x391

level_end           == decompress_buffer + levelMaxSize - 1
NumberOfEnemies     == decompress_buffer + MapSize
SpawnPoints         == NumberOfEnemies + EnemiesSize
Teleporter          == SpawnPoints + SpawnPointsSize

SpawnOffset::    .db #0


level_list:
    .dw #_level1_end
    .dw #_level2_end
    .dw #_level3_end
    .dw #_level4_end
    .dw #_level5_end
    .dw #_level6_end
    .dw #_level7_end
    .dw #_level8_end
    .dw #_level9_end
    .dw #_level10_end

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
    call displayLoadingScreen

    ld a, (current_level)
    inc a
    inc a
    ld (current_level), a
    jp loadCurrentLevel


;   Private
;=================================

;; AUMENTA EL NUMERO DE NIVEL: 1,2,3,4,...
;; ¡¡¡Y LAS DECENAS!!!
;; SE UTILIZAN A LA HORA DE DIBUJAR EL JUD
updateLevelNumber:
    ;; Primero actualizo unidades
    ld a, (number_unidades)
    inc a
    ld (number_unidades), a

    ;; Ahora las decenas en el caso que
    ;; las unidades lleguen a 10
    cp #10
    ret nz
        ;; Actualizo las decenas
        ld  a, (number_decenas)
        inc a
        ld (number_decenas), a

        ;;Pongo a 0 las unidades
        ld a, #0
        ld (number_unidades), a
    ret


;;  ---
;;  Loads the level that current_level adding the offset
;;  DESTROYS: A, B, DE, HL
;;========================================================
loadCurrentLevel:
    ld d, #0            ;; Cargo en DE el offset
    ld e, a
    ld hl, #level_list  ;; HL apunta al inicio de la lista de mapas
    add hl, de          ;; Sumo el offset a HL

    ld a, (hl)
    inc hl
    ld b, (hl)

    ld l, a
    ld h, b             ;; HL contiene el puntero al mapa a descomprimir

    ld de, #level_end
    call cpct_zx7b_decrunch_s_asm

    call resetHero
    call resetCamera
    ld a, #0
    ld (SpawnOffset), a
    call initEnemies

    call updateLevelNumber
    call dw_drawLevelInfo
    call swapBuffers
    call dw_drawLevelInfo
    call swapBuffers

ret

;;  ---
;;  Displays de loading screen
;;  DESTROYS: A, B, DE, HL
;;==================================================================
displayLoadingScreen:

    call clearPlayableArea
    call swapBuffers
    call clearPlayableArea

    ld d, #TIMEOUT*4
    WaitB:
        ld e, #0xFF
        Timeout:
            call cpct_waitVSYNC_asm
            dec e
        jr nz, Timeout
        dec d
    jr nz, WaitB
ret

;   ---
;   Fills with zeros the playable area
;   DESTROYS: EVERYTHING
;=====================================
clearPlayableArea:
    ld a, (back_buffer)
    inc a
    ld h, a
    ld l, #0x48

    ld a, #16
    supreme_loop:
        push hl
        exx
        pop hl
        ld c, #8
        outer_loop:
            ld b, #64
            inner_loop:
                ld (hl), #CLEAR_COLOR
                inc hl
                dec b
            jr nz, inner_loop
            ld de, #0x7C0 ;; #0x800 - #0x40 (64) = #0x7C0
            add hl, de
            dec c
        jr nz, outer_loop
        exx
        ld de, #0x50
        add hl, de
        dec a
    jr nz, supreme_loop
ret