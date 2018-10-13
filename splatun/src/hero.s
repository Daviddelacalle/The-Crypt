;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ENTIDAD HEROE
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

CENTER_X = 40
CENTER_Y = 70


hero_x = .
hero_y = . + 1
DefineEntity hero, #40, #70, 0x02, 0x08, 0x00, 0x00, 0x0F, 0x0000

;;======================================================================
;;======================================================================
;; FUNCIONES PUBLICAS
;;======================================================================
;;======================================================================



;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DIBUJADO DE LA ENTIDAD HERO
;;;;;;;;;;;;;;;;;;;;;;;;;;;
hero_draw::
    ld   ix,   #hero    ;; ix apunta a los datos del heroe
    ; ld   a, #0         ;; Por si las moscas
    jp dw_draw

hero_clear::
    ld ix, #hero
    jp dw_clear


;===============================================================================
;|                                  CAMARA
;|  Para que se produzca el scroll del mapa se tienen que producir dos codiciones:
;|      -El jugador tiene que estar en el centro (CENTER_X/Y)
;|      -El límite izquierdo (eje X) / superior (eje Y), no esté en el borde
;|          -- Borde izquierdo  = 0
;|          -- Borde derecho    = 40
;|              --- Ancho del mapa =  30 tiles
;|              --- Cada tile = 8 pixeles = 2 bytes
;|              --- Ancho del mapa en bytes = 30 * 2 = 120 bytes
;|              --- Ancho de pantalla = 80 bytes
;|              --- Ancho real  = 120 bytes - 80b bytes = 40 bytes
;|          -- Borde superior   = 0
;|          -- Borde inferior = 80 bytes (mismo cálculos, pero el alto total
;|                                          es distinto)
;|
;|  De manera que si la camara está pegada al border izquierdo y me muevo a la izq
;|  se moverá el personaje.
;|
;|      ======================================  Pulso la A
;|      ||                                  ||  x = Centro de la cámara
;|      ||________________                  ||  @ = Jugador
;|      ||                |                 ||
;|      ||       x        |                 ||
;|      ||   @            |                 ||
;|      ||________________|                 ||
;|      ||                                  ||  Se moverá el jugador
;|      ||                                  ||
;|      ======================================
;|
;|  En el caso de que la cámara esté pegada a la derecha y el jugador
;|
;|      ====================================== Pulso la A
;|      ||                                  ||  x = Centro de la cámara
;|      ||                  ________________||  @ = Jugador
;|      ||                 |                ||
;|      ||                 |       x        ||
;|      ||                 |           @    ||
;|      ||                 | _______________||
;|      ||                                  ||  Se moverá el jugador
;|      ||                                  ||
;|      ======================================
;|
;|
;|
;|      ====================================== Pulso la A
;|      ||                                  ||  x = Centro de la cámara
;|      ||                  ________________||  @ = Jugador
;|      ||                 |                ||
;|      ||                 |       x        ||
;|      ||                 |       @        ||
;|      ||                 | _______________||
;|      ||                                  ||  Se moverá la cámara
;|      ||                                  ||
;|      ======================================
;|
;===============================================================================
hero_update::
    ld    ix,   #hero   ; Se puede borrar si hero es el ultimo en hacer dro
    ld e_vx(ix), #0
    ld e_vy(ix), #0

    call cpct_scanKeyboard_asm


    ld hl, #Key_A                           ;; Check Key A
    call cpct_isKeyPressed_asm

    jr z, a_no_pulsada

        ld a, e_x(ix)                       ;; Pruebo la primera condicion
        cp #CENTER_X
        jr nz, move_the_character_A         ;; Si no estoy en el centro, muevo el jugador

        ld hl, #CameraMinX                  ;; Pruebo la segunda condicion
        ld a, (hl)                          ;; Lo cargo en HL porque la funcion inc_map lo necesita
        cp #0                               ;; Borde izquierdo (0)
        jr nz, move_the_map_A               ;; Si se ha pulsado la A y no estoy en el borde
                                            ;; muevo el mapa
        move_the_character_A:
            ld b, #-2                       ;; Cambio la velocidad del jugador a 2
            ld e_vx(ix), b

        jr d_no_pulsada

        move_the_map_A:                     ;;  Muevo el map
            ld de, #-1                      ;;  Pasándole los parámetros a la funcion
            ld b, #-4
            call inc_map

    jr d_no_pulsada             ;; Si se ha pulsado no compruebes la tecla D

    a_no_pulsada:
        ld hl, #Key_D               ;; Comprueba tecla D
        call cpct_isKeyPressed_asm
        jr z, d_no_pulsada

            ld a, e_x(ix)
            cp #CENTER_X
            jr nz, move_the_character_D

            ld hl, #CameraMinX
            ld a, (hl)
            cp #40
            jr nz, move_the_map_D

            move_the_character_D:
                ld b, #2
                ld e_vx(ix), b
            jr d_no_pulsada

            move_the_map_D:
                ld de, #1
                ld b, #4
                call inc_map

    d_no_pulsada:
        ld hl, #Key_W
        call cpct_isKeyPressed_asm
        jr z, w_no_pulsada

            ld a, e_y(ix)
            cp #CENTER_Y
            jr nz, move_the_character_W

            ld hl, #CameraMinY
            ld a, (hl)
            cp #0
            jr nz, move_the_map_W

            move_the_character_W:
                ld b, #-4
                ld e_vy(ix), b

            jr s_no_pulsada

            move_the_map_W:
                ld de, #-30
                ld b, #-8
                call inc_map


        jr s_no_pulsada

    w_no_pulsada:
        ld hl, #Key_S
        call cpct_isKeyPressed_asm
        jr z, s_no_pulsada

            ld a, e_y(ix)
            cp #CENTER_Y
            jr nz, move_the_character_S

            ld hl, #CameraMinY
            ld a, (hl)
            cp #80
            jr nz, move_the_map_S

            move_the_character_S:
                ld b, #4
                ld e_vy(ix), b

            jr s_no_pulsada

            move_the_map_S:
                ld de, #30
                ld b, #8
                call inc_map

    s_no_pulsada:

    ld a, e_x(ix)                    ;; Consigue la posicion del jugador
    add e_vx(ix)                     ;; Le sumo la velocidad, lo hago aqui en vez del update de jugador para evitar restar en clear
    ld e_x(ix), a                    ;; Lo guardo en su registro

    ld a, e_y(ix)                    ;; Repito para Y
    add e_vy(ix)
    ld e_y(ix), a

ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CARGA EN LOS REGISTROS A,B LOS VALORES DE X,Y
;; _______________________
;; DESTRUYE: A, B
;;;;;;;;;;;;;;;;;;;;;;;;;;;
hero_get_position::
   ld    a,    (hero_y)
   ld    b,    a
   ld    a,    (hero_x)
   ret

;;======================================================================
;;======================================================================
;; FUNCIONES PRIVADAS
;;======================================================================
;;======================================================================







