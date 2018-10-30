ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;; File src/Compression/hud.s generated using cpct_pack
                              2 ;; Compresor used: zx7b
                              3 ;; Files compressed: [ src/Mapas/hud.bin ]
                              4 ;; Uncompressed:     500 bytes
                              5 ;; Compressed:       44 bytes
                              6 ;; Space saved:      456 bytes
                              7 ;;
                              8 ;; Data array definition
   1B36                       9 _hud::
   1B36 58 55 91 95 50 8D    10    .db  0x58, 0x55, 0x91, 0x95, 0x50, 0x8d, 0x52, 0x13, 0x43, 0x00, 0x26, 0x7c, 0x13, 0x35, 0x00, 0x57
        52 13 43 00 26 7C
        13 35 00 57
   1B46 13 57 11 00 4C 10    11    .db  0x13, 0x57, 0x11, 0x00, 0x4c, 0x10, 0x13, 0xb5, 0x00, 0x00, 0x42, 0x03, 0x02, 0x13, 0x19, 0x09
        13 B5 00 00 42 03
        02 13 19 09
   1B56 44 08 09 00 84 10    12    .db  0x44, 0x08, 0x09, 0x00, 0x84, 0x10, 0x01, 0x08, 0x00, 0x5a, 0x82, 0x0e
        01 08 00 5A 82 0E
                             13 ;; Address of the latest byte of the compressed array (for unpacking purposes)
                     002B    14 _hud_end == . - 1
                             15 
