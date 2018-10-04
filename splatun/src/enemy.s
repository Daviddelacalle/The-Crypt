;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ENTIDAD ENEMIGO
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
enemy_size = e_size           ;; Tamanyo parametrizado
k_max_enemies = 1

DefineEntity enemy_copy, #10, #10, #1, #4, #0, #0, #0x0F, #enemy_randomGoal

vector_init:                  ;; Etiqueta de inicio del vector
DefineNEntities enemy, k_max_enemies
vector_end:    .db #0xFF      ;; Indico 0xFF como fin del vector

;;======================================================================
;;======================================================================
;; FUNCIONES PUBLICAS
;;======================================================================
;;======================================================================
;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; COPIA LOS ENEMIGOS DEL BUCLE CON UNA ENTIDAD "MODELO"
;; _______________________
;; DESTRUYE:   HL
;;;;;;;;;;;;;;;;;;;;;;;;;;;
enemy_create::
   ld hl, #enemy_init
   jp enemy_search

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ASIGNA LA FUNCION DE DIBUJADO EN HL Y RECORRE EL BUCLE
;; _______________________
;; DESTRUYE:   HL
;;;;;;;;;;;;;;;;;;;;;;;;;;;
enemy_draw_ALL::
   ld hl, #dw_draw
   jp enemy_search

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ASIGNA LA FUNCION DE CLEAR EN HL Y RECORRE EL BUCLE
;; _______________________
;; DESTRUYE:   HL
;;;;;;;;;;;;;;;;;;;;;;;;;;;
enemy_clear_ALL::
   ld hl, #dw_clear
   jp enemy_search

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ASIGNA LA FUNCION DE UPDATE EN HL Y RECORRE EL BUCLE
;; _______________________
;; DESTRUYE:   HL
;;;;;;;;;;;;;;;;;;;;;;;;;;;
enemy_update_ALL::
   ld hl, #enemy_update
   jp enemy_search

;;======================================================================
;;======================================================================
;; FUNCIONES PRIVADAS
;;======================================================================
;;======================================================================
;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; RECORRE EL BUCLE DE ENEMIGOS
;; _______________________
;; ENTRADA:    HL -> Puntero a funcion custom
;; DESTRUYE:   A, DE, IX
;;;;;;;;;;;;;;;;;;;;;;;;;;;
enemy_search:
   ld    ix,   #vector_init      ;; IX apunta al inicio de vector_bullets (a la primera entidad)
   ld    (f_custom), hl          ;; Cargo en el call de abajo la funcion a la que quiero llamar en cada momento determinado
   search_loop:
      ld     a,   0(ix)                ;; Compruebo que no he llegado al final del vector
      cp    #0xFF                      ;; A - 0xFF
      ret    z                         ;; if(A==0xFF) -> Sale del vector

      f_custom = . +1                  ;; . apunta a 'call' y con el '+1' apunta a '(0x0000)' -> (siempre va a cambiar)
      call (0x0000)                    ;; LLAMADA A FUNCION PERSONALIZABLE
      ld    de,   #enemy_size          ;; Cargo en DE el tamanyo de la entidad bullet para despues sumarlo a HL
      add   ix,   de                   ;; IX + DE = Apunta a la siguiente entidad bullet
   jr search_loop

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; COPIA LA ENTIDAD EN IX CON EL ENEMIGO POR DEFECTO
;; _______________________
;; ENTRADA:    IX -> Puntero a entidad enemigo del bucle
;;;;;;;;;;;;;;;;;;;;;;;;;;;
enemy_init:
   push  ix                ;; El valor de IX va a la pila
   pop   de                ;; DE ahora tiene el valor de IX
   ld    hl, #enemy_copy   ;; HL apunta al destino de la copia
   ld    bc, #enemy_size   ;; BC tiene el tamanyo del enemigo
   ldir                    ;; ELEDIR
   ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; LLAMA A LA FUNCION PROPIA DE UPDATE DE CADA ENEMIGO
;; _______________________
;; ENTRADA:    IX -> Puntero a entidad enemigo del bucle
;;;;;;;;;;;;;;;;;;;;;;;;;;;
enemy_update:
   ld    l, e_up_l(ix)     ;; Cargo el byte bajo en L
   ld    h, e_up_h(ix)     ;; Cargo el byte alto en H
   jp    (hl)              ;; Llamo a la funcion

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; BUSCA UN PUNTO ALEATORIO PARA IR HACIA ALLI
;; _______________________
;; ENTRADA:    IX -> Puntero a entidad enemigo del bucle
;;;;;;;;;;;;;;;;;;;;;;;;;;;
enemy_randomGoal:
   call cpct_getRandom_mxor_u8_asm        ;; Lo devuelve en L
   
   ret





















