;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; MODELO PARA CADA ARCHIVO .s QUE SE CREE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.area _DATA
.area _CODE

.include "cpctelera.h.s"
.include "struct.h.s"
.include "drawable.h.s"

;;======================================================================
;;======================================================================
;; DATOS PRIVADOS
;;======================================================================
;;======================================================================
vector_size = 2
bullet_size = 10                    ;; Debe de ser parametrizado, CUANTO ANTES!

vector_index: .dw #0x0000
vector_init:                        ;; Marca el inicio de vector_bullets
DefineNBullets vector_bullets, vector_size

;;======================================================================
;;======================================================================
;; FUNCIONES PUBLICAS
;;======================================================================
;;======================================================================

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DIBUJADO DE LA ENTIDAD BULLET
;;;;;;;;;;;;;;;;;;;;;;;;;;;
bullet_draw::
   ;; Recorrer vector_bullets
   call bullet_search
   ret                     ;; OPTIMIZAR


;;======================================================================
;;======================================================================
;; FUNCIONES PRIVADAS
;;======================================================================
;;======================================================================

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; RECORRE vector_bullets
;; _______________________
;; DESTRUYE: A, HL, DE, IX
;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; NOTA: IGUAL HAY QUE CAMBIAR EL REGISTRO IX POR EL IY PARA NO
bullet_search:
   ld     a,   #0                ;; Cargo en A el valor inicial 0
   ld    hl,   #vector_init      ;; HL apunta al inicio de vector_bullets
   ld    de,   #bullet_size      ;; Cargo en DE el tamanyo de la entidad bullet para despues sumarlo a HL
   search_loop:
      ld    (vector_index),   hl       ;; Guardo donde apunta HL para despues cargaroa en IX
      ld    ix,   (vector_index)       ;; Para tratar la bala, la cargo en el registro IX

      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      ;; AHORA PUEDO HACER LO QUE ME DE LA GANA CON IX ;;
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

      add   hl,   de                   ;; HL + DE = Apunta a la siguiente entidad bullet
      inc a                            ;; A++
   cp #vector_size
   jr nz, search_loop
   ret










