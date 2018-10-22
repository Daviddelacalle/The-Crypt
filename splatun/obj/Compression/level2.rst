ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;; File src/Compression/level2.s generated using cpct_pack
                              2 ;; Compresor used: zx7b
                              3 ;; Files compressed: [ src/Mapas/Level2.bin assets/World1/Level2/Spawns.bin ]
                              4 ;; Uncompressed:     910 bytes
                              5 ;; Compressed:       97 bytes
                              6 ;; Space saved:      813 bytes
                              7 ;;
                              8 ;; Data array definition
   1970                       9 _level2::
   1970 80 55 01 55 E5 B5    10    .db  0x80, 0x55, 0x01, 0x55, 0xe5, 0xb5, 0x03, 0x1d, 0xa8, 0x00, 0x74, 0x3b, 0x35, 0x54, 0xcc, 0x4a
        03 1D A8 00 74 3B
        35 54 CC 4A
   1980 1D 57 1E 1D 74 9B    11    .db  0x1d, 0x57, 0x1e, 0x1d, 0x74, 0x9b, 0x1d, 0xc6, 0x04, 0x07, 0x1d, 0x35, 0x28, 0x07, 0x1d, 0x5a
        1D C6 04 07 1D 35
        28 07 1D 5A
   1990 07 54 1D 8B 82 06    12    .db  0x07, 0x54, 0x1d, 0x8b, 0x82, 0x06, 0x59, 0x12, 0x06, 0x44, 0x1d, 0xab, 0x07, 0x1d, 0x2a, 0x06
        59 12 06 44 1D AB
        07 1D 2A 06
   19A0 54 1D 29 06 1D 0A    13    .db  0x54, 0x1d, 0x29, 0x06, 0x1d, 0x0a, 0x00, 0xc1, 0x10, 0x06, 0x1d, 0xad, 0x1e, 0x1b, 0xbb, 0x06
        00 C1 10 06 1D AD
        1E 1B BB 06
   19B0 1D 2A 00 1C F1 10    14    .db  0x1d, 0x2a, 0x00, 0x1c, 0xf1, 0x10, 0x00, 0x00, 0x0d, 0x19, 0x00, 0x06, 0x53, 0x00, 0xa1, 0x07
        00 00 0D 19 00 06
        53 00 A1 07
   19C0 00 04 00 48 02 00    15    .db  0x00, 0x04, 0x00, 0x48, 0x02, 0x00, 0xd4, 0x05, 0x10, 0x10, 0x15, 0x15, 0x20, 0x20, 0x25, 0x00
        D4 05 10 10 15 15
        20 20 25 00
   19D0 25                   16    .db  0x25
                             17 ;; Address of the latest byte of the compressed array (for unpacking purposes)
                     0060    18 _level2_end == . - 1
                             19 
