ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                              2 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                              3 ;; ENTIDAD HEROE
                              4 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                              5 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                              6 
                              7 .area _DATA
                              8 .area _CODE
                              9 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                             10 .include "cpctelera.h.s"
                              1 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                              2 ;; Cabecera con funciones de cpctelera ;;
                              3 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                              4 
                              5 .globl cpct_getScreenPtr_asm
                              6 .globl cpct_drawSolidBox_asm
                              7 .globl cpct_disableFirmware_asm
                              8 .globl cpct_setVideoMode_asm
                              9 .globl cpct_waitVSYNC_asm
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



                             11 .include "struct.h.s"
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
Hexadecimal [16-Bits]



                             12 
                             13 .globl dw_draw
                             14 
                             15 ;;======================================================================
                             16 ;;======================================================================
                             17 ;; DATOS PRIVADOS
                             18 ;;======================================================================
                             19 ;;======================================================================
   4000                      20 DefineEntity hero, 0x28, 0x66, 0x04, 0x10, 0x00, 0x00, 0x0F, 0x0000
   4000                       1 hero:
   0000                       2    DefineDrawableEnt hero_dw, 0x28, 0x66, 0x04, 0x10                    ;;'
   0000                       1 hero_dw:
   4000 28 66                 2    .db   0x28, 0x66      ;; Posicion    (x,y)
   4002 04 10                 3    .db   0x04, 0x10      ;; Dimensiones (w,h)
                              4 
                              5 ;; Aqui falta saber el tamanyo de la entidad
   4004 00 00                 3    .db   0x00, 0x00    ;; Variables de la velocidad
                              4 ;; Si no tiene sprite
   4006 0F                    5    .db   0x0F        ;; Color
                              6 ;; Si tiene sprite
                              7 ;;.dw   _spr
   4007 00 00                 8    .dw   0x0000        ;; Puntero a la funcion de update
                              9 
                             10 ;; Aqui falta saber el tamanyo de la entidad
                             21 
                             22 ;;======================================================================
                             23 ;;======================================================================
                             24 ;; FUNCIONES PUBLICAS
                             25 ;;======================================================================
                             26 ;;======================================================================
   4009                      27 hero_draw::
   4009 DD 21 00 40   [14]   28    ld    ix,   #hero    ;; ix apunta a los datos del heroe
   400D C3 10 40      [10]   29    jp dw_draw           ;; Llamo al draw de drawable
                             30 
                             31 ;;======================================================================
                             32 ;;======================================================================
                             33 ;; FUNCIONES PRIVADAS
                             34 ;;======================================================================
                             35 ;;======================================================================
                             36 
                             37 
                             38 
                             39 
                             40 
                             41 
                             42 
                             43 
                             44 
                             45 
                             46 
