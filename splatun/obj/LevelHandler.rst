ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 
   2A05 00                    2 current_level:   .db #0     ;; Offset desde el inicio de la lista de niveles
                              3                             ;; Como cada nivel son 2 bytes, aumentará de 2 en 2
                              4 
                     0000     5 CLEAR_COLOR     = 0
                              6 
                     01DB     7 decompress_buffer        = 0x1DB
                     0384     8 MapSize                  = 0x384
                     0001     9 EnemiesSize              = 0x1
                     0384    10 MapSize                  = 0x384
                     000A    11 SpawnPointsSize          = 0xA
                     0002    12 TeleporterSize           = 0x2
                             13 
                     0393    14 levelMaxSize             = 0x393
                             15 
                     056D    16 level_end           == decompress_buffer + levelMaxSize - 1
                     055F    17 NumberOfEnemies     == decompress_buffer + MapSize
                     0560    18 SpawnPoints         == NumberOfEnemies + EnemiesSize
                     056A    19 Teleporter          == SpawnPoints + SpawnPointsSize
                     056C    20 HeroSpawn           == Teleporter + TeleporterSize
                             21 
                     056E    22 alternative_buffer == HeroSpawn + 2
                             23 
   2A06 00                   24 SpawnOffset::    .db #0
                             25 
                             26 
   2A07                      27 level_list:
   2A07 35 1B                28     .dw #_level1_end
   2A09 95 11                29     .dw #_level18_end
   2A0B 24 12                30     .dw #_level15_end
   2A0D D5 12                31     .dw #_level12_end
   2A0F DD 1A                32     .dw #_level2_end
   2A11 43 1A                33     .dw #_level3_end
   2A13 38 19                34     .dw #_level4_end
   2A15 3F 18                35     .dw #_level5_end
   2A17 4A 17                36     .dw #_level6_end
   2A19 4E 16                37     .dw #_level7_end
   2A1B 73 15                38     .dw #_level8_end
   2A1D 7D 14                39     .dw #_level9_end
   2A1F C8 13                40     .dw #_level10_end
                             41 
                             42 ;   Public
                             43 ;=================================
                             44 
                             45 ;;  ---
                             46 ;;  Loads the first level
                             47 ;;  DESTROYS: A, B, DE, HL
                             48 ;;========================================================
   2A21                      49 loadLevel1::
   2A21 3E 00         [ 7]   50     ld a, #0                ;; Pongo un 0 en el offset
   2A23 32 05 2A      [13]   51     ld (current_level), a
   2A26 C3 4E 2A      [10]   52     jp loadCurrentLevel
                             53 
                             54 ;;  ---
                             55 ;;  Loads the next level from the current one
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                             56 ;;  DESTROYS: A, B, DE, HL
                             57 ;;========================================================
   2A29                      58 loadNextLevel::
                             59 
   2A29 3A 05 2A      [13]   60     ld a, (current_level)
   2A2C 3C            [ 4]   61     inc a
   2A2D 3C            [ 4]   62     inc a
   2A2E 32 05 2A      [13]   63     ld (current_level), a
   2A31 CD 4E 2A      [17]   64     call loadCurrentLevel
   2A34 C3 91 2A      [10]   65     jp toggleTransition
                             66 
                             67 
                             68 ;   Private
                             69 ;=================================
                             70 
                             71 ;; AUMENTA EL NUMERO DE NIVEL: 1,2,3,4,...
                             72 ;; ¡¡¡Y LAS DECENAS!!!
                             73 ;; SE UTILIZAN A LA HORA DE DIBUJAR EL JUD
   2A37                      74 updateLevelNumber:
                             75     ;; Primero actualizo unidades
   2A37 3A F8 2A      [13]   76     ld a, (number_unidades)
   2A3A 3C            [ 4]   77     inc a
   2A3B 32 F8 2A      [13]   78     ld (number_unidades), a
                             79 
                             80     ;; Ahora las decenas en el caso que
                             81     ;; las unidades lleguen a 10
   2A3E FE 0A         [ 7]   82     cp #10
   2A40 C0            [11]   83     ret nz
                             84         ;; Actualizo las decenas
   2A41 3A F7 2A      [13]   85         ld  a, (number_decenas)
   2A44 3C            [ 4]   86         inc a
   2A45 32 F7 2A      [13]   87         ld (number_decenas), a
                             88 
                             89         ;;Pongo a 0 las unidades
   2A48 3E 00         [ 7]   90         ld a, #0
   2A4A 32 F8 2A      [13]   91         ld (number_unidades), a
   2A4D C9            [10]   92     ret
                             93 
                             94 
                             95 ;;  ---
                             96 ;;  Loads the level that "current_level" is pointing to, adding the offset
                             97 ;;  DESTROYS: A, B, DE, HL
                             98 ;;=========================================================================
   2A4E                      99 loadCurrentLevel:
   2A4E 16 00         [ 7]  100     ld d, #0            ;; Cargo en DE el offset
   2A50 5F            [ 4]  101     ld e, a
   2A51 21 07 2A      [10]  102     ld hl, #level_list  ;; HL apunta al inicio de la lista de mapas
   2A54 19            [11]  103     add hl, de          ;; Sumo el offset a HL
                            104 
   2A55 7E            [ 7]  105     ld a, (hl)
   2A56 23            [ 6]  106     inc hl
   2A57 46            [ 7]  107     ld b, (hl)
                            108 
   2A58 6F            [ 4]  109     ld l, a
   2A59 60            [ 4]  110     ld h, b             ;; HL contiene el puntero al mapa a descomprimir
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



                            111 
   2A5A 11 6D 05      [10]  112     ld de, #level_end
   2A5D CD 8D 3E      [17]  113     call cpct_zx7b_decrunch_s_asm
                            114 
                            115 
   2A60                     116 update_nextLevelInfo:
   2A60 CD 88 27      [17]  117     call resetHero
   2A63 CD 87 33      [17]  118     call recalculateCameraOffset        ;; Importante que este método vaya justo después
                            119                                         ;; de resetHero, por IX, y ahorrar un par de bytes
   2A66 3E 00         [ 7]  120     ld a, #0
   2A68 32 06 2A      [13]  121     ld (SpawnOffset), a
   2A6B CD CB 2F      [17]  122     call initEnemies
                            123 
   2A6E CD 37 2A      [17]  124     call updateLevelNumber
   2A71 CD F3 2B      [17]  125     call dw_drawLevelInfo
   2A74 CD 59 2C      [17]  126     call dw_drawAndUpdateHUDEnemies
   2A77 CD 0E 2B      [17]  127     call swapBuffers
   2A7A CD F3 2B      [17]  128     call dw_drawLevelInfo
   2A7D CD 59 2C      [17]  129     call dw_drawAndUpdateHUDEnemies
   2A80 CD 0E 2B      [17]  130     call swapBuffers
                            131 
   2A83 3A 4D 26      [13]  132     ld    a, (HERO_LIVES)
   2A86 3C            [ 4]  133     inc   a
   2A87 FE 06         [ 7]  134     cp #K_HERO_LIVES+1
   2A89 D0            [11]  135     ret nc
   2A8A 32 4D 26      [13]  136     ld (HERO_LIVES), a
   2A8D CD DE 2D      [17]  137     call HEARTS_UPDATE
   2A90 C9            [10]  138 ret
                            139 
                            140 ;;  ---
                            141 ;;  Displays de loading screen
                            142 ;;  DESTROYS: A, B, DE, HL
                            143 ;;==================================================================
   2A91                     144 toggleTransition:
   2A91 CD B8 2A      [17]  145     call fillAlternativeBuffer      ;; Lleno con #29 un "buffer" alternativo
                            146 
   2A94 21 6E 05      [10]  147     ld hl, #alternative_buffer      ;; Le digo a la funcion que pinta por columnas
   2A97 22 DB 2A      [16]  148     ld (map), hl                    ;; dónde está mi "mapa" lleno de #29
   2A9A CD C6 2A      [17]  149     call clearPlayableAreaAlt
                            150 
   2A9D 1E FF         [ 7]  151     ld e, #0xFF
   2A9F                     152     Timeout:
   2A9F CD CD 3E      [17]  153         call cpct_waitVSYNC_asm
   2AA2 1D            [ 4]  154         dec e
   2AA3 20 FA         [12]  155     jr nz, Timeout
                            156 
   2AA5 21 DB 01      [10]  157     ld hl, #decompress_buffer       ;; Ahora le digo dónde está el verdadero mapa
   2AA8 22 DB 2A      [16]  158     ld (map), hl                    ;; descomprimido del siguiente nivel, y vuelvo
   2AAB CD C6 2A      [17]  159     call clearPlayableAreaAlt       ;; a dibujar por columnas
   2AAE CD 10 2E      [17]  160     call resetTilemap               ;; Dejo al configuración del tilemap como estaba
                            161 
   2AB1 CD 84 34      [17]  162     call drawMap                    ;; Como hemos estado dibujando en el frontBuffer,
   2AB4 CD 0E 2B      [17]  163     call swapBuffers                ;; dibujo el mapa completo en el backBuffer y hago swap
   2AB7 C9            [10]  164 ret
                            165 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
