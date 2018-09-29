;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; MODELO PARA CADA ARCHIVO .s QUE SE CREE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; TODO:
;;    - Copiado de entidades?

.area _DATA
.area _CODE

.include "cpctelera.h.s"
.include "struct.h.s"
.include "drawable.h.s"
.include "hero.h.s"

;;======================================================================
;;======================================================================
;; DATOS PRIVADOS
;;======================================================================
;;======================================================================
vector_size = 2
bullet_size = 10                    ;; Debe de ser parametrizado, CUANTO ANTES!

vector_index:  .dw #0x0000
vector_init:                        ;; Marca el inicio de vector_bullets
DefineNBullets vector_bullets, vector_size
DefineBullet bullet_copy 20, 20, 1, 1, 1, 1, #0xFF, #1, bullet_checkUpdate

save_a:        .db #0x00            ;; Guarda el valor de A
flag_init:     .db #0x00            ;; if(flag_init==1) Hay una entidad bullet que se ha inicializado
;;======================================================================
;;======================================================================
;; FUNCIONES PUBLICAS
;;======================================================================
;;======================================================================

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DIBUJADO DE LA ENTIDAD BULLET
;; _______________________
;; DESTRUYE: HL
;;;;;;;;;;;;;;;;;;;;;;;;;;;
bullet_draw::
   ld    hl,   #bullet_checkDraw
   jp    bullet_search              ;; Llamada al bucle

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; INICIALIZA UNA ENTIDAD BULLET
;; _______________________
;; DESTRUYE: HL
;;;;;;;;;;;;;;;;;;;;;;;;;;;
bullet_init::
   ld    hl,   #bullet_checkInit
   call   bullet_search             ;; Llamada al bucle

   ld     a,   #0                   ;; Reset de flag_init
   ld (flag_init), a                ;; flag_init = 0
   ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; UPDATE DE TODAS LAS BALAS INICIALIZADAS
;; _______________________
;; DESTRUYE: HL
;;;;;;;;;;;;;;;;;;;;;;;;;;;
bullet_update::
   ld    hl,   #bullet_checkUpdate
   call bullet_search               ;; Llamada al bucle
   ret

;;======================================================================
;;======================================================================
;; FUNCIONES PRIVADAS
;;======================================================================
;;======================================================================

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; RECORRE vector_bullets
;; _______________________
;; ENTRADA:    HL -> Puntero a funcion custom
;; DESTRUYE:   A, DE, IX
;;;;;;;;;;;;;;;;;;;;;;;;;;;
bullet_search:
   ld     a,   #0                ;; Cargo en A el valor inicial 0
   ld    ix,   #vector_init      ;; IX apunta al inicio de vector_bullets (a la primera entidad)
   ld    (f_custom), hl          ;; Cargo en el call de abajo la funcion a la que quiero llamar en cada momento determinado
   search_loop:
      ld (save_a),  a            ;; Guardo el valor de A, porque la llamada a la funcion puede destruirlo

      f_custom = . +1                  ;; . apunta a 'call' y con el '+1' apunta a '(0x0000)' -> (valor arbitrario, puesto que siempre va a cambiar)
      call (0x0000)                    ;; Llamada a funcion personalizable

      ld    de,   #bullet_size         ;; Cargo en DE el tamanyo de la entidad bullet para despues sumarlo a HL
      add   ix,   de                   ;; IX + DE = Apunta a la siguiente entidad bullet

      ld     a,   (save_a)             ;; Recupero el valor de a
      inc    a                         ;; A++
   cp #vector_size
   jr nz, search_loop
   ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; COMPROBAR SI EN LA ENTIDAD BULLET alive > 0
;; _______________________
;; ENTRADA:    IX -> Puntero a entidad BULLET
;; DESTRUYE:   A
;;;;;;;;;;;;;;;;;;;;;;;;;;;
bullet_checkDraw:
   ld     a,   b_alive(ix)       ;; Cargo el valor de alive en A
   cp    #0                      ;; Si el valor es 0 y le resto 0 -> Z=1
   call  nz,   #dw_draw          ;; Llama a la funcion de dibujado
   ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; COMPROBAR SI EN LA ENTIDAD BULLET alive = 0
;; _______________________
;; ENTRADA:    IX -> Puntero a entidad BULLET
;; DESTRUYE:   A, HL, DE, BC
;;;;;;;;;;;;;;;;;;;;;;;;;;;
bullet_checkInit:
   ld     a,   (flag_init)       ;; Si no se ha iniciado ninguna entidad bullet A==0
   cp    #0
   ret   nz                      ;; Si es 1 (1!=0), vuelve y no inicia mas entidades

   ;; Comprueba el atributo alive
   ld     a,   b_alive(ix)       ;; Cargo el valor de alive en A
   cp    #0                      ;; Si el valor es 0 y le resto 0 -> Z=1 -> INICIALIZO
   ret   nz                      ;; Si ya esta inicializada, hago ret

   ;; REALIZA UNA COPIA DE LA ENTIDAD POR DEFECTO -> DefineBullet bullet_copy 20, 20, 1, 1, 1, 1, #0xFF, #1, bullet_checkUpdate
   push  ix                      ;; Guardo IX en la pila
   pop   de                      ;; Entidad DESTINO
   ld    hl,   #bullet_copy      ;; Entidad ORIGEN
   ld    bc,   #bullet_size      ;; Tamanyo de la entidad
   ldir

   ;; Si debo cambiar algo de la entidad, aqui
   call hero_get_position        ;; A = hero_x // B = hero_y
   ld    b_x(ix), a              ;; Asigno X
   ld    b_y(ix), b              ;; Asigno Y

   ld     a,   #1                ;; flag_init = 1
   ld (flag_init), a             ;; YA NO SE PODRA INICIALIZAR NINGUNA ENTIDAD MAS
                                 ;;   EN EL RECORRIDO DE ESTE BUCLE, AHORA MISMO
   ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; COMPROBAR SI EN LA ENTIDAD BULLET alive > 0 Y LO ACTUALIZO
;; _______________________
;; ENTRADA:    IX -> Puntero a entidad BULLET
;; DESTRUYE:
;;;;;;;;;;;;;;;;;;;;;;;;;;;
bullet_checkUpdate:
   ld     a,   b_alive(ix)       ;; Si se ha inicializado la entidad, a > 0
   cp    #0
   ret    z                      ;; Si Z==1 la entidad no ha sido inicializada

   ;; UPDATE ALIVE
   ;; Decrementar el valor de alive y si llega a 1 matar la bala -> alive = 0

   ;; UPDATE POSICION
   ld     a,   b_x(ix)           ;; Cargo en A la posicion en X
   add b_vx(ix)                  ;; Le aumento la velocidad en X
   ld  b_x(ix), a                ;; Guardo el dato actualizado

   ld     a,   b_y(ix)           ;; Cargo en A la posicion en Y
   add b_vy(ix)                  ;; Le aumento la velocidad en Y
   ld  b_y(ix), a                ;; Guardo el dato actualizado

   ret



















