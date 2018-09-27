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
                             10 
                             11 ;; Aqui falta saber el tamanyo de la entidad
                             12 .endm
                             13 
                             14 ;; Entidad movable
                             15 .macro DefineMovableEnt _name, _vx, _vy
                             16 _name:
                             17    .db   _vx, _vy    ;; Variables de la velocidad
                             18 .endm
                             19 
                             20 ;; Entidad heroe/enemigo
                             21 .macro DefineEntity _name, _x, _y, _w, _h, _vx, _vy, _col, _upd
                             22 _name:
                             23    DefineDrawableEnt _name'_dw, _x, _y, _w, _h                    ;;'
                             24    DefineMovableEnt _name'mv, _vx, _vy                            ;;'
                             25 ;; Si no tiene sprite
                             26    .db   _col        ;; Color
                             27 ;; Si tiene sprite
                             28 ;;.dw   _spr
                             29    .dw   _upd        ;; Puntero a la funcion de update
                             30 
                             31 ;; Aqui falta saber el tamanyo de la entidad
                             32 .endm
                             33 
                             34 ;;;;;;;;;;;;;;;;;;;
                             35 ;; Constantes
                             36 ;;;;;;;;;;;;;;;;;;;
                     0001    37    _x = 0      _y = 1
                     0003    38    _w = 2      _h = 3
                     0005    39   _vx = 4     _vy = 5
                     0006    40  _col = 6
                     0008    41 _up_l = 7   _up_h = 8
