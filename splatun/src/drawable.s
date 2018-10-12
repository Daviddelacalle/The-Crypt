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
cam_min: .db   #0 ,  #0    ;; Coordenadas x,y de la posicion minima de la camara -> ARRIBA - IZQUIERDA
cam_max: .db   #20,  #20   ;; Coordenadas x,y de la posicion maxima de la camara ->  ABAJO - DERECHA

save_dw_x: .db   #0        ;; Donde guardo las coordenadas X de donde dibujar
save_dw_y: .db   #0        ;; Donde guardo las coordenadas Y de donde dibujar

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

   ;; Si A == FF -> LAS COORDENADAS DEL OBJETO AL QUE APUNTA IX ESTAN EN TILES
   ;; Si lo es, entonces -> pasar a coordenadas de MAPA y ver si hay que dibujarlo

   ;; Primero se checkea si A == FF
   cp    #0xAA
   jr nz, normal_dro

   ;; OPERACIONES EN COORDENADAS DE TILES, NO EN COORDENADAS DE MAPA
   ld    hl, (cam_max)
   ex    de, hl            ;; E = X, D = Y -> Coordenadas maximas
   ld    hl, (cam_min)     ;; L = X, H = Y -> Coordenadas minimas

   ld    a, e_x(ix)        ;; A = enemy_x
   cp    l                 ;; Ver si X es mayor que la coordenada X minima
   ret   c                    ;; Si A > x_min <----> C = 0
   cp    e                 ;; Ver si X es menor que la coordenada X maxima
   ret   nc                   ;; Si A < x_max <----> C = 1

   ld    a, e_y(ix)        ;; A = enemy_y
   cp    h                 ;; Ver si X es mayor que la coordenada Y minima
   ret   c                    ;; Si A > y_min <----> C = 0
   cp    d                 ;; Ver si X es menor que la coordenada Y maxima
   ret   nc                   ;; Si A < y_max <----> C = 1

   ;; Si llega aqui significa que esta dentro de los limites
   call mapa_a_tile

   jr sigue_con_el_dro
   normal_dro:

   ld a, e_x(ix)                        ;; Consigue la posicion del jugador
   ld     c,   a                        ;; x  [0-79]

   ld a, e_y(ix)                        ;; Repito para Y
   ;add a
   ld     b,   a                        ;; y  [0-199]

   sigue_con_el_dro:

   ld a, (back_buffer)                  ;; Apunta al inicio de la memoria de video
   ld d, a
   ld e, #0

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

;; PASA LAS COORDENADAS DE MAPA A COORDENADAS DE TILE
mapa_a_tile:
   ;; Paso Y
   ld    a, e_y(ix)     ;; A = Y
   ld    c, #7          ;; Iteraciones del loop
   ld    d, a           ;; D = Y
   loop_y:
      add a, d          ;; A = A + D = A + A_inicial
      dec c             ;; C--
   jr nz, loop_y

   ld b, a              ;; En B guardo la Y

   ;; Paso X
   ld    a, e_x(ix)     ;; ======================= ;;
   ld    c, #3          ;;                         ;;
   ld    d, a           ;; Hago lo mismo que antes ;;
   loop_x:              ;;      pero con la X      ;;
      add a, d          ;;                         ;;
      dec c             ;; ======================= ;;
   jr nz, loop_x

   ld c, a              ;; En C guardo la X

   ld (save_dw_x), bc   ;; Lo guardo en memoria
   ret










