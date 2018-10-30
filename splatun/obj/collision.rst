ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 .include "struct.h.s"
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                             55 ;;-----------------------------------------------------------------------------------------;;
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



                            110  ;; Entidad enemigo
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
Hexadecimal [16-Bits]



                              2 
                              3 ;;==================================================
                              4 ;;  Checks collision with tilemap on the next frame
                              5 ;;  INPUT:  B => Speed
                              6 ;;==================================================
                              7 
                              8 ;; 4 self-modifying functions, they simply change which
                              9 ;; two borders get, and they change those calls in
                             10 ;; "checkBorderForTileMapCollision" so we can reuse the same
                             11 ;; function
                             12 
                             13 ; 7C = ld a, h
                             14 ; 7D = ld a, l
                             15 
                             16 ; 67 = ld h, a
                             17 ; 6F = ld l, a
   2E60                      18 checkLeftBorderForTilemapCollision::
   2E60 21 2F 2F      [10]   19     ld hl, #getUpperLeftCorner
   2E63 22 BD 2E      [16]   20     ld (firstCorner), hl
   2E66 21 36 2F      [10]   21     ld hl, #getLowerLeftCorner
   2E69 22 CB 2E      [16]   22     ld (secondCorner), hl
   2E6C 18 0E         [12]   23     jr set_X_Axis
                             24 
   2E6E                      25 checkRightBorderForTilemapCollision::
   2E6E 21 12 2F      [10]   26     ld hl, #getUpperRightCorner
   2E71 22 BD 2E      [16]   27     ld (firstCorner), hl
   2E74 21 1E 2F      [10]   28     ld hl, #getLowerRightCorner
   2E77 22 CB 2E      [16]   29     ld (secondCorner), hl
   2E7A 18 00         [12]   30     jr set_X_Axis
                             31 
   2E7C                      32 set_X_Axis:
   2E7C 3E 7D         [ 7]   33     ld a, #0x7D
   2E7E 32 BF 2E      [13]   34     ld (axisOneRead), a
   2E81 32 CD 2E      [13]   35     ld (axisTwoRead), a
   2E84 3E 6F         [ 7]   36     ld a, #0x6F
   2E86 32 C1 2E      [13]   37     ld (axisOneWrite), a
   2E89 32 CF 2E      [13]   38     ld (axisTwoWrite), a
   2E8C 18 2E         [12]   39     jr checkBorderForTileMapCollision
                             40 
                             41 
   2E8E                      42 checkUpperBorderForTilemapCollision::
   2E8E 21 2F 2F      [10]   43     ld hl, #getUpperLeftCorner
   2E91 22 BD 2E      [16]   44     ld (firstCorner), hl
   2E94 21 12 2F      [10]   45     ld hl, #getUpperRightCorner
   2E97 22 CB 2E      [16]   46     ld (secondCorner), hl
   2E9A 18 0E         [12]   47     jr set_Y_Axis
                             48 
   2E9C                      49 checkLowerBorderForTilemapCollision::
   2E9C 21 36 2F      [10]   50     ld hl, #getLowerLeftCorner
   2E9F 22 BD 2E      [16]   51     ld (firstCorner), hl
   2EA2 21 1E 2F      [10]   52     ld hl, #getLowerRightCorner
   2EA5 22 CB 2E      [16]   53     ld (secondCorner), hl
   2EA8 18 00         [12]   54     jr set_Y_Axis
                             55 
   2EAA                      56 set_Y_Axis:
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



   2EAA 3E 7C         [ 7]   57     ld a, #0x7C
   2EAC 32 BF 2E      [13]   58     ld (axisOneRead), a
   2EAF 32 CD 2E      [13]   59     ld (axisTwoRead), a
   2EB2 3E 67         [ 7]   60     ld a, #0x67
   2EB4 32 C1 2E      [13]   61     ld (axisOneWrite), a
   2EB7 32 CF 2E      [13]   62     ld (axisTwoWrite), a
   2EBA 18 00         [12]   63     jr checkBorderForTileMapCollision
                             64 
                             65 
   2EBC                      66 checkBorderForTileMapCollision:
                     005D    67     firstCorner = . + 1
   2EBC CD 36 2F      [17]   68     call getLowerLeftCorner
                     005F    69     axisOneRead = .
   2EBF 7C            [ 4]   70     ld a, h
   2EC0 80            [ 4]   71     add b
                     0061    72     axisOneWrite = .
   2EC1 67            [ 4]   73     ld h, a
   2EC2 C5            [11]   74     push bc
   2EC3 CD 42 2F      [17]   75     call check_colision
   2EC6 C1            [10]   76     pop bc
   2EC7 FE 01         [ 7]   77     cp #1
   2EC9 C8            [11]   78     ret z
                             79 
                     006B    80     secondCorner = . + 1
   2ECA CD 1E 2F      [17]   81     call getLowerRightCorner
                     006D    82     axisTwoRead = .
   2ECD 7C            [ 4]   83     ld a, h
   2ECE 80            [ 4]   84     add b
                     006F    85     axisTwoWrite = .
   2ECF 67            [ 4]   86     ld h, a
   2ED0 CD 42 2F      [17]   87     call check_colision
   2ED3 FE 01         [ 7]   88     cp #1
   2ED5 C8            [11]   89     ret z
                             90 
   2ED6                      91 no_colision:
   2ED6 3E 00         [ 7]   92     ld a, #0
   2ED8 C9            [10]   93 ret
                             94 
   2ED9                      95 checkEntityCollision::
                             96 
   2ED9 FD 46 01      [19]   97     ld     b, e_y(iy)
   2EDC FD 4E 00      [19]   98     ld     c, e_x(iy)
                             99 
                            100     ;; B = Coordenadas de mapa en Y, esquina superior izq del tile
                            101     ;; C = Coordenadas de mapa en X, esquina superior izq del tile
   2EDF DD 7E 00      [19]  102     ld a, b_x(ix)           ;; Cordenada X de la bala - el offset en X de la cámara
   2EE2 57            [ 4]  103     ld d, a                 ;; D = X del borde izquierdo de la bala
                            104 
   2EE3 79            [ 4]  105     ld a, c                 ;; A = X del borde izquierdo del enemigo
   2EE4 FD 86 02      [19]  106     add e_w(iy)             ;; A = X del borde derecho del enemigo
   2EE7 3D            [ 4]  107     dec a
   2EE8 BA            [ 4]  108     cp d                    ;; Comprobamos si el borde izquierdo de la bala
                            109                             ;; está a la derecha del borde derecho del enemigo
                            110 
   2EE9 30 02         [12]  111     jr nc, checkLeftBorder  ;; No lo está, comprueba la izq
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



   2EEB 18 E9         [12]  112     jr no_colision          ;; Si lo está, no hay colisión
                            113 
   2EED                     114     checkLeftBorder:
   2EED 7A            [ 4]  115         ld a, d             ;; A = X del borde izquierdo de la bala
   2EEE DD 86 02      [19]  116         add b_w(ix)         ;; A = X del borde derecho de la bala
   2EF1 3D            [ 4]  117         dec a
   2EF2 57            [ 4]  118         ld d, a             ;; D = X del borde derecho de la bala
   2EF3 79            [ 4]  119         ld a, c             ;; A = X del borde izquiedo del enemigo
                            120 
   2EF4 BA            [ 4]  121         cp d                ;; Comprobamos si el borde derecho de la bala, está
                            122                             ;; a la derecha del borde izq del enemigo
   2EF5 30 DF         [12]  123     jr nc, no_colision
                            124 
                            125     ; Hay colision en X, comprobemos en Y
   2EF7 DD 7E 01      [19]  126     ld a, b_y(ix)           ;; Coordenada Y de la bala - offset en Y de la cámara
   2EFA 57            [ 4]  127     ld d, a                 ;; D = Y del borde superior de la bala
                            128 
   2EFB 78            [ 4]  129     ld a, b                 ;; A = Y del borde superior del enemigo
   2EFC FD 86 03      [19]  130     add e_h(iy)             ;; A = Y del borde inferior del enemigo
   2EFF 3D            [ 4]  131     dec a
   2F00 BA            [ 4]  132     cp d                    ;; Compruebo si el borde superior de la bala está
                            133                             ;; por debajo del borde inferior del enemigo
                            134 
   2F01 30 02         [12]  135     jr nc, checkTopBorder   ;; No está por debajo, comprueba la parte de arriba
   2F03 18 D1         [12]  136     jr no_colision          ;; Si lo está, no hay colisión
                            137 
   2F05                     138     checkTopBorder:
   2F05 7A            [ 4]  139         ld a, d             ;; A = Y del borde superior de la bala
   2F06 DD 86 03      [19]  140         add b_h(ix)         ;; A = Y del borde inferior de la bala
   2F09 3D            [ 4]  141         dec a
   2F0A 57            [ 4]  142         ld d, a             ;; D = Y del borde inferior de la bala
   2F0B 78            [ 4]  143         ld a, b             ;; A = Y del borde superior del enemigo
                            144 
   2F0C BA            [ 4]  145         cp d                ;; Comprobamos si el borde inferior de la bala está
                            146                             ;; por encima del borde superior del enemigo
   2F0D 30 C7         [12]  147     jr nc, no_colision
   2F0F 3E 01         [ 7]  148     ld a, #1
   2F11 C9            [10]  149 ret
                            150 
   2F12                     151 getUpperRightCorner::
   2F12 DD 7E 00      [19]  152     ld a, e_x(ix)       ;; Si mi personaje está en X = 0
   2F15 DD 86 02      [19]  153         add e_w(ix)     ;; y le sumo el ancho que es 8, X = 8
   2F18 3D            [ 4]  154         dec a           ;; que es el inicio del siguiente tile
   2F19 6F            [ 4]  155     ld l, a             ;; por eso le resto 1, el border derecho
   2F1A DD 66 01      [19]  156     ld h, e_y(ix)       ;; seria 7 realmente, [0, 7]
   2F1D C9            [10]  157 ret
                            158 
   2F1E                     159 getLowerRightCorner::
   2F1E DD 7E 00      [19]  160     ld a, e_x(ix)
   2F21 DD 86 02      [19]  161         add e_w(ix)
   2F24 3D            [ 4]  162         dec a
   2F25 6F            [ 4]  163     ld l, a
   2F26 DD 7E 01      [19]  164     ld a, e_y(ix)
   2F29 DD 86 03      [19]  165         add e_h(ix)
   2F2C 3D            [ 4]  166         dec a
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 7.
Hexadecimal [16-Bits]



   2F2D 67            [ 4]  167     ld h, a
   2F2E C9            [10]  168 ret
                            169 
   2F2F                     170 getUpperLeftCorner::
   2F2F DD 6E 00      [19]  171     ld l, e_x(ix)
   2F32 DD 66 01      [19]  172     ld h, e_y(ix)
   2F35 C9            [10]  173 ret
                            174 
   2F36                     175 getLowerLeftCorner::
   2F36 DD 6E 00      [19]  176     ld l, e_x(ix)
   2F39 DD 7E 01      [19]  177     ld a, e_y(ix)
   2F3C DD 86 03      [19]  178         add e_h(ix)
   2F3F 3D            [ 4]  179         dec a
   2F40 67            [ 4]  180     ld h, a
   2F41 C9            [10]  181 ret
                            182 
   2F42                     183 check_colision::
   2F42 CD B9 32      [17]  184     call    checkTileCollision_m
   2F45 3E 01         [ 7]  185     ld a, #1
   2F47 C8            [11]  186     ret z
   2F48 3E 00         [ 7]  187     ld a, #0
   2F4A C9            [10]  188 ret
