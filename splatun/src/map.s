.area _DATA
.area _CODE

.include "struct.h.s"
.include "drawable.h.s"

CameraMinMax::
    .db #0, #0 ;Min X, Min Y

cam_min_x = 0
cam_max_x = 1
cam_min_y = 2
cam_max_y = 3


DefineEntity _obs, #10, #10, 0x04, 0x08, 0x00, 0x00, 0xFF, 0x0000


;Disrupción alienígeca
obs_draw::
    ld ix, #_obs
    jp dw_draw

obs_clear::
    ld ix, #_obs
    jp dw_clear

