ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;; File src/Compression/level3.h.s generated using cpct_pack
                              2 ;; Compresor used:   zx7b
                              3 ;; Files compressed: [ src/Mapas/Level3.bin assets/World1/Level3/Spawns.bin ]
                              4 ;; Uncompressed:     910 bytes
                              5 ;; Compressed:       128 bytes
                              6 ;; Space saved:      782 bytes
                              7 ;;
                              8 
                              9 ;; Declaration of the compressed array and
                             10 ;; the address of the latest byte of the compressed array (for unpacking purposes)
                             11 .globl _level3
                             12 .globl _level3_end
                             13 
                             14 ;; Compressed and uncompressed sizes
                     0080    15 _level3_size_z = 128
                     038E    16 _level3_size   = 910
                             17 
                             18 
                             19 ;; Define constants for starting offsets of files in the uncompressed array
                     0000    20 _level3_OFF_000 =      0   ;; Starting offset for src/Mapas/Level3.bin
                     0384    21 _level3_OFF_001 =    900   ;; Starting offset for assets/World1/Level3/Spawns.bin
                             22 
