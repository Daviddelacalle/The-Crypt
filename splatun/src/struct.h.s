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

;; Entidad movable
.macro DefineMovableEnt _name, _vx, _vy
_name:
   .db   _vx, _vy    ;; Variables de la velocidad
.endm

;; Entidad por defecto
.macro DefineEntityDefault _name, _suf
   DefineEntity _name'_suf, 0xAA, 0, 0, 0, 0, 0, 0, 0xFFFF           ;;'
.endm

;; Definir N entidades
.macro DefineNEntities _name, _n
   _c = 0
      .rept _n
         DefineEntityDefault _name, \_c
      _c = _c + 1
   .endm
.endm

;; Entidad heroe/enemigo
.macro DefineEntity  _name, _x, _y, _w, _h, _vx, _vy, _col, _upd
_name:
   DefineDrawableEnt _name'_dw, _x, _y, _w, _h                       ;;'
   DefineMovableEnt _name'_mv, _vx, _vy                               ;;'
;; Si no tiene sprite
   .db   _col        ;; Color
;; Si tiene sprite
;;.dw   _spr
   .dw   _upd        ;; Puntero a la funcion de update

;; Aqui falta saber el tamanyo de la entidad
_sizeEnt = . - (_name) - 1
.endm

;;;;;;;;;;;;;;;;;;;
;; Constantes
;;;;;;;;;;;;;;;;;;;
   _x = 0      _y = 1
   _w = 2      _h = 3
  _vx = 4     _vy = 5
 _col = 6
_up_l = 7   _up_h = 8