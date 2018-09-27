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
                             14 ;; Entidad heroe/enemigo
                             15 .macro DefineEntity _name, _x, _y, _w, _h, _vx, _vy, _col, _upd
                             16 _name:
                             17    DefineDrawableEnt _name'_dw, _x, _y, _w, _h                    ;;'
                             18    .db   _vx, _vy    ;; Variables de la velocidad
                             19 ;; Si no tiene sprite
                             20    .db   _col        ;; Color
                             21 ;; Si tiene sprite
                             22 ;;.dw   _spr
                             23    .dw   _upd        ;; Puntero a la funcion de update
                             24 
                             25 ;; Aqui falta saber el tamanyo de la entidad
                             26 .endm
                             27 
                             28 ;;;;;;;;;;;;;;;;;;;
                             29 ;; Constantes
                             30 ;;;;;;;;;;;;;;;;;;;
                     0001    31    _x = 0      _y = 1
                     0003    32    _w = 2      _h = 3
                     0005    33   _vx = 4     _vy = 5
                     0006    34  _col = 6
                     0008    35 _up_l = 7   _up_h = 8
