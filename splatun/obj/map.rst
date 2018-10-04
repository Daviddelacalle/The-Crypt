ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 .area _DATA
                              2 .area _CODE
                              3 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                              4 .include "struct.h.s"
                              1 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                              2 ;; DEFINICION DE LAS MACROS PARA LA CREACION DE ENTIDADES ;;
                              3 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                              4 
                              5 ;; Entidad drawable
                              6 .macro DefineDrawableEnt _name, _x, _y, _w, _h
                              7 _name:
                              8    .db   _x, _y      ;; Posicion    (x,y)
                              9    .db   _w, _h      ;; Dimensiones (w,h)
                             10 .endm
                             11 
                             12 ;; Entidad movable
                             13 .macro DefineMovableEnt _name, _vx, _vy
                             14 _name:
                             15    .db   _vx, _vy    ;; Variables de la velocidad
                             16 .endm
                             17 
                             18 ;; Entidad por defecto
                             19 .macro DefineEntityDefault _name, _suf
                             20    DefineEntity _name'_suf, 0xAA, 0, 0, 0, 0, 0, 0, 0xFFFF           ;;'
                             21 .endm
                             22 
                             23 ;; Definir N entidades
                             24 .macro DefineNEntities _name, _n
                             25    _c = 0
                             26    .rept _n
                             27       DefineEntityDefault _name, \_c
                             28       _c = _c + 1
                             29    .endm
                             30 .endm
                             31 
                             32 ;; Entidad heroe/enemigo
                             33 .macro DefineEntity  _name, _x, _y, _w, _h, _vx, _vy, _col, _upd
                             34 _name:
                             35    DefineDrawableEnt _name'_dw, _x, _y, _w, _h                       ;;'
                             36    DefineMovableEnt  _name'_mv, _vx, _vy                             ;;'
                             37 ;; Si no tiene sprite
                             38    .db   _col        ;; Color
                             39 ;; Si tiene sprite
                             40 ;;.dw   _spr
                             41    .dw   _upd        ;; Puntero a la funcion de update
                             42 
                             43 ;; Aqui falta saber el tamanyo de la entidad
                             44 e_size = . - (_name)
                             45 .endm
                             46 
                             47 ;;;;;;;;;;;;;;;;;;;
                             48 ;; Constantes de las entidades hero/enemy
                             49 ;;;;;;;;;;;;;;;;;;;
                     0001    50    e_x = 0      e_y = 1
                     0003    51    e_w = 2      e_h = 3
                     0005    52   e_vx = 4     e_vy = 5
                     0006    53  e_col = 6
                     0008    54 e_up_l = 7   e_up_h = 8
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



                             55 
                             56 ;;-----------------------------------------------------------------------------------------;;
                             57 ;; Entidad bullet
                             58 .macro DefineBullet  _name, _x, _y, _w, _h, _vx, _vy, _col, _alive, _upd
                             59 _name:
                             60    DefineDrawableEnt _name'_dw, _x, _y, _w, _h                       ;;'
                             61    DefineMovableEnt  _name'_mv, _vx, _vy                             ;;'
                             62    .db   _col        ;; Color / Sprite (cuando haya)
                             63    .db   _alive      ;; _alive>0? Se actualiza/dibuja
                             64    .dw   _upd        ;; Funcion de update
                             65 
                             66 ;; Saber tamanyo de entidad bala
                             67 .endm
                             68 
                             69 ;; Entidad por defecto de bullet
                             70 .macro DefineBulletDefault _name, _suf
                             71    DefineBullet _name'_suf, 0xAA, 0, 0, 0, 0, 0, 0, 0, 0xFFFF        ;;'
                             72 .endm
                             73 
                             74 ;; Bucle de crear entidades bullet
                             75 .macro DefineNBullets _name, _n
                             76    _c = 0
                             77    .rept _n
                             78       DefineBulletDefault _name, \_c
                             79       _c = _c + 1
                             80    .endm
                             81 .endm
                             82 
                             83 ;;;;;;;;;;;;;;;;;;;
                             84 ;; Constantes de las entidades bullet
                             85 ;;;;;;;;;;;;;;;;;;;
                     0001    86     b_x = 0      b_y = 1
                     0003    87     b_w = 2      b_h = 3
                     0005    88    b_vx = 4     b_vy = 5
                     0007    89   b_col = 6  b_alive = 7
                     0009    90  b_up_l = 8   b_up_h = 9
                             91 
                             92 
                             93 
                             94 
                             95 
                             96 
                             97 
                             98 
                             99 
                            100 
                            101 
                            102 
                            103 
                            104 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
