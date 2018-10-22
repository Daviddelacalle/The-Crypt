ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                     0034     1 INIT_X == #0x34 ;8
                     0040     2 INIT_Y == #0x40 ;32
                              3 
                     0010     4 VIEWPORT_WIDTH == 16
                     0010     5 VIEWPORT_HEIGHT == 16
                              6 
                     000E     7 LimitRight == 30 - VIEWPORT_WIDTH
                     000E     8 LimitDown  == 30 - VIEWPORT_HEIGHT
                              9 
                     0040    10 ScreenSizeX = 16*4
                     0080    11 ScreenSizeY = 16*8
                             12 ;;X = Width * 4 / 4 <~ Múltiplo de 4
                             13 ;;Y = Height * 8 / 4 <~ Múltiplo de 6
                     0014    14 LEFT    == 8+12
                     003C    15 RIGHT   == 8+ScreenSizeX-12
                     0040    16 TOP     == 32+32
                     0080    17 BOTTOM  == 32+ScreenSizeY-32
                             18 
                     001E    19 MAP_WIDTH == 30
                     001E    20 MAP_HEIGHT == 30
                             21 
                             22 ;; Offset para lo del tamaño de cámara adaptable
                     0002    23 OFFSET_CAMERA_POS_X == 2          ;; De tile
                     0004    24 OFFSET_CAMERA_POS_Y == 4          ;; De tile
                             25 
                     0008    26 OFFSET_CAMERA_POS_X_PANT == 4*OFFSET_CAMERA_POS_X     ;; De pantalla
                     0020    27 OFFSET_CAMERA_POS_Y_PANT == 8*OFFSET_CAMERA_POS_Y     ;; De pantalla
                             28 
                             29 
                             30 ;      0  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15
                             31 ;0  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19
                             32 ;      |                                            |
                             33 ;      |           X                    X           |
                             34 ;      |                                            |
                             35 ;      |                                            |
                             36 
                             37 
                             38 
                             39 ;   00
                             40 ;   01
                             41 ;   02
                             42 ;   03
                             43 ; 0 04 ——————————————————————————————————————————————
                             44 ; 1 05
                             45 ; 2 06
                             46 ; 3 07
                             47 ; 4 08
                             48 ; 5 09          X
                             49 ; 6 10
                             50 ; 7 11
                             51 ; 8 12
                             52 ; 9 13
                             53 ;10 14          X
                             54 ;11 15
                             55 ;12 16
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                             56 ;13 17
                             57 ;14 18
                             58 ;15 19 ——————————————————————————————————————————————
                             59 ;   20
                             60 ;   21
                             61 ;   22
                             62 ;   23
                             63 ;   24
                             64 
                             65 
                             66 
                             67 
                             68 
                             69 
