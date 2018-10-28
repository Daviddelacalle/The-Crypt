.include "struct.h.s"

HEARTS_UPDATE::
    ;; Actualizo corasones
    call dw_drawHearts
    call swapBuffers
    call dw_drawHearts
    call swapBuffers
ret

handleEnemyDeath::
    ld en_alv(iy), #0

    ld a, (NumberOfEnemies)
    dec a
    ld (NumberOfEnemies), a
    cp #0
    call z, openTeleporter

    cp #k_max_enemies

    ret c
    call spawnEnemies
ret