.area _DATA
.area _CODE

;;====================================
;; INCLUDES
;;====================================

.include "cpctelera.h.s"
.include "cpcglbl.h.s"
.include "hero.h.s"
.include "bullet.h.s"

;; Punto de entrada de la funcion main
_main::
   ;; Deshabilitar el firmware
   call cpct_disableFirmware_asm

   ;; Cambiar el VideoMode a 0
   ld    c, #0
   call cpct_setVideoMode_asm

;; Comienza el bucle del juego
loop:
   ;;call hero_check_inputs
      call cpct_scanKeyboard_asm
      ld hl, #Key_Space
      call cpct_isKeyPressed_asm
      call nz, #bullet_init

   ;; CLIAR

   ;; UPDEIT
   call bullet_update

   ;; DRO
   call hero_draw
   call bullet_draw


   call cpct_waitVSYNC_asm
jr loop
