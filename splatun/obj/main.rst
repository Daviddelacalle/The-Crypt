ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 .area _DATA
                              2 .area _CODE
                              3 
                              4 ;;====================================
                              5 ;; INCLUDES
                              6 ;;====================================
                              7 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                              8 .include "cpctelera.h.s"
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



                              9 .include "hero.h.s"
                              1 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                              2 ;; Cabecera con funciones de hero ;;
                              3 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                              4 
                              5 .globl hero_draw
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
Hexadecimal [16-Bits]



                             10 
                             11 ;; Punto de entrada de la funcion main
   402A                      12 _main::
                             13    ;; Deshabilitar el firmware
   402A CD 4F 40      [17]   14    call cpct_disableFirmware_asm
                             15 
                             16    ;; Cambiar el VideoMode a 0
   402D 0E 00         [ 7]   17    ld    c, #0
   402F CD 3A 40      [17]   18    call cpct_setVideoMode_asm
                             19 
                             20 ;; Comienza el bucle del juego
   4032                      21 loop:
   4032 CD 09 40      [17]   22    call hero_draw
                             23 
   4035 CD 47 40      [17]   24    call cpct_waitVSYNC_asm
   4038 18 F8         [12]   25 jr loop
