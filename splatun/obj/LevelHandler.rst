ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 
   3886 00                    2 current_level:   .db #0     ;; Offset desde el inicio de la lista de niveles
                              3                             ;; Como cada nivel son 2 bytes, aumentará de 2 en 2
                              4 
                     0004     5 TIMEOUT         = 4         ;; Segundos (aprox.)
                     0000     6 CLEAR_COLOR     = 0
                              7 
                     0040     8 decompress_buffer        = 0x040
                     0384     9 MapSize                  = 0x384
                     000A    10 SpawnPointsSize          = 0xA
                             11 
                     0390    12 levelMaxSize             = 0x390
                     03CF    13 level_end   == decompress_buffer + levelMaxSize - 1
                     03C4    14 SpawnPoints == decompress_buffer + MapSize
                     03CE    15 Teleporter  == SpawnPoints + SpawnPointsSize
                             16 
                             17 
   3887                      18 level_list:
   3887 E7 1A                19     .dw #_level1_end
   3889 D0 19                20     .dw #_level2_end
   388B 6F 19                21     .dw #_level3_end
                             22 
                             23 ;   Public
                             24 ;=================================
                             25 
                             26 ;;  ---
                             27 ;;  Loads the first level
                             28 ;;  DESTROYS: A, B, DE, HL
                             29 ;;========================================================
   388D                      30 loadLevel1::
   388D 3E 00         [ 7]   31     ld a, #0                ;; Pongo un 0 en el offset
   388F 32 86 38      [13]   32     ld (current_level), a
   3892 C3 A3 38      [10]   33     jp loadCurrentLevel
                             34 
                             35 ;;  ---
                             36 ;;  Loads the next level from the current one
                             37 ;;  DESTROYS: A, B, DE, HL
                             38 ;;========================================================
   3895                      39 loadNextLevel::
                             40 
   3895 CD B6 38      [17]   41     call displayLoadingScreen
                             42 
   3898 3A 86 38      [13]   43     ld a, (current_level)
   389B 3C            [ 4]   44     inc a
   389C 3C            [ 4]   45     inc a
   389D 32 86 38      [13]   46     ld (current_level), a
   38A0 C3 A3 38      [10]   47     jp loadCurrentLevel
                             48 
                             49 
                             50 ;   Private
                             51 ;=================================
                             52 
                             53 ;;  ---
                             54 ;;  Loads the level that current_level adding the offset
                             55 ;;  DESTROYS: A, B, DE, HL
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                             56 ;;========================================================
   38A3                      57 loadCurrentLevel::
   38A3 16 00         [ 7]   58     ld d, #0            ;; Cargo en DE el offset
   38A5 5F            [ 4]   59     ld e, a
   38A6 21 87 38      [10]   60     ld hl, #level_list  ;; HL apunta al inicio de la lista de mapas
   38A9 19            [11]   61     add hl, de          ;; Sumo el offset a HL
                             62 
   38AA 7E            [ 7]   63     ld a, (hl)
   38AB 23            [ 6]   64     inc hl
   38AC 46            [ 7]   65     ld b, (hl)
                             66 
   38AD 6F            [ 4]   67     ld l, a
   38AE 60            [ 4]   68     ld h, b             ;; HL contiene el puntero al mapa a descomprimir
                             69 
   38AF 11 CF 03      [10]   70     ld de, #level_end
   38B2 CD 21 40      [17]   71     call cpct_zx7b_decrunch_s_asm
   38B5 C9            [10]   72 ret
                             73 
                             74 ;;  ---
                             75 ;;  Displays de loading screen
                             76 ;;  DESTROYS: A, B, DE, HL
                             77 ;;==================================================================
   38B6                      78 displayLoadingScreen:
                             79 
   38B6 CD CD 38      [17]   80     call clearPlayableArea
   38B9 CD 1C 39      [17]   81     call swapBuffers
   38BC CD CD 38      [17]   82     call clearPlayableArea
                             83 
   38BF 16 10         [ 7]   84     ld d, #TIMEOUT*4
   38C1                      85     WaitB:
   38C1 1E FF         [ 7]   86         ld e, #0xFF
   38C3                      87         Timeout:
   38C3 CD 61 40      [17]   88             call cpct_waitVSYNC_asm
   38C6 1D            [ 4]   89             dec e
   38C7 20 FA         [12]   90         jr nz, Timeout
   38C9 15            [ 4]   91         dec d
   38CA 20 F5         [12]   92     jr nz, WaitB
   38CC C9            [10]   93 ret
                             94 
                             95 ;   ---
                             96 ;   Fills with zeros the playable area
                             97 ;   DESTROYS: EVERYTHING
                             98 ;=====================================
   38CD                      99 clearPlayableArea:
   38CD 3A 1B 39      [13]  100     ld a, (back_buffer)
   38D0 3C            [ 4]  101     inc a
   38D1 67            [ 4]  102     ld h, a
   38D2 2E 48         [ 7]  103     ld l, #0x48
                            104 
   38D4 3E 10         [ 7]  105     ld a, #16
   38D6                     106     supreme_loop:
   38D6 E5            [11]  107         push hl
   38D7 D9            [ 4]  108         exx
   38D8 E1            [10]  109         pop hl
   38D9 0E 08         [ 7]  110         ld c, #8
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



   38DB                     111         outer_loop:
   38DB 06 40         [ 7]  112             ld b, #64
   38DD                     113             inner_loop:
   38DD 36 00         [10]  114                 ld (hl), #CLEAR_COLOR
   38DF 23            [ 6]  115                 inc hl
   38E0 05            [ 4]  116                 dec b
   38E1 20 FA         [12]  117             jr nz, inner_loop
   38E3 11 C0 07      [10]  118             ld de, #0x7C0 ;; #0x800 - #0x40 (64)
   38E6 19            [11]  119             add hl, de
   38E7 0D            [ 4]  120             dec c
   38E8 20 F1         [12]  121         jr nz, outer_loop
   38EA D9            [ 4]  122         exx
   38EB 11 50 00      [10]  123         ld de, #0x50
   38EE 19            [11]  124         add hl, de
   38EF 3D            [ 4]  125         dec a
   38F0 20 E4         [12]  126     jr nz, supreme_loop
   38F2 C9            [10]  127 ret
