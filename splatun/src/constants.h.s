K_HERO_LIVES == 5

INIT_X == #12
INIT_Y == #64

VIEWPORT_WIDTH == 16
VIEWPORT_HEIGHT == 16

LimitRight == 30 - VIEWPORT_WIDTH
LimitDown  == 30 - VIEWPORT_HEIGHT

ScreenSizeX = 16*4
ScreenSizeY = 16*8
;;X = Width * 4 / 4 <~ Múltiplo de 4
;;Y = Height * 8 / 4 <~ Múltiplo de 6
LEFT    == 12
RIGHT   == ScreenSizeX-12
TOP     == 32
BOTTOM  == ScreenSizeY-32

MAP_WIDTH == 30
MAP_HEIGHT == 30

;; Offset para lo del tamaño de cámara adaptable
OFFSET_CAMERA_POS_X == 2          ;; De tile
OFFSET_CAMERA_POS_Y == 4          ;; De tile

OFFSET_CAMERA_POS_X_PANT == 4*OFFSET_CAMERA_POS_X     ;; De pantalla
OFFSET_CAMERA_POS_Y_PANT == 8*OFFSET_CAMERA_POS_Y     ;; De pantalla


;      0  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15
;0  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19
;      |                                            |
;      |           X                    X           |
;      |                                            |
;      |                                            |



;   00
;   01
;   02
;   03
; 0 04 ——————————————————————————————————————————————
; 1 05
; 2 06
; 3 07
; 4 08
; 5 09          X
; 6 10
; 7 11
; 8 12
; 9 13
;10 14          X
;11 15
;12 16
;13 17
;14 18
;15 19 ——————————————————————————————————————————————
;   20
;   21
;   22
;   23
;   24






