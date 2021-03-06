;##-----------------------------LICENSE NOTICE------------------------------------
;##  This file is part of THE CRYPT
;##
;##  This game is free software: you can redistribute it and/or modify
;##  it under the terms of the GNU Lesser General Public License as published by
;##  the Free Software Foundation, either version 3 of the License, or
;##  (at your option) any later version.
;##
;##  This game is distributed in the hope that it will be useful,
;##  but WITHOUT ANY WARRANTY; without even the implied warranty of
;##  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;##  GNU Lesser General Public License for more details.
;##
;##  You should have received a copy of the GNU Lesser General Public License
;##  along with this program.  If not, see <http://www.gnu.org/licenses/>.
;##------------------------------------------------------------------------------

SEED == 2340

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
LEFT    == 18
RIGHT   == ScreenSizeX-LEFT
TOP     == 44
BOTTOM  == ScreenSizeY-TOP

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






