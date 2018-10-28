
current_level:   .db #0     ;; Offset desde el inicio de la lista de niveles
                            ;; Como cada nivel son 2 bytes, aumentará de 2 en 2

CLEAR_COLOR     = 0

decompress_buffer        = 0x176
MapSize                  = 0x384
EnemiesSize              = 0x1
MapSize                  = 0x384
SpawnPointsSize          = 0xA
TeleporterSize           = 0x2

levelMaxSize             = 0x393

level_end           == decompress_buffer + levelMaxSize - 1
NumberOfEnemies     == decompress_buffer + MapSize
SpawnPoints         == NumberOfEnemies + EnemiesSize
Teleporter          == SpawnPoints + SpawnPointsSize
HeroSpawn           == Teleporter + TeleporterSize

alternative_buffer = HeroSpawn + 2

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

    ld a, (current_level)
    inc a
    inc a
    ld (current_level), a
    call loadCurrentLevel
    jp toggleTransition


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
;;  Loads the level that "current_level" is pointing to, adding the offset
;;  DESTROYS: A, B, DE, HL
;;=========================================================================
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


update_nextLevelInfo:
    call resetHero
    call recalculateCameraOffset        ;; Importante que este método vaya justo después
                                        ;; de resetHero, por IX, y ahorrar un par de bytes
    ld a, #0
    ld (SpawnOffset), a
    call initEnemies

    call updateLevelNumber
    call dw_drawLevelInfo
    call swapBuffers
    call dw_drawLevelInfo
    call swapBuffers

    ld    a, (HERO_LIVES)
    inc   a
    cp #K_HERO_LIVES+1
    ret nc
    ld (HERO_LIVES), a
    call HEARTS_UPDATE
ret

;;  ---
;;  Displays de loading screen
;;  DESTROYS: A, B, DE, HL
;;==================================================================
toggleTransition:
    call fillAlternativeBuffer      ;; Lleno con #29 un "buffer" alternativo

    ld hl, #alternative_buffer      ;; Le digo a la funcion que pinta por columnas
    ld (map), hl                    ;; dónde está mi "mapa" lleno de #29
    call clearPlayableAreaAlt

    ld e, #0xFF
    Timeout:
        call cpct_waitVSYNC_asm
        dec e
    jr nz, Timeout

    ld hl, #decompress_buffer       ;; Ahora le digo dónde está el verdadero mapa
    ld (map), hl                    ;; descomprimido del siguiente nivel, y vuelvo
    call clearPlayableAreaAlt       ;; a dibujar por columnas
    call resetTilemap               ;; Dejo al configuración del tilemap como estaba

    call drawMap                    ;; Como hemos estado dibujando en el frontBuffer,
    call swapBuffers                ;; dibujo el mapa completo en el backBuffer y hago swap
ret

;;  ---
;;  Fills with #29 (0x1D) a mapSize (#0x384) from end of decompress_buffer
;;  DESTROYS: HL, DE
;;=========================================================================
fillAlternativeBuffer::
    ld  hl,  #alternative_buffer
    ld (hl), #29
    ld  de,  #alternative_buffer + 1
    ld  bc,  #0x384-1
    ldir
ret


;;  ---
;;  Draws a map by columns, from left to right
;;  DESTROYS: A, BC, DE, HL
;;=========================================================================
clearPlayableAreaAlt:

    ld b, #16
    ld c, #2
    blackInnerLoop:
        ld hl, #_g_00
        ld de, #30
        call cpct_etm_setDrawTilemap4x8_ag_asm

        ld a, (front_buffer)                  ;; Apunta al inicio de la memoria de video
        inc a
        ld h, a
        ld l, #0x48
        map = . + 1
        ld de, #alternative_buffer
        push bc
        call cpct_etm_drawTilemap4x8_ag_asm
        ;call swapBuffers
        pop bc
        inc c
        inc c
        ld a, c
        cp #18
    jr nz, blackInnerLoop

ret

;   ---
;   Fills with zeros the playable area
;   DESTROYS: EVERYTHING
;=====================================
;clearPlayableArea:
;    ld a, (front_buffer)
;    inc a
;    ld h, a
;    ld l, #0x48
;
;    ld a, #16
;    supreme_loop:
;        push hl
;        exx
;        pop hl
;        ld c, #8
;        outer_loop:
;            ld b, #64
;            inner_loop:
;                ld (hl), #CLEAR_COLOR
;                inc hl
;                dec b
;            jr nz, inner_loop
;            ld de, #0x7C0 ;; #0x800 - #0x40 (64) = #0x7C0
;            add hl, de
;            dec c
;        jr nz, outer_loop
;        exx
;        ld de, #0x50
;        add hl, de
;        dec a
;    jr nz, supreme_loop
;ret