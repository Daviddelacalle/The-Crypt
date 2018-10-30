;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.6.8 #9946 (Linux)
;--------------------------------------------------------
	.module p1
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _sp_hero_15
	.globl _sp_hero_14
	.globl _sp_hero_13
	.globl _sp_hero_12
	.globl _sp_hero_11
	.globl _sp_hero_10
	.globl _sp_hero_09
	.globl _sp_hero_08
	.globl _sp_hero_07
	.globl _sp_hero_06
	.globl _sp_hero_05
	.globl _sp_hero_04
	.globl _sp_hero_03
	.globl _sp_hero_02
	.globl _sp_hero_01
	.globl _sp_hero_00
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
	.area _CODE
_sp_hero_00:
	.db #0xf0	; 240
	.db #0xcc	; 204
	.db #0xc8	; 200
	.db #0xf0	; 240
	.db #0xe4	; 228
	.db #0xcc	; 204
	.db #0xcc	; 204
	.db #0xd0	; 208
	.db #0xe4	; 228
	.db #0xcc	; 204
	.db #0xcc	; 204
	.db #0xd0	; 208
	.db #0xe4	; 228
	.db #0x89	; 137
	.db #0xcc	; 204
	.db #0xd0	; 208
	.db #0x46	; 70	'F'
	.db #0x89	; 137
	.db #0x46	; 70	'F'
	.db #0x42	; 66	'B'
	.db #0xec	; 236
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0xe8	; 232
	.db #0xa1	; 161
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0xd0	; 208
	.db #0xa1	; 161
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0xd0	; 208
_sp_hero_01:
	.db #0xf0	; 240
	.db #0xcc	; 204
	.db #0xc8	; 200
	.db #0xf0	; 240
	.db #0xe4	; 228
	.db #0xcc	; 204
	.db #0xcc	; 204
	.db #0xd0	; 208
	.db #0xf4	; 244
	.db #0xcc	; 204
	.db #0xcc	; 204
	.db #0xd0	; 208
	.db #0xf4	; 244
	.db #0xec	; 236
	.db #0xcc	; 204
	.db #0xd0	; 208
	.db #0xa1	; 161
	.db #0x03	; 3
	.db #0xcc	; 204
	.db #0xd0	; 208
	.db #0xf0	; 240
	.db #0x56	; 86	'V'
	.db #0x46	; 70	'F'
	.db #0xd0	; 208
	.db #0xf0	; 240
	.db #0x03	; 3
	.db #0x42	; 66	'B'
	.db #0xf0	; 240
	.db #0xa1	; 161
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0xd0	; 208
_sp_hero_02:
	.db #0xf0	; 240
	.db #0xcc	; 204
	.db #0xc8	; 200
	.db #0xf0	; 240
	.db #0xe4	; 228
	.db #0xcc	; 204
	.db #0xcc	; 204
	.db #0xd0	; 208
	.db #0xe4	; 228
	.db #0xcc	; 204
	.db #0xdc	; 220
	.db #0xd0	; 208
	.db #0xe4	; 228
	.db #0xcc	; 204
	.db #0xfc	; 252
	.db #0xd0	; 208
	.db #0xe4	; 228
	.db #0x89	; 137
	.db #0x03	; 3
	.db #0xd0	; 208
	.db #0xe4	; 228
	.db #0x56	; 86	'V'
	.db #0x42	; 66	'B'
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0x03	; 3
	.db #0x42	; 66	'B'
	.db #0xf0	; 240
	.db #0xa1	; 161
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0xd0	; 208
_sp_hero_03:
	.db #0xf0	; 240
	.db #0xcc	; 204
	.db #0xc8	; 200
	.db #0xf0	; 240
	.db #0xe4	; 228
	.db #0xcc	; 204
	.db #0xcc	; 204
	.db #0xd0	; 208
	.db #0xe4	; 228
	.db #0xfc	; 252
	.db #0xcc	; 204
	.db #0xd0	; 208
	.db #0x46	; 70	'F'
	.db #0xfc	; 252
	.db #0xec	; 236
	.db #0x42	; 66	'B'
	.db #0x46	; 70	'F'
	.db #0x03	; 3
	.db #0x46	; 70	'F'
	.db #0x42	; 66	'B'
	.db #0xa9	; 169
	.db #0x89	; 137
	.db #0x46	; 70	'F'
	.db #0xe8	; 232
	.db #0xa1	; 161
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0xd0	; 208
	.db #0xa1	; 161
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0xd0	; 208
_sp_hero_04:
	.db #0xf0	; 240
	.db #0xf3	; 243
	.db #0xf3	; 243
	.db #0xc0	; 192
	.db #0xf1	; 241
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xe2	; 226
	.db #0xf1	; 241
	.db #0xad	; 173
	.db #0x5e	; 94
	.db #0xe2	; 226
	.db #0xf1	; 241
	.db #0xad	; 173
	.db #0x5e	; 94
	.db #0xe2	; 226
	.db #0xf1	; 241
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xe2	; 226
	.db #0xf4	; 244
	.db #0x5b	; 91
	.db #0xa7	; 167
	.db #0xe8	; 232
	.db #0xa5	; 165
	.db #0xf3	; 243
	.db #0xf3	; 243
	.db #0x4a	; 74	'J'
	.db #0xf4	; 244
	.db #0x5e	; 94
	.db #0xad	; 173
	.db #0xe8	; 232
