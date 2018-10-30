ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;; File src/Compression/hud.h.s generated using cpct_pack
                              2 ;; Compresor used:   zx7b
                              3 ;; Files compressed: [ src/Mapas/hud.bin ]
                              4 ;; Uncompressed:     500 bytes
                              5 ;; Compressed:       44 bytes
                              6 ;; Space saved:      456 bytes
                              7 ;;
                              8 
                              9 ;; Declaration of the compressed array and
                             10 ;; the address of the latest byte of the compressed array (for unpacking purposes)
                             11 .globl _hud
                             12 .globl _hud_end
                             13 
                             14 ;; Compressed and uncompressed sizes
                     002C    15 _hud_size_z = 44
                     01F4    16 _hud_size   = 500
                             17 
                             18 
