;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; TODO OBJETO DIBUJABLE DEBE 'HEREDAR' DE drawable.s
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.area _DATA
.area _CODE

.include "cpctelera.h.s"
.include "cpcglbl.h.s"
.include "struct.h.s"

.globl CameraMinMax
;;======================================================================
;;======================================================================
;; DATOS PRIVADOS
;;======================================================================
;;======================================================================


;;======================================================================
;;======================================================================
;; FUNCIONES PUBLICAS
;;======================================================================
;;======================================================================

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DIBUJADO DE UNA ENTIDAD
;; _______________________
;; ENTRADA: IX -> Puntero a entidad
;; DESTRUYE: AF, BC, DE, HL
;;;;;;;;;;;;;;;;;;;;;;;;;;;
dw_draw::
   ;; Funcion dibujado de las entidades que cuelgan de drawable.s

   ld    de,   #0xC000                  ;; Apunta al inicio de la memoria de video

   ld a, e_x(ix)                        ;; Consigue la posicion del jugador
   ld hl, #CameraMinMax                 ;; Cargo en HL la coordenada minima en X
   sub (hl)                             ;; Le resto a A, esta coordenada
   cp #80                               ;; Compruebo que esté entre 0 y 80
   ret nc                               ;; Si está fuera del límite no la dibujo
   ld     c,   a      ;; x  [0-79]

   ld a, e_y(ix)
   ld hl, #CameraMinMax+1
   sub (hl)
   cp #100
   ret nc
   add a
   ld     b,   a      ;; y  [0-199]
   call cpct_getScreenPtr_asm

   ;; SIN SPRITE
   ex    de,   hl          ;; Apunta a la posicion x,y
   ld     a,   e_col(ix)    ;; Código de color
   ld     c,   e_w(ix)      ;; Ancho
   ld     b,   e_h(ix)      ;; Alto
   call cpct_drawSolidBox_asm

   ;; CON SPRITE
   ;; (2B HL) sprite	Source Sprite Pointer (array with pixel data)
   ;; (2B DE) memory	Destination video memory pointer
   ;; (1B C ) width	Sprite Width in bytes [1-63] (Beware, not in pixels!)
   ;; (1B B ) height	Sprite Height in bytes (>0)
   ;; cpct_drawSprite_asm
   ret

;==================================
; Clears the sprite (squeare now)
;==================================
dw_clear::
  ld  a, e_col(ix)
  ex af, af'            ;'

  ld  e_col(ix), #0

  call dw_draw
  ex af, af'            ;'
  ld e_col(ix), a

 ret

;;======================================================================
;;======================================================================
;; FUNCIONES PRIVADAS
;;======================================================================
;;======================================================================