Hexadecimal [16-Bits]



                            166 ;;  ---
                            167 ;;  Fills with #29 (0x1D) a mapSize (#0x384) from end of decompress_buffer
                            168 ;;  DESTROYS: HL, DE
                            169 ;;=========================================================================
   2AB8                     170 fillAlternativeBuffer::
   2AB8 21 6E 05      [10]  171     ld  hl,  #alternative_buffer
   2ABB 36 1D         [10]  172     ld (hl), #29
   2ABD 11 6F 05      [10]  173     ld  de,  #alternative_buffer + 1
   2AC0 01 83 03      [10]  174     ld  bc,  #0x384-1
   2AC3 ED B0         [21]  175     ldir
   2AC5 C9            [10]  176 ret
                            177 
                            178 
                            179 ;;  ---
                            180 ;;  Draws a map by columns, from left to right
                            181 ;;  DESTROYS: A, BC, DE, HL
                            182 ;;=========================================================================
   2AC6                     183 clearPlayableAreaAlt::
                            184 
   2AC6 06 10         [ 7]  185     ld b, #16
   2AC8 0E 02         [ 7]  186     ld c, #2
   2ACA                     187     blackInnerLoop:
   2ACA 21 F7 08      [10]  188         ld hl, #_g_00
   2ACD 11 1E 00      [10]  189         ld de, #30
   2AD0 CD 38 3F      [17]  190         call cpct_etm_setDrawTilemap4x8_ag_asm
                            191 
   2AD3 3A EA 2A      [13]  192         ld a, (front_buffer)                  ;; Apunta al inicio de la memoria de video
   2AD6 3C            [ 4]  193         inc a
   2AD7 67            [ 4]  194         ld h, a
   2AD8 2E 48         [ 7]  195         ld l, #0x48
                     00D6   196         map == . + 1
   2ADA 11 6E 05      [10]  197         ld de, #alternative_buffer
   2ADD C5            [11]  198         push bc
   2ADE CD C7 3D      [17]  199         call cpct_etm_drawTilemap4x8_ag_asm
                            200         ;call swapBuffers
   2AE1 C1            [10]  201         pop bc
   2AE2 0C            [ 4]  202         inc c
   2AE3 0C            [ 4]  203         inc c
   2AE4 79            [ 4]  204         ld a, c
   2AE5 FE 12         [ 7]  205         cp #18
   2AE7 20 E1         [12]  206     jr nz, blackInnerLoop
                            207 
   2AE9 C9            [10]  208 ret
                            209 
                            210 ;   ---
                            211 ;   Fills with zeros the playable area
                            212 ;   DESTROYS: EVERYTHING
                            213 ;=====================================
                            214 ;clearPlayableArea:
                            215 ;    ld a, (front_buffer)
                            216 ;    inc a
                            217 ;    ld h, a
                            218 ;    ld l, #0x48
                            219 ;
                            220 ;    ld a, #16
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



                            221 ;    supreme_loop:
                            222 ;        push hl
                            223 ;        exx
                            224 ;        pop hl
                            225 ;        ld c, #8
                            226 ;        outer_loop:
                            227 ;            ld b, #64
                            228 ;            inner_loop:
                            229 ;                ld (hl), #CLEAR_COLOR
                            230 ;                inc hl
                            231 ;                dec b
                            232 ;            jr nz, inner_loop
                            233 ;            ld de, #0x7C0 ;; #0x800 - #0x40 (64) = #0x7C0
                            234 ;            add hl, de
                            235 ;            dec c
                            236 ;        jr nz, outer_loop
                            237 ;        exx
                            238 ;        ld de, #0x50
                            239 ;        add hl, de
                            240 ;        dec a
                            241 ;    jr nz, supreme_loop
                            242 ;ret
