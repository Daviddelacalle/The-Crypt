;; File src/Compression/level1.h.s generated using cpct_pack
;; Compresor used:   zx7b
;; Files compressed: [ src/Mapas/Level1.bin assets/World1/Level1/Enemies.bin assets/World1/Level1/Spawns.bin assets/World1/Level1/Teleporter.bin assets/World1/Level1/HeroSpawn.bin ]
;; Uncompressed:     915 bytes
;; Compressed:       88 bytes
;; Space saved:      827 bytes
;;

;; Declaration of the compressed array and
;; the address of the latest byte of the compressed array (for unpacking purposes)
.globl _level1
.globl _level1_end

;; Compressed and uncompressed sizes
_level1_size_z = 88
_level1_size   = 915


;; Define constants for starting offsets of files in the uncompressed array
_level1_OFF_000 =      0   ;; Starting offset for src/Mapas/Level1.bin
_level1_OFF_001 =    900   ;; Starting offset for assets/World1/Level1/Enemies.bin
_level1_OFF_002 =    901   ;; Starting offset for assets/World1/Level1/Spawns.bin
_level1_OFF_003 =    911   ;; Starting offset for assets/World1/Level1/Teleporter.bin
_level1_OFF_004 =    913   ;; Starting offset for assets/World1/Level1/HeroSpawn.bin

