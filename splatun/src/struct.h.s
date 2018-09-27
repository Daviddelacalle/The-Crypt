;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DEFINICION DE LAS MACROS PARA LA CREACION DE ENTIDADES ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Entidad drawable
.macro DefineDrawableEnt _name, _x, _y, _w, _h
_name:
   .db   _x, _y      ;; Posicion    (x,y)
   .db   _w, _h      ;; Dimensiones (w,h)

;; Aqui falta saber el tamanyo de la entidad
.endm

;; Entidad heroe/enemigo
.macro DefineEntity _name, _x, _y, _w, _h, _vx, _vy, _col, _upd
_name:
   DefineDrawableEnt _name'_dw, _x, _y, _w, _h                    ;;'
   .db   _vx, _vy    ;; Variables de la velocidad
;; Si no tiene sprite
   .db   _col        ;; Color
;; Si tiene sprite
;;.dw   _spr
   .dw   _upd        ;; Puntero a la funcion de update

;; Aqui falta saber el tamanyo de la entidad
.endm

;;;;;;;;;;;;;;;;;;;
;; Constantes
;;;;;;;;;;;;;;;;;;;
   _x = 0      _y = 1
   _w = 2      _h = 3
  _vx = 4     _vy = 5
 _col = 6
_up_l = 7   _up_h = 8