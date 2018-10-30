ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;; File src/Compression/level1.s generated using cpct_pack
                              2 ;; Compresor used: zx7b
                              3 ;; Files compressed: [ src/Mapas/Level1.bin assets/World1/Level1/Enemies.bin assets/World1/Level1/Spawns.bin assets/World1/Level1/Teleporter.bin assets/World1/Level1/HeroSpawn.bin ]
                              4 ;; Uncompressed:     915 bytes
                              5 ;; Compressed:       88 bytes
                              6 ;; Space saved:      827 bytes
                              7 ;;
                              8 ;; Data array definition
   1ADE                       9 _level1::
   1ADE B0 AA 00 9A AA 1D    10    .db  0xb0, 0xaa, 0x00, 0x9a, 0xaa, 0x1d, 0x00, 0x6e, 0x1d, 0xba, 0x00, 0x62, 0x03, 0x1d, 0x28, 0x13
        00 6E 1D BA 00 62
        03 1D 28 13
   1AEE 50 1E 17 1D 69 1E    11    .db  0x50, 0x1e, 0x17, 0x1d, 0x69, 0x1e, 0x50, 0x59, 0xa9, 0x95, 0x42, 0xa0, 0x12, 0x59, 0x68, 0x44
        50 59 A9 95 42 A0
        12 59 68 44
   1AFE 17 1D 34 AA 10 1D    12    .db  0x17, 0x1d, 0x34, 0xaa, 0x10, 0x1d, 0x56, 0x19, 0x1e, 0xb4, 0x16, 0x1a, 0x1d, 0x3d, 0x3e, 0x00
        56 19 1E B4 16 1A
        1D 3D 3E 00
   1B0E C5 10 18 1A 3D B4    13    .db  0xc5, 0x10, 0x18, 0x1a, 0x3d, 0xb4, 0x11, 0x00, 0x1a, 0x1d, 0xf7, 0x40, 0x00, 0x0e, 0x1b, 0x97
        11 00 1A 1D F7 40
        00 0E 1B 97
   1B1E 00 E8 1B 00 42 55    14    .db  0x00, 0xe8, 0x1b, 0x00, 0x42, 0x55, 0x1d, 0x00, 0x05, 0x05, 0x18, 0x05, 0x06, 0x01, 0x16, 0x19
        1D 00 05 05 18 05
        06 01 16 19
   1B2E 19 0F 0D 0E 07 38    15    .db  0x19, 0x0f, 0x0d, 0x0e, 0x07, 0x38, 0x00, 0x88
        00 88
                             16 ;; Address of the latest byte of the compressed array (for unpacking purposes)
                     0057    17 _level1_end == . - 1
                             18 
