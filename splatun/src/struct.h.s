;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DEFINICION DE LAS MACROS PARA LA CREACION DE ENTIDADES ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Entidad drawable
.macro DefineDrawableEnt _name, _x, _y, _w, _h
_name:
   .db   #0, #0
   .db   #0, #0
   .db   _x, _y      ;; Posicion    (x,y)
   .db   _w, _h      ;; Dimensiones (w,h)
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
   DefineMovableEnt  _name'_mv, _vx, _vy                             ;;'
;; Si no tiene sprite
   .db   _col        ;; Color
;; Si tiene sprite
;;.dw   _spr
   .dw   _upd        ;; Puntero a la funcion de update

;; Aqui falta saber el tamanyo de la entidad
e_size = . - (_name)
.endm

;;;;;;;;;;;;;;;;;;;
;; Constantes de las entidades hero/enemy
;;;;;;;;;;;;;;;;;;;
 ppe_x = 0    ppe_y = 1
  pe_x = 2     pe_y = 3
   e_x = 0+4      e_y = 1+4
   e_w = 2+4      e_h = 3+4
  e_vx = 4+4     e_vy = 5+4
 e_col = 6+4
e_up_l = 7+4   e_up_h = 8+4

;;-----------------------------------------------------------------------------------------;;
;; Entidad bullet
.macro DefineBullet  _name, _x, _y, _w, _h, _vx, _vy, _col, _alive, _upd
_name:
   DefineDrawableEnt _name'_dw, _x, _y, _w, _h                       ;;'
   DefineMovableEnt  _name'_mv, _vx, _vy                             ;;'
   .db   _col        ;; Color / Sprite (cuando haya)
   .db   _alive      ;; _alive>0? Se actualiza/dibuja
   .dw   _upd        ;; Funcion de update

;; Saber tamanyo de entidad bala
.endm

;; Entidad por defecto de bullet
.macro DefineBulletDefault _name, _suf
   DefineBullet _name'_suf, 0xAA, 0, 0, 0, 0, 0, 0, 0, 0xFFFF        ;;'
.endm

;; Bucle de crear entidades bullet
.macro DefineNBullets _name, _n
   _c = 0
   .rept _n
      DefineBulletDefault _name, \_c
      _c = _c + 1
   .endm
.endm

;;;;;;;;;;;;;;;;;;;
;; Constantes de las entidades bullet
;;;;;;;;;;;;;;;;;;;
    b_x = 0+4      b_y = 1+4
    b_w = 2+4      b_h = 3+4
   b_vx = 4+4     b_vy = 5+4
  b_col = 6+4  b_alive = 7+4
 b_up_l = 8+4   b_up_h = 9+4














