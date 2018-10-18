;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; TODO OBJETO DIBUJABLE DEBE 'HEREDAR' DE drawable.s
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.area _DATA
.area _CODE

.include "cpctelera.h.s"
.include "struct.h.s"
.include "constants.h.s"

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

   ;; Si A == AA -> LAS COORDENADAS DEL OBJETO AL QUE APUNTA IX ESTAN EN TILES
   ;; Si lo es, entonces -> pasar a coordenadas de MAPA y ver si hay que dibujarlo

   ;; Primero se checkea si A == AA
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
   ;; Corregir offset de la camara
      ;; HAY QUE COGER UNAS COORDENADAS RELATIVAS A LA POSICION DE LA CAMARA
      ;; SINO SIEMPRE LA CAMARA ESTARA EN min(0,0) Y max(20,20)

   ;; Cargar las coordenadas en HL
   ld l, e_x(ix)           ;; L = X
   ld h, e_y(ix)           ;; H = Y

   ;; ============================================================== ;;
   ;;                  SOBRE EL OFFSET DE LA CAMARA                  ;;
   ;; ______________________________________________________________ ;;
   ;; La camara empieza con el borde arriba-izquierda a (0,0)        ;;
   ;; Si la camara es movida una vez hacia la derecha                ;;
   ;; entonces el offset offset sube a (1,1).                        ;;
   ;; - La posicion de comprobación de coordenadas se hace con esto  ;;
   ;; - Hay que restarle este offset a las posiciones en tiles       ;;
   ;;   de la entidad que se le pase en IX                           ;;
   ;; ============================================================== ;;

   ;; HAY QUE COMENTAR CABRONES!! @dani @dd

   call tile_a_mapa     ;; INFO COMPLETA EN LA FUNCION

   jr sigue_con_el_dro
   normal_dro:

   ;; Aqui solo entra si las coordenadas de la entidad IX NO ESTAN EN TILES
   ld hl, #CoordMapMin
   ld a, e_x(ix)                        ;; Consigue la posicion del jugador
   sub (hl)
   ld     c,   a                        ;; x  [0-79]

   ld hl, #CoordMapMin+1
   ld a, e_y(ix)                        ;; Repito para Y
   sub (hl)
   ld     b,   a                        ;; y  [0-199]


   sigue_con_el_dro:

   ld a, (back_buffer)                  ;; Apunta al inicio de la memoria de video
   ld d, a
   ld e, #00

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PASA LAS COORDENADAS DE TILE A COORDENADAS DE MAPA
;; __________________________________________________
;; ENTRADA:    L -> Coordenada de TILE en X
;;             H -> Coordenada de TILE en Y
;; SALIDA:     C -> Coordenada de MAPA en X
;;             B -> Coordenada de MAPA en Y
;; DESTRUYE:   A,D,BC
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
tile_a_mapa::
   ld a, (cam_min)
   neg                  ;; Tengo el negativo de A
   add   l
   ld    l,    a        ;; L tiene la coordenada X corregida

   ;; Hay offset en Y?
   ld a, (cam_min+1)
   neg                  ;; Tengo el negativo de A
   add   h
   ld    h,    a        ;; H tiene la coordenada Y corregida

   ;; Paso Y
   ld    a,    h           ;; A = Y
   add   #OFFSET_CAMERA_POS_Y
   ld    c,    #7          ;; Iteraciones del loop
   ld    d,    a           ;; D = Y
   loop_y_tm:
      add a, d          ;; A = A + D = A + A_inicial
      dec c             ;; C--
   jr nz, loop_y_tm

   ld b, a              ;; En B guardo la Y

   ;; Paso X
   ld    a, l                    ;; ======================= ;;
   add   #OFFSET_CAMERA_POS_X
   ld    c, #3                   ;;                         ;;
   ld    d, a                    ;; Hago lo mismo que antes ;;
   loop_x_tm:                    ;;      pero con la X      ;;
      add a, d                   ;;                         ;;
      dec c                      ;; ======================= ;;
   jr nz, loop_x_tm

   ld c, a              ;; En C guardo la X
   ret

;; Misma ejecucion que tile_a_mapa
mapa_a_tile::
   ;; Paso Y
   ld    a, h           ;; A = Y
   add   #-OFFSET_CAMERA_POS_Y_PANT
   ld    d, #8          ;; D = 8 -> Tamanyo en Y de cada tile en bytes
   ld    c, #0          ;; C = 0
   loop_y_mt:
      cp d
      jr c, end_loop_y_mt

      inc c
      sub d             ;; A = A - D
   jr nc, loop_y_mt
   jr z, loop_y_mt
   end_loop_y_mt:
   ld    a,    (cam_min+1)
   add   a,    c
   ld    b,    a              ;; En B guardo la Y

   ;; Paso X
   ld    a, l           ;; A = X
   add   #-OFFSET_CAMERA_POS_X_PANT
   ld    d, #4          ;; D = 4 -> Tamanyo en X de cada tile en bytes
   ld    c, #0          ;; C = 0
   loop_x_mt:
      cp d
      jr c, end_loop_x_mt

      inc c
      sub d             ;; A = A - D
   jr nc, loop_x_mt
   jr z, loop_x_mt
   end_loop_x_mt:
   ;; En C ya tengo guardada la X debido al bucle
   ld    a,    (cam_min)
   add   a,    c
   ld    c,    a              ;; En C guardo la X

   ;; LOS VALORES DEL OFFSET YA ESTA ANYADIDOS!!!

   ret








