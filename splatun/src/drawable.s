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

;;======================================================================
;;======================================================================
;; DATOS PRIVADOS
;;======================================================================
;;======================================================================

front_buffer:       .db 0xC0
back_buffer::       .db 0x80

ptr_spriteHeart:            .dw #_sp_hero_12
ptr_spriteBlankHeart:       .dw #_sp_hero_13

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

   ld hl, #CoordMapMin
   ld a, e_x(ix)                        ;; Consigue la posicion del jugador
   sub (hl)
   cp #61   ;
   ret nc

   add #OFFSET_CAMERA_POS_X_PANT
   ld     c,   a                        ;; x  [0-79]

   ld hl, #CoordMapMin+1
   ld a, e_y(ix)                        ;; Repito para Y
   sub (hl)
   cp #112  ;; -8
   ret nc

   add #OFFSET_CAMERA_POS_Y_PANT
   ld     b,   a                        ;; y  [0-199]

   ld a, (back_buffer)                  ;; Apunta al inicio de la memoria de video
   ld d, a
   ld e, #00
   call cpct_getScreenPtr_asm

   ex   de,     hl                      ;; Apunta a la posicion x,y
   ld   l,      e_spr_l(ix)             ;; Apuntar al sprite
   ld   h,      e_spr_h(ix)             ;; Apuntar al sprite
   ld   c,      e_w(ix)                 ;; Ancho
   ld   b,      e_h(ix)                 ;; Alto
   call cpct_drawSprite_asm

ret


;;======================================================================
;;======================================================================
;; FUNCIONES PRIVADAS
;;======================================================================
;;======================================================================


;; Misma ejecucion que tile_a_mapa
mapa_a_tile::
   ;; Paso Y
   ld    a, h           ;; A = Y
   ;add   #-OFFSET_CAMERA_POS_Y_PANT
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
   ld   a,    c
   ld   b,    a        ;; En B guardo la Y

   ;; Paso X
   ld    a, l           ;; A = X
   ;add   #-OFFSET_CAMERA_POS_X_PANT
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
   ret

;   ---
;   Check if entity is inside the viewport
;   Input:  IX => Entity
;            B => X
;            C => Y
;   Return:  A = (0 = Is Outside, 1 = Is inside)
;   Destroys: A, BC, DE, HL
;===============================================
checkViewport::
    ;; OPERACIONES EN COORDENADAS DE TILES, NO EN COORDENADAS DE MAPA
    ld a, (CoordMapMin)
    ld l, a
    add #64
    ld e, a

    ld a, b
    cp    l                 ;; Ver si X es mayor que la coordenada X minima
    jr    c, is_outside     ;; Si A > x_min <----> C = 0
    cp    e                 ;; Ver si X es menor que la coordenada X maxima
    jr   nc, is_outside        ;; Si A < x_max <----> C = 1

    ld a, (CoordMapMin+1)
    ld h, a
    add #128
    ld d, a

    ld    a, c              ;; A = enemy_y
    cp    h                 ;; Ver si X es mayor que la coordenada Y minima
    jr    c, is_outside        ;; Si A > y_min <----> C = 0
    cp    d                 ;; Ver si X es menor que la coordenada Y maxima
    jr   nc, is_outside        ;; Si A < y_max <----> C = 1

    ld a, #1
    ret

    is_outside:
        ld a, #0
        ret
ret

;; DIBUJA LOS CORAZONES DE VIDA
dw_drawHearts::
    ;; Cargo en A las vidas del jugador
    ;; Y hago un bucle dibujandolas en el hud
    ld      a, (HERO_LIVES)
    ld      d, a
    ld      a, #K_HERO_LIVES
    ld      e, a
    ;; Lo guardo en la pila
    push    de

    ;; Cargo las posiciones iniciales
    ;; donde se empiezan a dibujar la ristra de corazones
    ld      c, #10
    ld      b, #168
    push bc         ;; Lo guardo para el bucle
    hearts_loop:
        ld      a, (back_buffer)                ;; Apunta al inicio de la memoria de video
        ld      d, a
        ld      e, #00
        call cpct_getScreenPtr_asm

        ex      de,     hl                      ;; Apunta a la posicion x,y
        ld      hl,     (ptr_spriteHeart)       ;; Apuntar al sprite
        ld      c,      #4                      ;; Ancho
        ld      b,      #8                      ;; Alto
        call cpct_drawSprite_asm

        ;; Recupero la posicion inicial
        ;; Aumento la posicion de X
        pop     bc
        ld      a, c
        add     a, #6
        ld      c, a

        ;; Recupero el contador
        pop     de
        dec     e
        dec     d
        ;; Vuelvo a guardar los registros en la pila
        push    de
        push    bc
    jr nz, hearts_loop

    ;; Ahora miro el caso de que el heroe tenga
    ;; menos de 3 corazones
    ld      a, e
    cp #0
    jr z, end_drawHearts
    ;; Si el heroe NO tiene las vidas maximas
    ;; entra aqui

    ;; Recupero DE y asigno a d el valor
    ;; que tenia e, que ERA el de la constante
    ;; de numero de vidas
    ;; D = E
    pop     bc
    pop     de
    ld      d, e

    push    de
    push    bc
    blank_hearts_loop:
        ld      a, (back_buffer)                ;; Apunta al inicio de la memoria de video
        ld      d, a
        ld      e, #00
        call cpct_getScreenPtr_asm

        ex      de,     hl                      ;; Apunta a la posicion x,y
        ld      hl,     (ptr_spriteBlankHeart)  ;; Apuntar al sprite
        ld      c,      #4                      ;; Ancho
        ld      b,      #8                      ;; Alto
        call cpct_drawSprite_asm

        ;; Recupero la posicion inicial
        ;; Aumento la posicion de X
        pop     bc
        ld      a, c
        add     a, #6
        ld      c, a

        ;; Recupero el contador
        pop     de
        dec     d
        ;; Vuelvo a guardar los registros en la pila
        push    de
        push    bc
    jr nz, blank_hearts_loop
    end_drawHearts:
    ;; Hago pop de los registros
    ;; que he metido en la pila
    ;; para que el programa no pete bastamente
    pop     hl
    pop     hl
ret