_sp_hero_05:
	.db #0xf0	; 240
	.db #0xf1	; 241
	.db #0xf3	; 243
	.db #0xc0	; 192
	.db #0xf0	; 240
	.db #0xf3	; 243
	.db #0xfc	; 252
	.db #0xe8	; 232
	.db #0xf1	; 241
	.db #0x5b	; 91
	.db #0xfc	; 252
	.db #0xe8	; 232
	.db #0xf1	; 241
	.db #0xf3	; 243
	.db #0xfc	; 252
	.db #0xe8	; 232
	.db #0xf1	; 241
	.db #0xf6	; 246
	.db #0xfc	; 252
	.db #0xc0	; 192
	.db #0xf1	; 241
	.db #0xfc	; 252
	.db #0xf3	; 243
	.db #0xd0	; 208
	.db #0xf0	; 240
	.db #0xad	; 173
	.db #0xf9	; 249
	.db #0xe2	; 226
	.db #0xf4	; 244
	.db #0x5e	; 94
	.db #0x5e	; 94
	.db #0xe8	; 232
_sp_hero_06:
	.db #0xf0	; 240
	.db #0xf3	; 243
	.db #0xe2	; 226
	.db #0xd0	; 208
	.db #0xf4	; 244
	.db #0xfc	; 252
	.db #0xf3	; 243
	.db #0xc0	; 192
	.db #0xf4	; 244
	.db #0xfc	; 252
	.db #0xa7	; 167
	.db #0xe2	; 226
	.db #0xf4	; 244
	.db #0xfc	; 252
	.db #0xf3	; 243
	.db #0xe2	; 226
	.db #0xf0	; 240
	.db #0xfc	; 252
	.db #0xf9	; 249
	.db #0xe2	; 226
	.db #0xf0	; 240
	.db #0xf3	; 243
	.db #0xfc	; 252
	.db #0xe2	; 226
	.db #0xf1	; 241
	.db #0xf6	; 246
	.db #0x5e	; 94
	.db #0xc0	; 192
	.db #0xf4	; 244
	.db #0xad	; 173
	.db #0xad	; 173
	.db #0xe8	; 232
_sp_hero_07:
	.db #0xf0	; 240
	.db #0xf3	; 243
	.db #0xf3	; 243
	.db #0xc0	; 192
	.db #0xf1	; 241
	.db #0xa7	; 167
	.db #0x5b	; 91
	.db #0xe2	; 226
	.db #0xf1	; 241
	.db #0xa7	; 167
	.db #0x5b	; 91
	.db #0xe2	; 226
	.db #0xf4	; 244
	.db #0xa7	; 167
	.db #0x5b	; 91
	.db #0xe8	; 232
	.db #0xf4	; 244
	.db #0xa7	; 167
	.db #0x5b	; 91
	.db #0xe8	; 232
	.db #0xf4	; 244
	.db #0xad	; 173
	.db #0x5e	; 94
	.db #0xe8	; 232
	.db #0xa5	; 165
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0x4a	; 74	'J'
	.db #0xf4	; 244
	.db #0x5e	; 94
	.db #0xad	; 173
	.db #0xe8	; 232
