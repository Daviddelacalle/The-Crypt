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
                             94  ;;-----------------------------------------------------------------------------------------;;
                             95  ;; Entidad enemigo por defecto
                             96  .macro DefineEnemyDefault _name, _suf
                             97     DefineEnemy _name'_suf, #0xAA, #0, #0, #0, #0, #0, #0, #0xFFFF, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #1           ;;'
                             98  .endm
                             99 
                            100  ;; Definir N entidades enemigo
                            101  .macro DefineNEnemies _name, _n
                            102     _c = 0
                            103     .rept _n
                            104        DefineEnemyDefault _name, \_c
                            105        _c = _c + 1
                            106     .endm
                            107  .endm
                            108 
                            109  ;; Entidad enemigo
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
Hexadecimal [16-Bits]



                            110  .macro DefineEnemy  _name, _x, _y, _w, _h, _vx, _vy, _col, _upd, _goal_flag, _goal_x, _goal_y, save_dX, save_dY, IncYr, IncXr, av, avR, avI, flag_vel
                            111  _name:
                            112     DefineDrawableEnt _name'_dw, _x, _y, _w, _h                       ;;'
                            113     DefineMovableEnt  _name'_mv, _vx, _vy                             ;;'
                            114  ;; Si no tiene sprite
                            115     .db  _col        ;; Color
                            116  ;; Si tiene sprite
                            117  ;;.dw   _spr
                            118     .dw  _upd        ;; Puntero a la funcion de update
                            119     .db  _goal_flag  ;; 0 -> No se ha
                            120     .db  _goal_x     ;; X de la posicion final
                            121     .db  _goal_y     ;; Y de la posicion final
                            122 
                            123     ;;BRESENHAM
                            124     .dw  save_dX     ;; Distancia en X del objetivo
                            125     .dw  save_dY     ;; Distancia en Y del objetivo
                            126     .db  IncYr       ;; Incremento recto en Y
                            127     .db  IncXr       ;; Incremento recto en X
                            128     .dw  av          ;; Avance
                            129     .dw  avR         ;; Avance recto
                            130     .dw  avI         ;; Avance inclinado
                            131     .db  flag_vel    ;; 1 = Esta utilizando IncYi/IncXi |------------| 0 = Esta utilizando IncYr/IncXr
                            132  ;; Aqui falta saber el tamanyo de la entidad
                            133  en_size = . - (_name)
                            134  .endm
                            135 
                            136  ;;;;;;;;;;;;;;;;;;;
                            137  ;; Constantes de las entidades hero/enemy
                            138  ;;;;;;;;;;;;;;;;;;;
                     0001   139       en_x = 0         en_y = 1
                     0003   140       en_w = 2         en_h = 3
                     0005   141      en_vx = 4        en_vy = 5
                     0006   142     en_col = 6
                     0008   143    en_up_l = 7      en_up_h = 8
                     0009   144  en_g_flag = 9
                            145  ;;------------------------------BRESENHAM
                     000B   146     en_g_x = 10      en_g_y = 11
                     000D   147    en_dX_l = 12     en_dX_h = 13
                     000F   148    en_dY_l = 14     en_dY_h = 15
                     0011   149   en_incYr = 16    en_incXr = 17
                     0013   150    en_av_l = 18     en_av_h = 19
                     0015   151   en_avR_l = 20    en_avR_h = 21
                     0017   152   en_avI_l = 22    en_avI_h = 23
                     0018   153 en_flagVel = 24
                            154 
                            155 
                            156 
                            157 
                            158 
                            159 
                            160 
                            161 
                            162 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



                              5 
   493C 00 40                 6 map_ptr:    .dw #_nivel1
                              7                 ;   X    Y     W     H       VX     VY    COL
   493E                       8 DefineEntity _obs, #10, #40, #0x04, #0x08, #0x00, #0x00, #0xFF, #0x0000
   493E                       1 _obs:
   0002                       2    DefineDrawableEnt _obs_dw, #10, #40, #0x04, #0x08                       ;;'
   0002                       1 _obs_dw:
   493E 0A 28                 2    .db   #10, #40      ;; Posicion    (x,y)
   4940 04 08                 3    .db   #0x04, #0x08      ;; Dimensiones (w,h)
   4942                       3    DefineMovableEnt  _obs_mv, #0x00, #0x00                             ;;'
   0006                       1 _obs_mv:
   4942 00 00                 2    .db   #0x00, #0x00    ;; Variables de la velocidad
                              4 ;; Si no tiene sprite
   4944 FF                    5    .db   #0xFF        ;; Color
                              6 ;; Si tiene sprite
                              7 ;;.dw   _spr
   4945 00 00                 8    .dw   #0x0000        ;; Puntero a la funcion de update
                              9 
                             10 ;; Aqui falta saber el tamanyo de la entidad
                     0009    11 e_size = . - (_obs)
                              9 
                             10 
                             11 ;Disrupción alienígeca
   4947                      12 obs_draw::
   4947 DD 21 3E 49   [14]   13     ld ix, #_obs
   494B C3 3C 46      [10]   14     jp dw_draw
                             15 
   494E                      16 obs_clear::
   494E DD 21 3E 49   [14]   17     ld ix, #_obs
   4952 C3 71 46      [10]   18     jp dw_clear
                             19 
                             20 ;========================================================================;
                             21 ;   Inreases ptr to map
                             22 ;========================================================================;
   4955                      23 inc_map_y::
                             24 
   4955 2A 3C 49      [16]   25     ld hl, (map_ptr)
                             26 
   4958 FE 01         [ 7]   27     cp #1
   495A 20 05         [12]   28     jr nz, up
   495C 11 3C 00      [10]   29         ld de, #60
   495F 18 03         [12]   30         jr continue
   4961                      31     up:
   4961 11 C4 FF      [10]   32     ld de, #-60
                             33 
   4964                      34     continue:
   4964 19            [11]   35         add hl, de
   4965 22 3C 49      [16]   36     ld (map_ptr), hl
   4968 CD 6C 49      [17]   37     call drawMap
   496B C9            [10]   38 ret
                             39 
                             40 ;========================================================================;
                             41 ;   Draws the complete map.in.include "drawable.h.s"clude "drawable.h.s"
                             42 ;========================================================================;
   496C                      43 drawMap::
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



   496C 21 84 43      [10]   44     ld hl, #_g_0
   496F 0E 14         [ 7]   45     ld c, #20       ;40
   4971 06 19         [ 7]   46     ld b, #25      ;100
   4973 11 1E 00      [10]   47     ld de, #30
   4976 CD 3E 4B      [17]   48     call cpct_etm_setDrawTilemap4x8_ag_asm
                             49 
   4979 21 00 C0      [10]   50     ld hl, #0xC000
   497C ED 5B 3C 49   [20]   51     ld de, (map_ptr)
   4980 CD A4 49      [17]   52     call cpct_etm_drawTilemap4x8_ag_asm
   4983 C9            [10]   53 ret
                             54 
