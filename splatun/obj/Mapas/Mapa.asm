;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.6.8 #9946 (Linux)
;--------------------------------------------------------
	.module Mapa
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _nivel1
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
_nivel1:
	.db #0x07	; 7
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x0a	; 10
	.db #0x12	; 18
	.db #0x12	; 18
	.db #0x12	; 18
	.db #0x12	; 18
	.db #0x0a	; 10
	.db #0x12	; 18
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x12	; 18
	.db #0x13	; 19
	.db #0x13	; 19
	.db #0x13	; 19
	.db #0x13	; 19
	.db #0x13	; 19
	.db #0x13	; 19
	.db #0x13	; 19
	.db #0x13	; 19
	.db #0x13	; 19
	.db #0x13	; 19
	.db #0x13	; 19
	.db #0x12	; 18
	.db #0x13	; 19
	.db #0x12	; 18
	.db #0x13	; 19
	.db #0x13	; 19
	.db #0x13	; 19
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x16	; 22
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x15	; 21
	.db #0x1a	; 26
	.db #0x1a	; 26
	.db #0x1a	; 26
	.db #0x1a	; 26
	.db #0x1a	; 26
	.db #0x1a	; 26
	.db #0x1a	; 26
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x15	; 21
	.db #0x1a	; 26
	.db #0x1a	; 26
	.db #0x1a	; 26
	.db #0x1a	; 26
	.db #0x1a	; 26
	.db #0x1a	; 26
	.db #0x1a	; 26
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x15	; 21
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x28	; 40
	.db #0x28	; 40
	.db #0x28	; 40
	.db #0x1a	; 26
	.db #0x1a	; 26
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x15	; 21
	.db #0x27	; 39
	.db #0x27	; 39
	.db #0x28	; 40
	.db #0x29	; 41
	.db #0x28	; 40
	.db #0x1a	; 26
	.db #0x1a	; 26
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x15	; 21
	.db #0x1a	; 26
	.db #0x1a	; 26
	.db #0x28	; 40
	.db #0x28	; 40
	.db #0x15	; 21
	.db #0x1a	; 26
	.db #0x1a	; 26
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x15	; 21
	.db #0x1a	; 26
	.db #0x1a	; 26
	.db #0x1a	; 26
	.db #0x1a	; 26
	.db #0x1a	; 26
	.db #0x1a	; 26
	.db #0x1a	; 26
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x07	; 7
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x15	; 21
	.db #0x1a	; 26
	.db #0x1a	; 26
	.db #0x1a	; 26
	.db #0x1a	; 26
	.db #0x1a	; 26
	.db #0x1a	; 26
	.db #0x1a	; 26
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x07	; 7
	.db #0x13	; 19
	.db #0x13	; 19
	.db #0x38	; 56	'8'
	.db #0x13	; 19
	.db #0x38	; 56	'8'
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x07	; 7
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x07	; 7
	.db #0x34	; 52	'4'
	.db #0x34	; 52	'4'
	.db #0x34	; 52	'4'
	.db #0x34	; 52	'4'
	.db #0x34	; 52	'4'
	.db #0x34	; 52	'4'
	.db #0x34	; 52	'4'
	.db #0x34	; 52	'4'
	.db #0x34	; 52	'4'
	.db #0x34	; 52	'4'
	.db #0x34	; 52	'4'
	.db #0x07	; 7
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x07	; 7
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x07	; 7
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x07	; 7
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x07	; 7
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x07	; 7
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x07	; 7
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x07	; 7
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x07	; 7
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x3d	; 61
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x07	; 7
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x07	; 7
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x38	; 56	'8'
	.db #0x3d	; 61
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x13	; 19
	.db #0x13	; 19
	.db #0x13	; 19
	.db #0x37	; 55	'7'
	.db #0x37	; 55	'7'
	.db #0x37	; 55	'7'
	.db #0x13	; 19
	.db #0x13	; 19
	.db #0x07	; 7
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x07	; 7
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x3d	; 61
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x07	; 7
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x07	; 7
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x3d	; 61
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x3b	; 59
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x07	; 7
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x3d	; 61
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x0a	; 10
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x07	; 7
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x3d	; 61
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x0a	; 10
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x07	; 7
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x07	; 7
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x07	; 7
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x07	; 7
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x2c	; 44
	.db #0x34	; 52	'4'
	.db #0x34	; 52	'4'
	.db #0x34	; 52	'4'
	.db #0x34	; 52	'4'
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x0a	; 10
	.db #0x0b	; 11
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x13	; 19
	.db #0x0a	; 10
	.db #0x0b	; 11
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0b	; 11
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0b	; 11
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x34	; 52	'4'
	.db #0x34	; 52	'4'
	.db #0x34	; 52	'4'
	.db #0x34	; 52	'4'
	.db #0x34	; 52	'4'
	.db #0x34	; 52	'4'
	.db #0x34	; 52	'4'
	.db #0x34	; 52	'4'
	.db #0x34	; 52	'4'
	.db #0x34	; 52	'4'
	.db #0x34	; 52	'4'
	.db #0x34	; 52	'4'
	.db #0x34	; 52	'4'
	.db #0x34	; 52	'4'
	.db #0x34	; 52	'4'
	.db #0x34	; 52	'4'
	.db #0x34	; 52	'4'
	.db #0x34	; 52	'4'
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.db #0x15	; 21
	.area _INITIALIZER
	.area _CABS (ABS)
