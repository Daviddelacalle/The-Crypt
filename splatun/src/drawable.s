;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; TODO OBJETO DIBUJABLE DEBE 'HEREDAR' DE drawable.s
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.area _DATA
.area _CODE

.include "cpctelera.h.s"
.include "struct.h.s"

front_buffer:   .db 0xC0
back_buffer::   .db 0x80

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

swapBuffers::
    ld a, (back_buffer)
    ld b, a
    ld a, (front_buffer)
    ld (back_buffer), a
    ld a, b
    ld (front_buffer), a

    srl b
    srl b
    ld l, b
    jp cpct_setVideoMemoryPage_asm

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DIBUJADO DE UNA ENTIDAD
;; _______________________
;; ENTRADA: IX -> Puntero a entidad
;; DESTRUYE: AF, BC, DE, HL
;;;;;;;;;;;;;;;;;;;;;;;;;;;
dw_draw::
   ;; Funcion dibujado de las entidades que cuelgan de drawable.s

   ld a, (back_buffer)                  ;; Apunta al inicio de la memoria de video
   ld d, a
   ld e, #0

   ld a, e_x(ix)                        ;; Consigue la posicion del jugador
   ld     c,   a                        ;; x  [0-79]

   ld a, e_y(ix)                        ;; Repito para Y
   ;add a                                ;; Antes de guadarlo en el registro b para dibujar lo duplico, para tener más rango de scroll [-255, 255]
   ld     b,   a                        ;; y  [0-199]

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
    ld b, e_x(ix)
    ld e, e_y(ix)
    exx

    ld a, ppe_x(ix)
    ld e_x(ix), a
    ld a, ppe_y(ix)
    ld e_y(ix), a

    ld  a, e_col(ix)
    ex af, af'            ;'

    ld  e_col(ix), #0
    call dw_draw
    ex af, af'            ;'
    ld e_col(ix), a

    exx
    ld e_x(ix), b
    ld e_y(ix), e

    ld a, pe_x(ix)
    ld ppe_x(ix), a
    ld a, pe_y(ix)
    ld ppe_y(ix), a
 ret

;;======================================================================
;;======================================================================
;; FUNCIONES PRIVADAS
;;======================================================================
;;======================================================================











