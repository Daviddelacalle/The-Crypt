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

    push af

    call dw_drawAndUpdateHUDEnemies
    call swapBuffers
    call dw_drawAndUpdateHUDEnemies
    call swapBuffers

    pop af
    cp #k_max_enemies

    ret  c
    call spawnEnemies


ret

resetTilemap::
    ld hl, #_g_00
    ld c, #VIEWPORT_WIDTH
    ld b, #VIEWPORT_HEIGHT
    ld de, #30
    call cpct_etm_setDrawTilemap4x8_ag_asm
ret


;;===============================================
;;  Waits for any key to be pressed. After that
;;  it jumps to the memory position stored in HL
;;  INPUT:  DE => Memory to jump when a
;;                key is pressed
;;  DESTROYS:   AF, BC, DE, HL
;;===============================================
waitInput::
    push de
        call cpct_nextRandom_mxor_u8_asm
        push hl
            call cpct_scanKeyboard_asm
            call cpct_isAnyKeyPressed_asm
        pop hl
    pop de
    jr z, waitInput
    ex de, hl
    jp (hl)
ret

drawImagePortion::
    ld a, (back_buffer)
    ld h, a
    ld l, #0x00
    add hl, de
    ex de, hl
    DIPwidth == . + 1
    ld c, #20
    DIPheight == . + 1
    ld b, #91
    ld hl,#decompress_buffer
    call cpct_drawSprite_asm  ;; Inicio del buffer de descompresión
ret

;;======================================
;;  Wait D before proceed
;;  INPUT: D => Time
;;  If you divide D by 4, you'll get
;;  seconds mesurement approximately
;;======================================
setTimeOut::
    WaitB:
        ld e, #0xFF
        Timeout:
            call cpct_waitVSYNC_asm
            dec e
        jr nz, Timeout
        dec d
    jr nz, WaitB
ret

