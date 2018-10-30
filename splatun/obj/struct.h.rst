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
                             20    DefineEntity _name'_suf, 0xAA, 0, 0, 0, 0, 0, 0x0000, 0xFFFF           ;;'
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
                             33 .macro DefineEntity  _name, _x, _y, _w, _h, _vx, _vy, _spr, _upd
                             34 _name:
                             35     DefineDrawableEnt _name'_dw, _x, _y, _w, _h                       ;;'
                             36     DefineMovableEnt  _name'_mv, _vx, _vy                             ;;'
                             37 ;; Si tiene sprite
                             38     .dw   _spr
                             39     .dw   _upd        ;; Puntero a la funcion de update
                             40 
                             41 ;; Aqui falta saber el tamanyo de la entidad
                             42 e_size = . - (_name)
                             43 .endm
                             44 
                             45 ;;;;;;;;;;;;;;;;;;;
                             46 ;; Constantes de las entidades hero/enemy
                             47 ;;;;;;;;;;;;;;;;;;;
                     0001    48     e_x = 0      e_y = 1
                     0003    49     e_w = 2      e_h = 3
                     0005    50    e_vx = 4     e_vy = 5
                     0007    51 e_spr_l = 6  e_spr_h = 7
                     0009    52  e_up_l = 8   e_up_h = 9
                             53 
                             54 
                             55 ;;-----------------------------------------------------------------------------------------;;
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                             56 ;; Entidad bullet
                             57 .macro DefineBullet  _name, _x, _y, _w, _h, _vx, _vy, _spr, _alive, _upd
                             58 _name:
                             59    DefineDrawableEnt _name'_dw, _x, _y, _w, _h                       ;;'
                             60    DefineMovableEnt  _name'_mv, _vx, _vy                             ;;'
                             61    .dw   _spr        ;; Color / Sprite (cuando haya)
                             62    .db   _alive      ;; _alive>0? Se actualiza/dibuja
                             63    .dw   _upd        ;; Funcion de update
                             64 
                             65 ;; Saber tamanyo de entidad bala
                             66 b_size = . - (_name)
                             67 .endm
                             68 
                             69 ;; Entidad por defecto de bullet
                             70 .macro DefineBulletDefault _name, _suf
                             71    DefineBullet _name'_suf, 0xAA, 0, 0, 0, 0, 0, 0x0000, 0, 0xFFFF        ;;'
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
                     0001    86      b_x = 0      b_y = 1
                     0003    87      b_w = 2      b_h = 3
                     0005    88     b_vx = 4     b_vy = 5
                     0007    89  b_spr_l = 6  b_spr_h = 7
                     0008    90  b_alive = 8
                     000A    91   b_up_l = 9   b_up_h = 10
                             92 
                             93 
                             94 
                             95  ;;-----------------------------------------------------------------------------------------;;
                             96  ;; Entidad enemigo por defecto
                             97  .macro DefineEnemyDefault _name, _suf
                             98     DefineEnemy _name'_suf, #0xAA, #0, #0, #0, #0, #0, #0x0000, #0xFFFF, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #1, #1           ;;'
                             99  .endm
                            100 
                            101  ;; Definir N entidades enemigo
                            102  .macro DefineNEnemies _name, _n
                            103     _c = 0
                            104     .rept _n
                            105        DefineEnemyDefault _name, \_c
                            106        _c = _c + 1
                            107     .endm
                            108  .endm
                            109 
                            110  ;; Entidad enemigo
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



                            111  .macro DefineEnemy  _name, _x, _y, _w, _h, _vx, _vy, _spr, _upd, _goal_flag, _goal_x, _goal_y, save_dX, save_dY, IncYr, IncXr, av, avR, avI, flag_vel, alive
                            112  _name:
                            113     DefineDrawableEnt _name'_dw, _x, _y, _w, _h                       ;;'
                            114     DefineMovableEnt  _name'_mv, _vx, _vy                             ;;'
                            115  ;; Si tiene sprite
                            116     .dw  _spr
                            117     .dw  _upd        ;; Puntero a la funcion de update
                            118     .db  _goal_flag  ;; 0 -> No se ha
                            119     .db  _goal_x     ;; X de la posicion final
                            120     .db  _goal_y     ;; Y de la posicion final
                            121 
                            122     ;;BRESENHAM
                            123     .dw  save_dX     ;; Distancia en X del objetivo
                            124     .dw  save_dY     ;; Distancia en Y del objetivo
                            125     .db  IncYr       ;; Incremento recto en Y
                            126     .db  IncXr       ;; Incremento recto en X
                            127     .dw  av          ;; Avance
                            128     .dw  avR         ;; Avance recto
                            129     .dw  avI         ;; Avance inclinado
                            130     .db  flag_vel    ;; 1 = Esta utilizando IncYi/IncXi |------------| 0 = Esta utilizando IncYr/IncXr
                            131     .db  alive
                            132  ;; Aqui falta saber el tamanyo de la entidad
                            133  en_size = . - (_name)
                            134  .endm
                            135 
                            136  ;;;;;;;;;;;;;;;;;;;
                            137  ;; Constantes de las entidades hero/enemy
                            138  ;;;;;;;;;;;;;;;;;;;
                            139 
                     0001   140       en_x = 0         en_y = 1
                     0003   141       en_w = 2         en_h = 3
                     0005   142      en_vx = 4        en_vy = 5
                     0007   143   en_spr_l = 6     en_spr_h = 7
                     0009   144    en_up_l = 8      en_up_h = 9
                     000A   145  en_g_flag = 10
                            146  ;;------------------------------BRESENHAM
                     000C   147     en_g_x = 11      en_g_y = 12
                     000E   148    en_dX_l = 13     en_dX_h = 14
                     0010   149    en_dY_l = 15     en_dY_h = 16
                     0012   150   en_incYr = 17    en_incXr = 18
                     0014   151    en_av_l = 19     en_av_h = 20
                     0016   152   en_avR_l = 21    en_avR_h = 22
                     0018   153   en_avI_l = 23    en_avI_h = 24
                     001A   154 en_flagVel = 25      en_alv = 26
                            155 
                            156 
                            157 
                            158 
                            159 
                            160 
                            161 
                            162 
                            163 
