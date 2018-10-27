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

ptr_fontLevelInfo:
    .dw #_sp_font_levels_00     ;; L
    .dw #_sp_font_levels_01     ;; E
    .dw #_sp_font_levels_02     ;; V
    .dw #_sp_font_levels_01     ;; E
    .dw #_sp_font_levels_00     ;; L
.db #0xFF

;; Se calcula solo al pasar de nivel
number_decenas::        .db #0  ;; Decenas del nivel  -> NIVEL 10,  number_decenas=1
number_unidades::       .db #0  ;; Unidades del nivel -> NIVEL 15, number_unidades=5
ptr_FontNumberInfo:
    .dw #_sp_font_levels_03     ;; 0
    .dw #_sp_font_levels_04     ;; 1
    .dw #_sp_font_levels_05     ;; 2
    .dw #_sp_font_levels_06     ;; 3
    .dw #_sp_font_levels_07     ;; 4
    .dw #_sp_font_levels_08     ;; 5
    .dw #_sp_font_levels_09     ;; 6
    .dw #_sp_font_levels_10     ;; 7
    .dw #_sp_font_levels_11     ;; 8
    .dw #_sp_font_levels_12     ;; 9
    ; .dw #_sp_font_levels_13     ;; ESPACIO EN BLANCO
.db #0xFF

;; Marca las posiciones de inicio de los corazones
;; y de la info del nivel
HUD_DRAWING_OFFSET      = 1
HUD_HEARTS_INIT_X       = 10
HUD_LEVELINFO_INIT_X    = HUD_HEARTS_INIT_X+((4+HUD_DRAWING_OFFSET)*K_HERO_LIVES)
HUD_INIT_Y              = 168

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

   ;; Si llega aqui significa que esta dentro de los limites
   ;; Corregir offset de la camara
      ;; HAY QUE COGER UNAS COORDENADAS RELATIVAS A LA POSICION DE LA CAMARA
      ;; SINO SIEMPRE LA CAMARA ESTARA EN min(0,0) Y max(20,20)
   ld a, e_x(ix)
   ld b, a
   ld a, e_y(ix)
   ld c, a

   call checkViewport
   cp #0
   ret z
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
   ld a, b
   add   #OFFSET_CAMERA_POS_Y_PANT
   ld b, a

   ld a, c
   add   #OFFSET_CAMERA_POS_X_PANT
   ld c, a

   jr sigue_con_el_dro
   normal_dro:

   ;; Aqui solo entra si las coordenadas de la entidad IX NO ESTAN EN TILES

   ld hl, #CoordMapMin
   ld a, e_x(ix)                        ;; Consigue la posicion del jugador
   sub (hl)
   cp #62   ;
   ret nc

   add #OFFSET_CAMERA_POS_X_PANT
   ld     c,   a                        ;; x  [0-79]

   ld hl, #CoordMapMin+1
   ld a, e_y(ix)                        ;; Repito para Y
   sub (hl)
   cp #120  ;; -8
   ret nc

   add #OFFSET_CAMERA_POS_Y_PANT
   ld     b,   a                        ;; y  [0-199]


   sigue_con_el_dro:

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
   ld    c,    #7          ;; Iteraciones del loop
   ld    d,    a           ;; D = Y
   loop_y_tm:
      add a, d          ;; A = A + D = A + A_inicial
      dec c             ;; C--
   jr nz, loop_y_tm

   ;add   #OFFSET_CAMERA_POS_Y_PANT
   ld b, a              ;; En B guardo la Y

   ;; Paso X
   ld    a, l                    ;; ======================= ;;
   ld    c, #3                   ;;                         ;;
   ld    d, a                    ;; Hago lo mismo que antes ;;
   loop_x_tm:                    ;;      pero con la X      ;;
      add a, d                   ;;                         ;;
      dec c                      ;; ======================= ;;
   jr nz, loop_x_tm

   ;add   #OFFSET_CAMERA_POS_X_PANT
   ld c, a              ;; En C guardo la X
   ret

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
    ld    hl, (cam_max)
    ex    de, hl            ;; E = X, D = Y -> Coordenadas maximas
    ld    hl, (cam_min)     ;; L = X, H = Y -> Coordenadas minimas

    ld a, b
    cp    l                 ;; Ver si X es mayor que la coordenada X minima
    jr    c, is_outside     ;; Si A > x_min <----> C = 0
    cp    e                 ;; Ver si X es menor que la coordenada X maxima
    jr   nc, is_outside        ;; Si A < x_max <----> C = 1

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
    ld      c, #HUD_HEARTS_INIT_X
    ld      b, #HUD_INIT_Y
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
        add     a, #4+HUD_DRAWING_OFFSET
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
        add     a, #4+HUD_DRAWING_OFFSET
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

