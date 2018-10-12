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



 ;;-----------------------------------------------------------------------------------------;;
 ;; Entidad enemigo por defecto
 .macro DefineEnemyDefault _name, _suf
    DefineEnemy _name'_suf, #0xAA, #0, #0, #0, #0, #0, #0, #0xFFFF, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #1           ;;'
 .endm

 ;; Definir N entidades enemigo
 .macro DefineNEnemies _name, _n
    _c = 0
    .rept _n
       DefineEnemyDefault _name, \_c
       _c = _c + 1
    .endm
 .endm

 ;; Entidad enemigo
 .macro DefineEnemy  _name, _x, _y, _w, _h, _vx, _vy, _col, _upd, _goal_flag, _goal_x, _goal_y, save_dX, save_dY, IncYr, IncXr, av, avR, avI, flag_vel
 _name:
    DefineDrawableEnt _name'_dw, _x, _y, _w, _h                       ;;'
    DefineMovableEnt  _name'_mv, _vx, _vy                             ;;'
 ;; Si no tiene sprite
    .db  _col        ;; Color
 ;; Si tiene sprite
 ;;.dw   _spr
    .dw  _upd        ;; Puntero a la funcion de update
    .db  _goal_flag  ;; 0 -> No se ha
    .db  _goal_x     ;; X de la posicion final
    .db  _goal_y     ;; Y de la posicion final

    ;;BRESENHAM
    .dw  save_dX     ;; Distancia en X del objetivo
    .dw  save_dY     ;; Distancia en Y del objetivo
    .db  IncYr       ;; Incremento recto en Y
    .db  IncXr       ;; Incremento recto en X
    .dw  av          ;; Avance
    .dw  avR         ;; Avance recto
    .dw  avI         ;; Avance inclinado
    .db  flag_vel    ;; 1 = Esta utilizando IncYi/IncXi |------------| 0 = Esta utilizando IncYr/IncXr
 ;; Aqui falta saber el tamanyo de la entidad
 en_size = . - (_name)
 .endm

 ;;;;;;;;;;;;;;;;;;;
 ;; Constantes de las entidades hero/enemy
 ;;;;;;;;;;;;;;;;;;;
       ppe_x = 0    ppe_y = 1
       pe_x = 2     pe_y = 3
      en_x = 0+4         en_y = 1+4
      en_w = 2+4         en_h = 3+4
     en_vx = 4+4        en_vy = 5+4
    en_col = 6+4
   en_up_l = 7+4      en_up_h = 8+4
 en_g_flag = 9+4
 ;;------------------------------BRESENHAM
    en_g_x = 10+4      en_g_y = 11+4
   en_dX_l = 12+4     en_dX_h = 13+4
   en_dY_l = 14+4     en_dY_h = 15+4
  en_incYr = 16+4    en_incXr = 17+4
   en_av_l = 18+4     en_av_h = 19+4
  en_avR_l = 20+4    en_avR_h = 21+4
  en_avI_l = 22+4    en_avI_h = 23+4
en_flagVel = 24+4









