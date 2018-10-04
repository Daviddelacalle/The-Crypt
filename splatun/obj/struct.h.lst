ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



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
                             55 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



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
                             97     DefineEnemy _name'_suf, #0xAA, #0, #0, #0, #0, #0, #0, #0xFFFF, #0, #0, #0           ;;'
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
                            110  .macro DefineEnemy  _name, _x, _y, _w, _h, _vx, _vy, _col, _upd, _goal_flag, _goal_x, _goal_y
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



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
                            122  ;; Aqui falta saber el tamanyo de la entidad
                            123  en_size = . - (_name)
                            124  .endm
                            125 
                            126  ;;;;;;;;;;;;;;;;;;;
                            127  ;; Constantes de las entidades hero/enemy
                            128  ;;;;;;;;;;;;;;;;;;;
                     0001   129       en_x = 0      en_y = 1
                     0003   130       en_w = 2      en_h = 3
                     0005   131      en_vx = 4     en_vy = 5
                     0006   132     en_col = 6
                     0008   133    en_up_l = 7   en_up_h = 8
                     0009   134  en_g_flag = 9
                     000B   135     en_g_x = 10  en_g_y = 11
                            136 
                            137 
                            138 
                            139 
                            140 
                            141 
                            142 
                            143 
                            144 
