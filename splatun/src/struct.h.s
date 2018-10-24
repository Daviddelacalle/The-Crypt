;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DEFINICION DE LAS MACROS PARA LA CREACION DE ENTIDADES ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Entidad drawable
.macro DefineDrawableEnt _name, _x, _y, _w, _h
_name:
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
   DefineEntity _name'_suf, 0xAA, 0, 0, 0, 0, 0, 0x0000, 0xFFFF           ;;'
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
.macro DefineEntity  _name, _x, _y, _w, _h, _vx, _vy, _spr, _upd
_name:
    DefineDrawableEnt _name'_dw, _x, _y, _w, _h                       ;;'
    DefineMovableEnt  _name'_mv, _vx, _vy                             ;;'
;; Si tiene sprite
    .dw   _spr
    .dw   _upd        ;; Puntero a la funcion de update

;; Aqui falta saber el tamanyo de la entidad
e_size = . - (_name)
.endm

;;;;;;;;;;;;;;;;;;;
;; Constantes de las entidades hero/enemy
;;;;;;;;;;;;;;;;;;;
    e_x = 0      e_y = 1
    e_w = 2      e_h = 3
   e_vx = 4     e_vy = 5
e_spr_l = 6  e_spr_h = 7
 e_up_l = 8   e_up_h = 9


;;-----------------------------------------------------------------------------------------;;
;; Entidad bullet
.macro DefineBullet  _name, _x, _y, _w, _h, _vx, _vy, _spr, _alive, _upd
_name:
   DefineDrawableEnt _name'_dw, _x, _y, _w, _h                       ;;'
   DefineMovableEnt  _name'_mv, _vx, _vy                             ;;'
   .dw   _spr        ;; Color / Sprite (cuando haya)
   .db   _alive      ;; _alive>0? Se actualiza/dibuja
   .dw   _upd        ;; Funcion de update

;; Saber tamanyo de entidad bala
b_size = . - (_name)
.endm

;; Entidad por defecto de bullet
.macro DefineBulletDefault _name, _suf
   DefineBullet _name'_suf, 0xAA, 0, 0, 0, 0, 0, 0x0000, 0, 0xFFFF        ;;'
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
     b_x = 0      b_y = 1
     b_w = 2      b_h = 3
    b_vx = 4     b_vy = 5
 b_spr_l = 6  b_spr_h = 7
 b_alive = 8
  b_up_l = 9   b_up_h = 10



 ;;-----------------------------------------------------------------------------------------;;
 ;; Entidad enemigo por defecto
 .macro DefineEnemyDefault _name, _suf
    DefineEnemy _name'_suf, #0xAA, #0, #0, #0, #0, #0, #0x0000, #0xFFFF, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #1, #1           ;;'
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
 .macro DefineEnemy  _name, _x, _y, _w, _h, _vx, _vy, _spr, _upd, _goal_flag, _goal_x, _goal_y, save_dX, save_dY, IncYr, IncXr, av, avR, avI, flag_vel, alive
 _name:
    DefineDrawableEnt _name'_dw, _x, _y, _w, _h                       ;;'
    DefineMovableEnt  _name'_mv, _vx, _vy                             ;;'
 ;; Si tiene sprite
    .dw  _spr
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
    .db  alive
 ;; Aqui falta saber el tamanyo de la entidad
 en_size = . - (_name)
 .endm

 ;;;;;;;;;;;;;;;;;;;
 ;; Constantes de las entidades hero/enemy
 ;;;;;;;;;;;;;;;;;;;

      en_x = 0         en_y = 1
      en_w = 2         en_h = 3
     en_vx = 4        en_vy = 5
  en_spr_l = 6     en_spr_h = 7
   en_up_l = 8      en_up_h = 9
 en_g_flag = 10
 ;;------------------------------BRESENHAM
    en_g_x = 11      en_g_y = 12
   en_dX_l = 13     en_dX_h = 14
   en_dY_l = 15     en_dY_h = 16
  en_incYr = 17    en_incXr = 18
   en_av_l = 19     en_av_h = 20
  en_avR_l = 21    en_avR_h = 22
  en_avI_l = 23    en_avI_h = 24
en_flagVel = 25      en_alv = 26









