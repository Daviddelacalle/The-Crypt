ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;; File src/Compression/level12.h.s generated using cpct_pack
                              2 ;; Compresor used:   zx7b
                              3 ;; Files compressed: [ src/Mapas/Level12.bin assets/World1/Level12/Enemies.bin assets/World1/Level12/Spawns.bin assets/World1/Level12/Teleporter.bin assets/World1/Level12/HeroSpawn.bin ]
                              4 ;; Uncompressed:     915 bytes
                              5 ;; Compressed:       177 bytes
                              6 ;; Space saved:      738 bytes
                              7 ;;
                              8 
                              9 ;; Declaration of the compressed array and
                             10 ;; the address of the latest byte of the compressed array (for unpacking purposes)
                             11 .globl _level12
                             12 .globl _level12_end
                             13 
                             14 ;; Compressed and uncompressed sizes
                     00B1    15 _level12_size_z = 177
                     0393    16 _level12_size   = 915
                             17 
                             18 
                             19 ;; Define constants for starting offsets of files in the uncompressed array
                     0000    20 _level12_OFF_000 =      0   ;; Starting offset for src/Mapas/Level12.bin
                     0384    21 _level12_OFF_001 =    900   ;; Starting offset for assets/World1/Level12/Enemies.bin
                     0385    22 _level12_OFF_002 =    901   ;; Starting offset for assets/World1/Level12/Spawns.bin
                     038F    23 _level12_OFF_003 =    911   ;; Starting offset for assets/World1/Level12/Teleporter.bin
                     0391    24 _level12_OFF_004 =    913   ;; Starting offset for assets/World1/Level12/HeroSpawn.bin
                             25 
