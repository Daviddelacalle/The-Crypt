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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



                              5 
   336F 00 00                 6 cam_min::       .db #0, #0
   3371 00 00                 7 CoordMapMin::   .db #0, #0
                              8 
   3373 00                    9 CameraTargetX:: .db #0
   3374 00                   10 CameraTargetY:: .db #0
                             11 
   3375 DB 01                12 map_ptr:    .dw #decompress_buffer
                             13 
                     03CE    14 HUD_END_DECOMPRESSED = 499 + 0x1DB
                             15 ;========================================================================;
                             16 ;   Inreases ptr for the map
                             17 ;   Input:  DE => Incremento del mapa
                             18 ;            B => Incremento de cam_min/max
                             19 ;            C => Incremento de CameraMinX/Y en coordenadas de mapa
                             20 ;           HL => Puntero a CameraMinX/Y
                             21 ;========================================================================;
   3377                      22 inc_map::
   3377 7E            [ 7]   23     ld a, (hl)              ;; Cargo en a cam_min o cam_max,
                             24                             ;; depende de lo que me hayan pasado
   3378 80            [ 4]   25     add b                   ;; Le añado B, que será 1 o -1
   3379 77            [ 7]   26     ld (hl), a              ;; Lo guardo
   337A 23            [ 6]   27     inc hl                  ;; Aumento 2 veces el puntero para llegar al
   337B 23            [ 6]   28     inc hl                  ;; minimo en coordenadas de mapa, no de tile
   337C 7E            [ 7]   29     ld a, (hl)              ;; A = CoordManMin
   337D 81            [ 4]   30     add c                   ;; A += C, donde C será 4 o -4 en X, 8 o -8 en Y
   337E 77            [ 7]   31     ld (hl), a
                             32 
   337F 2A 75 33      [16]   33     ld hl, (map_ptr)        ;; Cambio el puntero del mapa
   3382 19            [11]   34     add hl, de              ;; sumándole lo que le hay pasado en DE
   3383 22 75 33      [16]   35     ld (map_ptr), hl
                             36 
   3386 C9            [10]   37 ret
                             38 
                             39 ;;============================================
                             40 ;;  Calculate camera offset from hero position
                             41 ;;  DESTROYS:   A, BC, HL, DE
                             42 ;;============================================
   3387                      43 recalculateCameraOffset::
   3387 21 DB 01      [10]   44     ld hl, #decompress_buffer
   338A 11 1E 00      [10]   45     ld de, #30
                             46 
   338D DD 7E 00      [19]   47     ld a, e_x(ix)
   3390 D6 20         [ 7]   48     sub #32
   3392 38 17         [12]   49     jr c, setCamMinXToZero
   3394 28 15         [12]   50     jr z, setCamMinXToZero
   3396 47            [ 4]   51     ld b, a
   3397 3E 00         [ 7]   52     ld a, #0        ;; CoordMapMin
   3399 0E 00         [ 7]   53     ld c, #0        ;; cam_min
   339B                      54     X_iterator:
   339B 0C            [ 4]   55         inc c
   339C C6 04         [ 7]   56         add #4
   339E 23            [ 6]   57         inc hl
   339F B8            [ 4]   58         cp b
   33A0 38 F9         [12]   59     jr c, X_iterator
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



   33A2 32 71 33      [13]   60         ld (CoordMapMin), a
   33A5 79            [ 4]   61         ld a, c
   33A6 32 6F 33      [13]   62         ld (cam_min), a
   33A9 18 08         [12]   63     jr calculate_y
   33AB                      64     setCamMinXToZero:
   33AB 3E 00         [ 7]   65         ld a, #0
   33AD 32 71 33      [13]   66         ld (CoordMapMin), a
   33B0 32 6F 33      [13]   67         ld (cam_min), a
                             68 
   33B3                      69     calculate_y:
   33B3 DD 7E 01      [19]   70     ld a, e_y(ix)
   33B6 D6 40         [ 7]   71     sub #64
   33B8 38 17         [12]   72     jr c, setCamMinYToZero
   33BA 28 15         [12]   73     jr z, setCamMinYToZero
   33BC 47            [ 4]   74     ld b, a
   33BD 3E 00         [ 7]   75     ld a, #0        ;; CoordMapMin
   33BF 0E 00         [ 7]   76     ld c, #0        ;; cam_min
   33C1                      77     Y_iterator:
   33C1 0C            [ 4]   78         inc c
   33C2 C6 08         [ 7]   79         add #8
   33C4 19            [11]   80         add hl, de
   33C5 B8            [ 4]   81         cp b
   33C6 38 F9         [12]   82     jr c, Y_iterator
   33C8 32 72 33      [13]   83         ld (CoordMapMin+1), a
   33CB 79            [ 4]   84         ld a, c
   33CC 32 70 33      [13]   85         ld (cam_min+1), a
   33CF 18 08         [12]   86     jr finish
   33D1                      87     setCamMinYToZero:
   33D1 3E 00         [ 7]   88         ld a, #0
   33D3 32 72 33      [13]   89         ld (CoordMapMin+1), a
   33D6 32 70 33      [13]   90         ld (cam_min+1), a
   33D9                      91     finish:
   33D9 22 75 33      [16]   92     ld (map_ptr), hl
                             93 
   33DC 3E 00         [ 7]   94     ld a, #0
   33DE 32 73 33      [13]   95     ld (CameraTargetX), a
   33E1 32 74 33      [13]   96     ld (CameraTargetY), a
   33E4 C9            [10]   97 ret
                             98 
                             99 ;;  ENTRADA:    B -> Incremento molon de camara
   33E5                     100 setTargetX::
   33E5 3A 73 33      [13]  101     ld a, (#CameraTargetX)
   33E8 80            [ 4]  102     add b
   33E9 32 73 33      [13]  103     ld (#CameraTargetX), a
   33EC C9            [10]  104 ret
                            105 
                            106 ;;  ENTRADA:    B -> Incremento molon de camara
   33ED                     107 setTargetY::
   33ED 3A 74 33      [13]  108     ld a, (#CameraTargetY)
   33F0 80            [ 4]  109     add b
   33F1 32 74 33      [13]  110     ld (#CameraTargetY), a
   33F4 C9            [10]  111 ret
                            112 
                            113 ;========================================================================;
                            114 ;   Comprueba si la cámara debe hacer scroll y cambia las variables
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 7.
Hexadecimal [16-Bits]



                            115 ;   de mínimos y máximos automáticamente
                            116 ;   Destroys: A, BC, DE, HL
                            117 ;========================================================================;
   33F5                     118 update_cam::
   33F5 3A 73 33      [13]  119     ld a, (#CameraTargetX)
   33F8 FE 00         [ 7]  120     cp #0                   ;; Hay algún target para la cámara?
   33FA 28 41         [12]  121     jr z, noTargetX
                            122         ;; Tenemos target en X
   33FC FE F0         [ 7]  123         cp #0xF0            ;; Compruebo si el target es negativo
   33FE 3A 6F 33      [13]  124         ld a, (cam_min)     ;; Cargo el camera min ahora, porque
                            125                             ;; lo voy a tener que cargar igualmente
                            126                             ;; tanto si es positivo como negativo
   3401 38 1B         [12]  127         jr c, is_positive_x
                            128             ;; Negativo
                            129             ;; Comprueba que no se salga del mapa
   3403 FE 00         [ 7]  130                 cp #0
   3405 20 07         [12]  131                 jr nz, not_on_limit_left
   3407 06 00         [ 7]  132                 ld b, #0            ;; Se sale del mapa! Pon el target a 0
   3409 CD E5 33      [17]  133                 call setTargetX
   340C 18 2F         [12]  134                 jr noTargetX        ;; Y no hagas nada más, ve a comprobar Y
   340E                     135             not_on_limit_left:
                            136             ;; No nos salimos del mapa al aumentar! ʕ ͡° ͜ʖ ͡°ʔ
   340E 06 FF         [ 7]  137             ld b, #-1               ;;  B aumentará cam_min/max
   3410 0E FC         [ 7]  138             ld c, #-4               ;;  C aumentará CoordMapMin
   3412 11 FF FF      [10]  139             ld de, #-1              ;; DE aumentará el puntero del mapa
   3415 3A 73 33      [13]  140             ld a, (CameraTargetX)   ;; Como estamos en target negativo
   3418 3C            [ 4]  141             inc a                   ;; Le sumo uno para ir llevándolo a 0
   3419 32 73 33      [13]  142             ld (CameraTargetX), a
   341C 18 19         [12]  143             jr update_x
   341E                     144         is_positive_x:
                            145             ;; Positivo
                            146             ;; Comprueba que no se salga del mapa
   341E FE 0E         [ 7]  147                 cp #LimitRight
   3420 20 07         [12]  148                 jr nz, not_on_limit_right
   3422 06 00         [ 7]  149                 ld b, #0            ;; Se sale del mapa! Pon el target a 0
   3424 CD E5 33      [17]  150                 call setTargetX
   3427 18 14         [12]  151                 jr noTargetX
                            152 
   3429                     153             not_on_limit_right:
                            154             ;; Mismo de antes pero en positivo
   3429 06 01         [ 7]  155             ld b, #1
   342B 0E 04         [ 7]  156             ld c, #4
   342D 11 01 00      [10]  157             ld de, #1
   3430 3A 73 33      [13]  158             ld a, (CameraTargetX)
   3433 3D            [ 4]  159             dec a           ;; Ahora es positivo, resto para llevarlo a 0
   3434 32 73 33      [13]  160             ld (CameraTargetX), a
   3437                     161         update_x:
   3437 21 6F 33      [10]  162         ld hl, #cam_min     ;; Cargo en hl cam_min, que es la que tiene la X
   343A CD 77 33      [17]  163         call inc_map
                            164 
                            165     ;; Repetimos el mismo proceso para Y
   343D                     166     noTargetX:
   343D 3A 74 33      [13]  167     ld a, (CameraTargetY)
   3440 FE 00         [ 7]  168     cp #0
   3442 C8            [11]  169     ret z
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 8.
Hexadecimal [16-Bits]



                            170         ;; Tenemos target en Y
                            171         ;; Comprueba que no se salga del mapa
   3443 FE F0         [ 7]  172         cp #0xF0
   3445 3A 70 33      [13]  173         ld a, (cam_min+1)
   3448 38 1A         [12]  174         jr c, is_positive_y
                            175             ;; Negativo
                            176             ;; Comprueba que no se salga del mapa
   344A FE 00         [ 7]  177                 cp #0
   344C 20 06         [12]  178                 jr nz, not_on_limit_up
   344E 06 00         [ 7]  179                 ld b, #0            ;; Se sale del mapa! Pon el target a 0
   3450 CD ED 33      [17]  180                 call setTargetY
   3453 C9            [10]  181                 ret
   3454                     182             not_on_limit_up:
   3454 06 FF         [ 7]  183             ld b, #-1      ;;AAAAAAAAAAAAAAAAAAAAAAAAAAA
   3456 0E F8         [ 7]  184             ld c, #-8
   3458 11 E2 FF      [10]  185             ld de, #-30
   345B 3A 74 33      [13]  186             ld a, (CameraTargetY)
   345E 3C            [ 4]  187             inc a
   345F 32 74 33      [13]  188             ld (CameraTargetY), a
   3462 18 18         [12]  189             jr update_y
   3464                     190         is_positive_y:
                            191             ;; Positivo
                            192             ;; Comprueba que no se salga del mapa
   3464 FE 0E         [ 7]  193                 cp #LimitDown
   3466 20 06         [12]  194                 jr nz, not_on_limit_down
   3468 06 00         [ 7]  195                 ld b, #0            ;; Se sale del mapa! Pon el target a 0
   346A CD ED 33      [17]  196                 call setTargetY
   346D C9            [10]  197                 ret
                            198 
   346E                     199             not_on_limit_down:
   346E 11 1E 00      [10]  200             ld de, #30
   3471 06 01         [ 7]  201             ld b, #1       ;;AAAAAAAAAAAAAAAAAAAAAAAAAAA
   3473 0E 08         [ 7]  202             ld c, #8
   3475 3A 74 33      [13]  203             ld a, (CameraTargetY)
   3478 3D            [ 4]  204             dec a
   3479 32 74 33      [13]  205             ld (CameraTargetY), a
   347C                     206         update_y:
   347C 21 70 33      [10]  207         ld hl, #cam_min+1   ;; Ahora le paso la Y
   347F CD 77 33      [17]  208         call inc_map
   3482 C9            [10]  209 ret
                            210 
   3483                     211 openTeleporter::
                            212 
   3483 C9            [10]  213 ret
                            214 
                            215 ;========================================================================;
                            216 ;   Draws the complete map.in.include "drawable.h.s"clude "drawable.h.s"
                            217 ;========================================================================;
   3484                     218 drawMap::
   3484 3A EB 2A      [13]  219     ld a, (back_buffer)                  ;; Apunta al inicio de la memoria de video
   3487 3C            [ 4]  220     inc a
   3488 67            [ 4]  221     ld h, a
   3489 2E 48         [ 7]  222     ld l, #0x48
   348B ED 5B 75 33   [20]  223     ld de, (map_ptr)
   348F CD C7 3D      [17]  224     call cpct_etm_drawTilemap4x8_ag_asm
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 9.
Hexadecimal [16-Bits]



   3492 C9            [10]  225 ret
                            226 
                            227 ;; DIBUJADO DEL HUD
   3493                     228 drawHud::
   3493 21 F7 08      [10]  229     ld hl, #_g_00
   3496 0E 14         [ 7]  230     ld c, #20        ;; Ancho en tiles -> 20*8 = 160
   3498 06 19         [ 7]  231     ld b, #25        ;; Alto en tiles  -> 25*8 = 200
   349A 11 14 00      [10]  232     ld de, #20
   349D CD 38 3F      [17]  233     call cpct_etm_setDrawTilemap4x8_ag_asm
                            234 
                            235     ;; DECRUNCH
   34A0 11 CE 03      [10]  236     ld de, #HUD_END_DECOMPRESSED
   34A3 21 61 1B      [10]  237     ld hl, #_hud_end
   34A6 CD 8D 3E      [17]  238     call cpct_zx7b_decrunch_s_asm
                            239 
   34A9 3A EB 2A      [13]  240     ld a, (back_buffer)
   34AC 67            [ 4]  241     ld h, a
   34AD 2E 00         [ 7]  242     ld l, #0
   34AF 11 DB 01      [10]  243     ld de, #decompress_buffer
   34B2 CD C7 3D      [17]  244     call cpct_etm_drawTilemap4x8_ag_asm
   34B5 C9            [10]  245 ret
