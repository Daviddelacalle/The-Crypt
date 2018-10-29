.include "struct.h.s"

;;==================================================
;;  Checks collision with tilemap on the next frame
;;  INPUT:  B => Speed
;;==================================================

;; 4 self-modifying functions, they simply change which
;; two borders get, and they change those calls in
;; "checkBorderForTileMapCollision" so we can reuse the same
;; function

; 7C = ld a, h
; 7D = ld a, l

; 67 = ld h, a
; 6F = ld l, a
checkLeftBorderForTilemapCollision::
    ld hl, #getUpperLeftCorner
    ld (firstCorner), hl
    ld hl, #getLowerLeftCorner
    ld (secondCorner), hl
    jr set_X_Axis

checkRightBorderForTilemapCollision::
    ld hl, #getUpperRightCorner
    ld (firstCorner), hl
    ld hl, #getLowerRightCorner
    ld (secondCorner), hl
    jr set_X_Axis

set_X_Axis:
    ld a, #0x7D
    ld (axisOneRead), a
    ld (axisTwoRead), a
    ld a, #0x6F
    ld (axisOneWrite), a
    ld (axisTwoWrite), a
    jr checkBorderForTileMapCollision


checkUpperBorderForTilemapCollision::
    ld hl, #getUpperLeftCorner
    ld (firstCorner), hl
    ld hl, #getUpperRightCorner
    ld (secondCorner), hl
    jr set_Y_Axis

checkLowerBorderForTilemapCollision::
    ld hl, #getLowerLeftCorner
    ld (firstCorner), hl
    ld hl, #getLowerRightCorner
    ld (secondCorner), hl
    jr set_Y_Axis

set_Y_Axis:
    ld a, #0x7C
    ld (axisOneRead), a
    ld (axisTwoRead), a
    ld a, #0x67
    ld (axisOneWrite), a
    ld (axisTwoWrite), a
    jr checkBorderForTileMapCollision


checkBorderForTileMapCollision:
    firstCorner = . + 1
    call getLowerLeftCorner
    axisOneRead = .
    ld a, h
    add b
    axisOneWrite = .
    ld h, a
    push bc
    call check_colision
    pop bc
    cp #1
    ret z

    secondCorner = . + 1
    call getLowerRightCorner
    axisTwoRead = .
    ld a, h
    add b
    axisTwoWrite = .
    ld h, a
    call check_colision
    cp #1
    ret z

no_colision:
    ld a, #0
ret

checkEntityCollision::

    ld     b, e_y(iy)
    ld     c, e_x(iy)

    ;; B = Coordenadas de mapa en Y, esquina superior izq del tile
    ;; C = Coordenadas de mapa en X, esquina superior izq del tile
    ld a, b_x(ix)           ;; Cordenada X de la bala - el offset en X de la cámara
    ld d, a                 ;; D = X del borde izquierdo de la bala

    ld a, c                 ;; A = X del borde izquierdo del enemigo
    add e_w(iy)             ;; A = X del borde derecho del enemigo
    dec a
    cp d                    ;; Comprobamos si el borde izquierdo de la bala
                            ;; está a la derecha del borde derecho del enemigo

    jr nc, checkLeftBorder  ;; No lo está, comprueba la izq
    jr no_colision          ;; Si lo está, no hay colisión

    checkLeftBorder:
        ld a, d             ;; A = X del borde izquierdo de la bala
        add b_w(ix)         ;; A = X del borde derecho de la bala
        dec a
        ld d, a             ;; D = X del borde derecho de la bala
        ld a, c             ;; A = X del borde izquiedo del enemigo

        cp d                ;; Comprobamos si el borde derecho de la bala, está
                            ;; a la derecha del borde izq del enemigo
    jr nc, no_colision

    ; Hay colision en X, comprobemos en Y
    ld a, b_y(ix)           ;; Coordenada Y de la bala - offset en Y de la cámara
    ld d, a                 ;; D = Y del borde superior de la bala

    ld a, b                 ;; A = Y del borde superior del enemigo
    add e_h(iy)             ;; A = Y del borde inferior del enemigo
    dec a
    cp d                    ;; Compruebo si el borde superior de la bala está
                            ;; por debajo del borde inferior del enemigo

    jr nc, checkTopBorder   ;; No está por debajo, comprueba la parte de arriba
    jr no_colision          ;; Si lo está, no hay colisión

    checkTopBorder:
        ld a, d             ;; A = Y del borde superior de la bala
        add b_h(ix)         ;; A = Y del borde inferior de la bala
        dec a
        ld d, a             ;; D = Y del borde inferior de la bala
        ld a, b             ;; A = Y del borde superior del enemigo

        cp d                ;; Comprobamos si el borde inferior de la bala está
                            ;; por encima del borde superior del enemigo
    jr nc, no_colision
    ld a, #1
ret

getUpperRightCorner::
    ld a, e_x(ix)       ;; Si mi personaje está en X = 0
        add e_w(ix)     ;; y le sumo el ancho que es 8, X = 8
        dec a           ;; que es el inicio del siguiente tile
    ld l, a             ;; por eso le resto 1, el border derecho
    ld h, e_y(ix)       ;; seria 7 realmente, [0, 7]
ret

getLowerRightCorner::
    ld a, e_x(ix)
        add e_w(ix)
        dec a
    ld l, a
    ld a, e_y(ix)
        add e_h(ix)
        dec a
    ld h, a
ret

getUpperLeftCorner::
    ld l, e_x(ix)
    ld h, e_y(ix)
ret

getLowerLeftCorner::
    ld l, e_x(ix)
    ld a, e_y(ix)
        add e_h(ix)
        dec a
    ld h, a
ret

check_colision::
    call    checkTileCollision_m
    ld a, #1
    ret z
    ld a, #0
ret