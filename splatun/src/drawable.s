;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; TODO OBJETO DIBUJABLE DEBE 'HEREDAR' DE drawable.s
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.area _DATA
.area _CODE

.include "cpctelera.h.s"
.include "struct.h.s"

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

   cp #0xFF                             ;; Compruebo si he llamado a draw desde el clear para no sumar la velocidad
   jr nz, normal_dro                    ;; Si no he llamado desde el clear, salto
    ;;Llamada desde el clear
       ld a, e_x(ix)                    ;; Cargo la posicion X, que es del frame anterior
       ld     c,   a                    ;; x  [0-79]
       ld a, e_y(ix)                    ;; Cargo la posicion Y, tambien del frame anterior
       jr dro                           ;; Salto a dro, para ahorrar un par de bytes, ya que a partir de ahi, el codigo es igual

   normal_dro:                          ;; Dro normal
   ld a, e_x(ix)                        ;; Consigue la posicion del jugador
       add e_vx(ix)                     ;; Le sumo la velocidad, lo hago aqui en vez del update de jugador para evitar restar en clear
       ld e_x(ix), a                    ;; Lo guardo en su registro
   ld     c,   a                        ;; x  [0-79]

   ld a, e_y(ix)                        ;; Repito para Y
       add e_vy(ix)
       ld e_y(ix), a

       dro:
       ;add a                            ;; Antes de guadarlo en el registro b para dibujar lo duplico, para tener más rango de scroll [-255, 255]
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
    ld  a, e_col(ix)
    ex af, af'            ;'

    ld  e_col(ix), #0
    ld a, #0xFF
    call dw_draw
    ex af, af'            ;'
    ld e_col(ix), a
 ret

;;======================================================================
;;======================================================================
;; FUNCIONES PRIVADAS
;;======================================================================
;;======================================================================