_sp_hero_08:
	.db #0xf0	; 240
	.db #0xc5	; 197
	.db #0xca	; 202
	.db #0xd0	; 208
	.db #0xf0	; 240
	.db #0xc5	; 197
	.db #0xca	; 202
	.db #0xd0	; 208
	.db #0xe0	; 224
	.db #0xcf	; 207
	.db #0xcf	; 207
	.db #0xc0	; 192
	.db #0xe0	; 224
	.db #0xcf	; 207
	.db #0xcf	; 207
	.db #0xc0	; 192
	.db #0xe0	; 224
	.db #0xcf	; 207
	.db #0xcf	; 207
	.db #0xc0	; 192
	.db #0xe5	; 229
	.db #0xcf	; 207
	.db #0xcf	; 207
	.db #0xca	; 202
	.db #0xe0	; 224
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xb5	; 181
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x6a	; 106	'j'
_sp_hero_09:
	.db #0xf0	; 240
	.db #0xc0	; 192
	.db #0xca	; 202
	.db #0xf0	; 240
	.db #0xe0	; 224
	.db #0x6f	; 111	'o'
	.db #0xca	; 202
	.db #0xf0	; 240
	.db #0xe0	; 224
	.db #0xc5	; 197
	.db #0xcf	; 207
	.db #0xd0	; 208
	.db #0xe0	; 224
	.db #0xc0	; 192
	.db #0xc5	; 197
	.db #0xd0	; 208
	.db #0xf0	; 240
	.db #0xc0	; 192
	.db #0xc5	; 197
	.db #0xd0	; 208
	.db #0xf0	; 240
	.db #0xe0	; 224
	.db #0xc5	; 197
	.db #0xca	; 202
	.db #0xf0	; 240
	.db #0x6a	; 106	'j'
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xb5	; 181
	.db #0x6a	; 106	'j'
	.db #0xc0	; 192
	.db #0x6a	; 106	'j'
_sp_hero_10:
	.db #0xf0	; 240
	.db #0xe5	; 229
	.db #0xc0	; 192
	.db #0xd0	; 208
	.db #0xf0	; 240
	.db #0xe5	; 229
	.db #0x9f	; 159
	.db #0xc0	; 192
	.db #0xf0	; 240
	.db #0xcf	; 207
	.db #0xca	; 202
	.db #0xc0	; 192
	.db #0xf0	; 240
	.db #0xca	; 202
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xf0	; 240
	.db #0xca	; 202
	.db #0xc0	; 192
	.db #0xd0	; 208
	.db #0xe5	; 229
	.db #0xca	; 202
	.db #0xc0	; 192
	.db #0xf0	; 240
	.db #0xe0	; 224
	.db #0xc0	; 192
	.db #0x95	; 149
	.db #0xd0	; 208
	.db #0xb5	; 181
	.db #0xc0	; 192
	.db #0x95	; 149
	.db #0x6a	; 106	'j'
_sp_hero_11:
	.db #0xf0	; 240
	.db #0xca	; 202
	.db #0xc5	; 197
	.db #0xd0	; 208
	.db #0xf0	; 240
	.db #0x6a	; 106	'j'
	.db #0x95	; 149
	.db #0xd0	; 208
	.db #0xe5	; 229
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xca	; 202
	.db #0xe5	; 229
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xca	; 202
	.db #0xe0	; 224
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xe0	; 224
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xe0	; 224
	.db #0x6a	; 106	'j'
	.db #0x95	; 149
	.db #0xc0	; 192
	.db #0xb5	; 181
	.db #0x6a	; 106	'j'
	.db #0x95	; 149
	.db #0x6a	; 106	'j'
_sp_hero_12:
	.db #0xe4	; 228
	.db #0xd8	; 216
	.db #0xe4	; 228
	.db #0xd8	; 216
	.db #0xd9	; 217
	.db #0xec	; 236
	.db #0xdc	; 220
	.db #0xec	; 236
	.db #0x8d	; 141
	.db #0xf6	; 246
	.db #0xfc	; 252
	.db #0xec	; 236
	.db #0x8d	; 141
	.db #0xf6	; 246
	.db #0xfc	; 252
	.db #0xec	; 236
	.db #0x8d	; 141
	.db #0x5e	; 94
	.db #0xfc	; 252
	.db #0xec	; 236
	.db #0xe4	; 228
	.db #0x5b	; 91
	.db #0xfc	; 252
	.db #0xd8	; 216
	.db #0xf0	; 240
	.db #0x8d	; 141
	.db #0xe6	; 230
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xe4	; 228
	.db #0xd8	; 216
	.db #0xf0	; 240
_sp_hero_13:
	.db #0xe4	; 228
	.db #0xd8	; 216
	.db #0xe4	; 228
	.db #0xd8	; 216
	.db #0xc8	; 200
	.db #0xc4	; 196
	.db #0xc8	; 200
	.db #0xc4	; 196
	.db #0x99	; 153
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc4	; 196
	.db #0x99	; 153
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc4	; 196
	.db #0x99	; 153
	.db #0x62	; 98	'b'
	.db #0xc0	; 192
	.db #0xc4	; 196
	.db #0xe4	; 228
	.db #0x62	; 98	'b'
	.db #0xc0	; 192
	.db #0xd8	; 216
	.db #0xf0	; 240
	.db #0x99	; 153
	.db #0xc4	; 196
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xe4	; 228
	.db #0xd8	; 216
	.db #0xf0	; 240
_sp_hero_14:
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
_sp_hero_15:
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.area _INITIALIZER
	.area _CABS (ABS)
