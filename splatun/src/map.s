.area _DATA
.area _CODE

.include "struct.h.s"
.include "drawable.h.s"
.include "map.h.s"

CameraMinMax::
    .db #0, #0 ;Min X, Min Y


DefineEntity _obs, #10, #10, 0x04, 0x08, 0x00, 0x00, 0xFF, 0x0000


;Disrupción alienígeca
obs_draw:
    ld ix, #_obs
    jp dw_draw

obs_clear:
    ld ix, #_obs
    jp dw_clear

move_camera_right:
    ld a, (CameraMinMax)
    inc a
    ld (CameraMinMax), a
ret

move_camera_left:
    ld a, (CameraMinMax)
    dec a
    ld (CameraMinMax), a
ret

move_camera_up:
    ld a, (CameraMinMax+1)
    ld b, #2
    sub b
    ld (CameraMinMax+1), a
ret

move_camera_down:
    ld a, (CameraMinMax+1)
    ld b, #2
    add b
    ld (CameraMinMax+1), a
ret