Hexadecimal [16-Bits]



                              5 
   46B4 00 40                 6 map_ptr:    .dw #_nivel1
                              7                 ;   X    Y     W     H       VX     VY    COL
   46B6                       8 DefineEntity _obs, #10, #40, #0x04, #0x08, #0x00, #0x00, #0xFF, #0x0000
   46B6                       1 _obs:
   0002                       2    DefineDrawableEnt _obs_dw, #10, #40, #0x04, #0x08                       ;;'
   0002                       1 _obs_dw:
   46B6 0A 28                 2    .db   #10, #40      ;; Posicion    (x,y)
   46B8 04 08                 3    .db   #0x04, #0x08      ;; Dimensiones (w,h)
   46BA                       3    DefineMovableEnt  _obs_mv, #0x00, #0x00                             ;;'
   0006                       1 _obs_mv:
   46BA 00 00                 2    .db   #0x00, #0x00    ;; Variables de la velocidad
                              4 ;; Si no tiene sprite
   46BC FF                    5    .db   #0xFF        ;; Color
                              6 ;; Si tiene sprite
                              7 ;;.dw   _spr
   46BD 00 00                 8    .dw   #0x0000        ;; Puntero a la funcion de update
                              9 
                             10 ;; Aqui falta saber el tamanyo de la entidad
                     0009    11 e_size = . - (_obs)
                              9 
                             10 
                             11 ;Disrupción alienígeca
   46BF                      12 obs_draw::
   46BF DD 21 B6 46   [14]   13     ld ix, #_obs
   46C3 C3 38 46      [10]   14     jp dw_draw
                             15 
   46C6                      16 obs_clear::
   46C6 DD 21 B6 46   [14]   17     ld ix, #_obs
   46CA C3 6E 46      [10]   18     jp dw_clear
                             19 
                             20 ;========================================================================;
                             21 ;   Inreases ptr to map
                             22 ;========================================================================;
   46CD                      23 inc_map_y::
                             24 
   46CD 2A B4 46      [16]   25     ld hl, (map_ptr)
                             26 
   46D0 FE 01         [ 7]   27     cp #1
   46D2 20 05         [12]   28     jr nz, up
   46D4 11 3C 00      [10]   29         ld de, #60
   46D7 18 03         [12]   30         jr continue
   46D9                      31     up:
   46D9 11 C4 FF      [10]   32     ld de, #-60
                             33 
   46DC                      34     continue:
   46DC 19            [11]   35         add hl, de
   46DD 22 B4 46      [16]   36     ld (map_ptr), hl
   46E0 CD E4 46      [17]   37     call drawMap
   46E3 C9            [10]   38 ret
                             39 
                             40 ;========================================================================;
                             41 ;   Draws the complete map.in.include "drawable.h.s"clude "drawable.h.s"
                             42 ;========================================================================;
   46E4                      43 drawMap::
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



   46E4 21 84 43      [10]   44     ld hl, #_g_0
   46E7 0E 14         [ 7]   45     ld c, #20       ;40
   46E9 06 19         [ 7]   46     ld b, #25      ;100
   46EB 11 1E 00      [10]   47     ld de, #30
   46EE CD 91 48      [17]   48     call cpct_etm_setDrawTilemap4x8_ag_asm
                             49 
   46F1 21 00 C0      [10]   50     ld hl, #0xC000
   46F4 ED 5B B4 46   [20]   51     ld de, (map_ptr)
   46F8 CD 1C 47      [17]   52     call cpct_etm_drawTilemap4x8_ag_asm
   46FB C9            [10]   53 ret
                             54 