;; DIBUJA EN PANTALLA LA INFORMACION DEL NIVEL: LEVEL XX
dw_drawLevelInfo::
    ;; Cargo las posiciones iniciales
    ;; donde se empiezan a dibujar 'LEVEL XX'
    ld      c, #HUD_LEVELINFO_INIT_X
    ld      b, #HUD_INIT_Y

    ;; Cargo en HL el puntero al inicio de
    ;; los sprites de la fuente para dibujar la palabra LEVEL
    ld hl, #ptr_fontLevelInfo

    ;; Guardo BC y HL en la PILA para despues
    push    bc
    push    hl
    drawingFont_loop:
        ld a, (hl)
        cp #0xFF
        jr z, keepDrawingLevelInfo

        ld      a, (back_buffer)    ;; Apunta al inicio de la memoria de video
        ld      d, a
        ld      e, #00
        call cpct_getScreenPtr_asm

        ex      de,     hl          ;; Apunta a la posicion x,y

        ;; Consigo HL de la pila y lo vuelvo
        ;; a guardar para despues
        pop     hl
        push    hl
        ;; Cargo en C el contenido al que apunta HL
        ld      c, (hl)
        inc     hl
        ;; Aumento el puntero de HL en 1 y
        ;; cargo en B el contenido al que apunta HL
        ld      b, (hl)
        ;; Ahora HL apunta al contenido de HL
        push    bc
        pop     hl

        ld      c,      #4          ;; Ancho
        ld      b,      #8          ;; Alto
        call cpct_drawSprite_asm

        ;; Aumento el puntero para que apunte a la siguiente letra
        pop     hl
        ld      de, #2
        add     hl, de

        ;; Aumento la posicion en X
        pop     bc
        ld      a, c
        add     a, #4+HUD_DRAWING_OFFSET
        ld      c, a

        ;; Vuelvo a cargar los registros en la pila
        push    bc
        push    hl

    jr drawingFont_loop
    keepDrawingLevelInfo:

    ;; Libero el registro de HL que se habia guardado
    ;; en la PILA
    pop     hl
    ;; BC no lo libero porque lo necesitare ahora

    ;; Guardo en la PILA el numero de las decenas
    ;; antes de llamar a dw_drawNumber
    ld a, (number_decenas)
    call dw_drawNumber

    ;; Aumento la posicion en X
    pop     bc
    ld      a, c
    add     a, #4+HUD_DRAWING_OFFSET
    ld      c, a

    ;; Hago lo mismo de antes pero con las unidades
    ld a, (number_unidades)
    jr dw_drawNumber

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PINTA EN PANTALLA EL NUMERO DE LAS DECENAS DE LA INFO DEL NIVEL
;; ----------------------------------------------------------------
;; ENTRADA:     A -> Numero a dibujar 0-9
;; DESTRUYE:    AF,DE,HL,BC -> EBRIZIN
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
dw_drawNumber:
    ;; Primero guardo el valor de A en la PILA
    push af

    ;; DIBUJO LAS DECENAS
    ld      a, (back_buffer)    ;; Apunta al inicio de la memoria de video
    ld      d, a
    ld      e, #00
    call cpct_getScreenPtr_asm

    ;; Recupero el valor de A de la pila
    pop     af

    ;; Guardo en la PILA el valor que cpct_getScreenPtr_asm
    ;; ha devuelto en HL
    ;; Despues lo recuperare en DE
    push    hl

    ;; Cargo el puntero a la ristra
    ;; de los sprites de numeros, en HL
    ld hl, #ptr_FontNumberInfo

    ;; Aumento las decenas en hl
    ;; Lo cargo en A mediante el 'pop af' de antes
    ld      e, a
    ld      d, #0
    add     hl, de
    add     hl, de

    ;; Cargo en C el contenido al que apunta HL
    ld      c, (hl)
    ;; Aumento el puntero de HL en 1 y
    ;; cargo en B el contenido al que apunta HL
    inc     hl
    ld      b, (hl)
    ;; Ahora HL apunta al contenido de HL
    push    bc
    pop     hl

    ;; Recupero el valor que cpct_getScreenPtr_asm habia devuelto
    ;; y lo cargo en DE para pintar el sprite
    pop     de
    ld      c,      #4          ;; Ancho
    ld      b,      #8          ;; Alto
    jp cpct_drawSprite_asm




