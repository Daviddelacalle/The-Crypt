ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                              2 ;; DEFINICION DE LAS MACROS PARA LA CREACION DE ENTIDADES ;;
                              3 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                              4 
                              5 ;; Entidad drawable
                              6 .macro DefineDrawableEnt _name, _x, _y, _w, _h
                              7 _name:
                              8    .db   #0, #0
                              9    .db   #0, #0
                             10    .db   _x, _y      ;; Posicion    (x,y)
                             11    .db   _w, _h      ;; Dimensiones (w,h)
                             12 .endm
                             13 
                             14 ;; Entidad movable
                             15 .macro DefineMovableEnt _name, _vx, _vy
                             16 _name:
                             17    .db   _vx, _vy    ;; Variables de la velocidad
                             18 .endm
                             19 
                             20 ;; Entidad por defecto
                             21 .macro DefineEntityDefault _name, _suf
                             22    DefineEntity _name'_suf, 0xAA, 0, 0, 0, 0, 0, 0, 0xFFFF           ;;'
                             23 .endm
                             24 
                             25 ;; Definir N entidades
                             26 .macro DefineNEntities _name, _n
                             27    _c = 0
                             28    .rept _n
                             29       DefineEntityDefault _name, \_c
                             30       _c = _c + 1
                             31    .endm
                             32 .endm
                             33 
                             34 ;; Entidad heroe/enemigo
                             35 .macro DefineEntity  _name, _x, _y, _w, _h, _vx, _vy, _col, _upd
                             36 _name:
                             37    DefineDrawableEnt _name'_dw, _x, _y, _w, _h                       ;;'
                             38    DefineMovableEnt  _name'_mv, _vx, _vy                             ;;'
                             39 ;; Si no tiene sprite
                             40    .db   _col        ;; Color
                             41 ;; Si tiene sprite
                             42 ;;.dw   _spr
                             43    .dw   _upd        ;; Puntero a la funcion de update
                             44 
                             45 ;; Aqui falta saber el tamanyo de la entidad
                             46 e_size = . - (_name)
                             47 .endm
                             48 
                             49 ;;;;;;;;;;;;;;;;;;;
                             50 ;; Constantes de las entidades hero/enemy
                             51 ;;;;;;;;;;;;;;;;;;;
                     0001    52  ppe_x = 0    ppe_y = 1
                     0003    53   pe_x = 2     pe_y = 3
                     0005    54    e_x = 0+4      e_y = 1+4
                     0007    55    e_w = 2+4      e_h = 3+4
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                     0009    56   e_vx = 4+4     e_vy = 5+4
                     000A    57  e_col = 6+4
                     000C    58 e_up_l = 7+4   e_up_h = 8+4
                             59 
                             60 ;;-----------------------------------------------------------------------------------------;;
                             61 ;; Entidad bullet
                             62 .macro DefineBullet  _name, _x, _y, _w, _h, _vx, _vy, _col, _alive, _upd
                             63 _name:
                             64    DefineDrawableEnt _name'_dw, _x, _y, _w, _h                       ;;'
                             65    DefineMovableEnt  _name'_mv, _vx, _vy                             ;;'
                             66    .db   _col        ;; Color / Sprite (cuando haya)
                             67    .db   _alive      ;; _alive>0? Se actualiza/dibuja
                             68    .dw   _upd        ;; Funcion de update
                             69 
                             70 ;; Saber tamanyo de entidad bala
                             71 .endm
                             72 
                             73 ;; Entidad por defecto de bullet
                             74 .macro DefineBulletDefault _name, _suf
                             75    DefineBullet _name'_suf, 0xAA, 0, 0, 0, 0, 0, 0, 0, 0xFFFF        ;;'
                             76 .endm
                             77 
                             78 ;; Bucle de crear entidades bullet
                             79 .macro DefineNBullets _name, _n
                             80    _c = 0
                             81    .rept _n
                             82       DefineBulletDefault _name, \_c
                             83       _c = _c + 1
                             84    .endm
                             85 .endm
                             86 
                             87 ;;;;;;;;;;;;;;;;;;;
                             88 ;; Constantes de las entidades bullet
                             89 ;;;;;;;;;;;;;;;;;;;
                     0005    90     b_x = 0+4      b_y = 1+4
                     0007    91     b_w = 2+4      b_h = 3+4
                     0009    92    b_vx = 4+4     b_vy = 5+4
                     000B    93   b_col = 6+4  b_alive = 7+4
                     000D    94  b_up_l = 8+4   b_up_h = 9+4
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
                            105 
                            106 
                            107 
                            108 
