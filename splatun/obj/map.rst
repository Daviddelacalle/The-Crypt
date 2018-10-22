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
                            139 
                     0001   140       en_x = 0         en_y = 1
                     0003   141       en_w = 2         en_h = 3
                     0005   142      en_vx = 4        en_vy = 5
                     0006   143     en_col = 6
                     0008   144    en_up_l = 7      en_up_h = 8
                     0009   145  en_g_flag = 9
                            146  ;;------------------------------BRESENHAM
                     000B   147     en_g_x = 10      en_g_y = 11
                     000D   148    en_dX_l = 12     en_dX_h = 13
                     000F   149    en_dY_l = 14     en_dY_h = 15
                     0011   150   en_incYr = 16    en_incXr = 17
                     0013   151    en_av_l = 18     en_av_h = 19
                     0015   152   en_avR_l = 20    en_avR_h = 21
                     0017   153   en_avI_l = 22    en_avI_h = 23
                     0018   154 en_flagVel = 24
                            155 
                            156 
                            157 
                            158 
                            159 
                            160 
                            161 
                            162 
                            163 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



                              5 
   3DDC 00 00                 6 cam_min::       .db #0, #0
   3DDE 10 10                 7 cam_max::       .db #16, #16
   3DE0 00 00                 8 CoordMapMin::   .db #0, #0
                              9 
   3DE2 00                   10 CameraTargetX:: .db #0
   3DE3 00                   11 CameraTargetY:: .db #0
                             12 
   3DE4 40 00                13 map_ptr:    .dw #decompress_buffer
                             14 
                             15 ;========================================================================;
                             16 ;   Inreases ptr for the map
                             17 ;   Input:  DE => Incremento del mapa
                             18 ;            B => Incremento de cam_min/max
                             19 ;            C => Incremento de CameraMinX/Y en coordenadas de mapa
                             20 ;           HL => Puntero a CameraMinX/Y
                             21 ;========================================================================;
   3DE6                      22 inc_map::
   3DE6 7E            [ 7]   23     ld a, (hl)              ;; Cargo en a cam_min o cam_max,
                             24                             ;; depende de lo que me hayan pasado
   3DE7 80            [ 4]   25     add b                   ;; Le añado B, que será 1 o -1
   3DE8 77            [ 7]   26     ld (hl), a              ;; Lo guardo
   3DE9 23            [ 6]   27     inc hl
   3DEA 23            [ 6]   28     inc hl                  ;; Aumento 2 veces el puntero para llegar al max
   3DEB 7E            [ 7]   29     ld a, (hl)              ;; Hago lo mismo
   3DEC 80            [ 4]   30     add b
   3DED 77            [ 7]   31     ld (hl), a              ;; Incremento el min de la camara
                             32 
   3DEE 23            [ 6]   33     inc hl                  ;; Vuelvo a aumentar 2 para llegar al
   3DEF 23            [ 6]   34     inc hl                  ;; minimo en coordenadas de mapa, no de tile
   3DF0 7E            [ 7]   35     ld a, (hl)              ;; A = CoordManMin
   3DF1 81            [ 4]   36     add c                   ;; A += C, donde C será 4 o -4 en X, 8 o -8 en Y
   3DF2 77            [ 7]   37     ld (hl), a
                             38 
   3DF3 2A E4 3D      [16]   39     ld hl, (map_ptr)        ;; Cambio el puntero del mapa
   3DF6 19            [11]   40     add hl, de              ;; sumándole lo que le hay pasado en DE
   3DF7 22 E4 3D      [16]   41     ld (map_ptr), hl
                             42 
   3DFA C9            [10]   43 ret
                             44 
   3DFB                      45 setTargetX::
   3DFB 3A E2 3D      [13]   46     ld a, (#CameraTargetX)
   3DFE 80            [ 4]   47     add b
   3DFF 32 E2 3D      [13]   48     ld (#CameraTargetX), a
   3E02 C9            [10]   49 ret
                             50 
   3E03                      51 setTargetY::
   3E03 3A E3 3D      [13]   52     ld a, (#CameraTargetY)
   3E06 80            [ 4]   53     add b
   3E07 32 E3 3D      [13]   54     ld (#CameraTargetY), a
   3E0A C9            [10]   55 ret
                             56 
                             57 ;========================================================================;
                             58 ;   Comprueba si la cámara debe hacer scroll y cambia las variables
                             59 ;   de mínimos y máximos automáticamente
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



                             60 ;   Destroys: A, BC, DE, HL
                             61 ;========================================================================;
   3E0B                      62 update_cam::
   3E0B 3A E2 3D      [13]   63     ld a, (#CameraTargetX)
   3E0E FE 00         [ 7]   64     cp #0                   ;; Hay algún target para la cámara?
   3E10 28 41         [12]   65     jr z, noTargetX
                             66         ;; Tenemos target en X
   3E12 FE F0         [ 7]   67         cp #0xF0            ;; Compruebo si el target es negativo
   3E14 3A DC 3D      [13]   68         ld a, (cam_min)     ;; Cargo el camera min ahora, porque
                             69                             ;; lo voy a tener que cargar igualmente
                             70                             ;; tanto si es positivo como negativo
   3E17 38 1B         [12]   71         jr c, is_positive_x
                             72             ;; Negativo
                             73             ;; Comprueba que no se salga del mapa
   3E19 FE 00         [ 7]   74                 cp #0
   3E1B 20 07         [12]   75                 jr nz, not_on_limit_left
   3E1D 06 00         [ 7]   76                 ld b, #0            ;; Se sale del mapa! Pon el target a 0
   3E1F CD FB 3D      [17]   77                 call setTargetX
   3E22 18 2F         [12]   78                 jr noTargetX        ;; Y no hagas nada más, ve a comprobar Y
   3E24                      79             not_on_limit_left:
                             80             ;; No nos salimos del mapa al aumentar! ʕ ͡° ͜ʖ ͡°ʔ
   3E24 06 FF         [ 7]   81             ld b, #-1               ;;  B aumentará cam_min/max
   3E26 0E FC         [ 7]   82             ld c, #-4               ;;  C aumentará CoordMapMin
   3E28 11 FF FF      [10]   83             ld de, #-1              ;; DE aumentará el puntero del mapa
   3E2B 3A E2 3D      [13]   84             ld a, (CameraTargetX)   ;; Como estamos en target negativo
   3E2E 3C            [ 4]   85             inc a                   ;; Le sumo uno para ir llevándolo a 0
   3E2F 32 E2 3D      [13]   86             ld (CameraTargetX), a
   3E32 18 19         [12]   87             jr update_x
   3E34                      88         is_positive_x:
                             89             ;; Positivo
                             90             ;; Comprueba que no se salga del mapa
   3E34 FE 0E         [ 7]   91                 cp #LimitRight
   3E36 20 07         [12]   92                 jr nz, not_on_limit_right
   3E38 06 00         [ 7]   93                 ld b, #0            ;; Se sale del mapa! Pon el target a 0
   3E3A CD FB 3D      [17]   94                 call setTargetX
   3E3D 18 14         [12]   95                 jr noTargetX
                             96 
   3E3F                      97             not_on_limit_right:
                             98             ;; Mismo de antes pero en positivo
   3E3F 06 01         [ 7]   99             ld b, #1
   3E41 0E 04         [ 7]  100             ld c, #4
   3E43 11 01 00      [10]  101             ld de, #1
   3E46 3A E2 3D      [13]  102             ld a, (CameraTargetX)
   3E49 3D            [ 4]  103             dec a           ;; Ahora es positivo, resto para llevarlo a 0
   3E4A 32 E2 3D      [13]  104             ld (CameraTargetX), a
   3E4D                     105         update_x:
   3E4D 21 DC 3D      [10]  106         ld hl, #cam_min     ;; Cargo en hl cam_min, que es la que tiene la X
   3E50 CD E6 3D      [17]  107         call inc_map
                            108 
                            109     ;; Repetimos el mismo proceso para Y
   3E53                     110     noTargetX:
   3E53 3A E3 3D      [13]  111     ld a, (CameraTargetY)
   3E56 FE 00         [ 7]  112     cp #0
   3E58 C8            [11]  113     ret z
                            114         ;; Tenemos target en Y
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 7.
Hexadecimal [16-Bits]



                            115         ;; Comprueba que no se salga del mapa
   3E59 FE F0         [ 7]  116         cp #0xF0
   3E5B 3A DD 3D      [13]  117         ld a, (cam_min+1)
   3E5E 38 1A         [12]  118         jr c, is_positive_y
                            119             ;; Negativo
                            120             ;; Comprueba que no se salga del mapa
   3E60 FE 00         [ 7]  121                 cp #0
   3E62 20 06         [12]  122                 jr nz, not_on_limit_up
   3E64 06 00         [ 7]  123                 ld b, #0            ;; Se sale del mapa! Pon el target a 0
   3E66 CD 03 3E      [17]  124                 call setTargetY
   3E69 C9            [10]  125                 ret
   3E6A                     126             not_on_limit_up:
   3E6A 06 FF         [ 7]  127             ld b, #-1      ;;AAAAAAAAAAAAAAAAAAAAAAAAAAA
   3E6C 0E F8         [ 7]  128             ld c, #-8
   3E6E 11 E2 FF      [10]  129             ld de, #-30
   3E71 3A E3 3D      [13]  130             ld a, (CameraTargetY)
   3E74 3C            [ 4]  131             inc a
   3E75 32 E3 3D      [13]  132             ld (CameraTargetY), a
   3E78 18 18         [12]  133             jr update_y
   3E7A                     134         is_positive_y:
                            135             ;; Positivo
                            136             ;; Comprueba que no se salga del mapa
   3E7A FE 0E         [ 7]  137                 cp #LimitDown
   3E7C 20 06         [12]  138                 jr nz, not_on_limit_down
   3E7E 06 00         [ 7]  139                 ld b, #0            ;; Se sale del mapa! Pon el target a 0
   3E80 CD 03 3E      [17]  140                 call setTargetY
   3E83 C9            [10]  141                 ret
                            142 
   3E84                     143             not_on_limit_down:
   3E84 11 1E 00      [10]  144             ld de, #30
   3E87 06 01         [ 7]  145             ld b, #1       ;;AAAAAAAAAAAAAAAAAAAAAAAAAAA
   3E89 0E 08         [ 7]  146             ld c, #8
   3E8B 3A E3 3D      [13]  147             ld a, (CameraTargetY)
   3E8E 3D            [ 4]  148             dec a
   3E8F 32 E3 3D      [13]  149             ld (CameraTargetY), a
   3E92                     150         update_y:
   3E92 21 DD 3D      [10]  151         ld hl, #cam_min+1   ;; Ahora le paso la Y
   3E95 CD E6 3D      [17]  152         call inc_map
   3E98 C9            [10]  153 ret
                            154 
                            155 ;========================================================================;
                            156 ;   Draws the complete map.in.include "drawable.h.s"clude "drawable.h.s"
                            157 ;========================================================================;
   3E99                     158 drawMap::
   3E99 3A 1B 39      [13]  159     ld a, (back_buffer)                  ;; Apunta al inicio de la memoria de video
   3E9C 3C            [ 4]  160     inc a
   3E9D 67            [ 4]  161     ld h, a
   3E9E 2E 48         [ 7]  162     ld l, #0x48
   3EA0 ED 5B E4 3D   [20]  163     ld de, (map_ptr)
   3EA4 CD 68 3F      [17]  164     call cpct_etm_drawTilemap4x8_ag_asm
   3EA7 C9            [10]  165 ret
