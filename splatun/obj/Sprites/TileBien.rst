                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : free open source ANSI-C Compiler
                              3 ; Version 3.6.8 #9946 (Linux)
                              4 ;--------------------------------------------------------
                              5 	.module TileBien
                              6 	.optsdcc -mz80
                              7 	
                              8 ;--------------------------------------------------------
                              9 ; Public variables in this module
                             10 ;--------------------------------------------------------
                             11 	.globl _g_7
                             12 	.globl _g_6
                             13 	.globl _g_5
                             14 	.globl _g_4
                             15 	.globl _g_3
                             16 	.globl _g_2
                             17 	.globl _g_1
                             18 	.globl _g_0
                             19 ;--------------------------------------------------------
                             20 ; special function registers
                             21 ;--------------------------------------------------------
                             22 ;--------------------------------------------------------
                             23 ; ram data
                             24 ;--------------------------------------------------------
                             25 	.area _DATA
                             26 ;--------------------------------------------------------
                             27 ; ram data
                             28 ;--------------------------------------------------------
                             29 	.area _INITIALIZED
                             30 ;--------------------------------------------------------
                             31 ; absolute external ram data
                             32 ;--------------------------------------------------------
                             33 	.area _DABS (ABS)
                             34 ;--------------------------------------------------------
                             35 ; global & static initialisations
                             36 ;--------------------------------------------------------
                             37 	.area _HOME
                             38 	.area _GSINIT
                             39 	.area _GSFINAL
                             40 	.area _GSINIT
                             41 ;--------------------------------------------------------
                             42 ; Home
                             43 ;--------------------------------------------------------
                             44 	.area _HOME
                             45 	.area _HOME
                             46 ;--------------------------------------------------------
                             47 ; code
                             48 ;--------------------------------------------------------
                             49 	.area _CODE
                             50 	.area _CODE
   3418                      51 _g_0:
   3418 FC                   52 	.db #0xfc	; 252
   3419 EC                   53 	.db #0xec	; 236
   341A DC                   54 	.db #0xdc	; 220
   341B FC                   55 	.db #0xfc	; 252
   341C FC                   56 	.db #0xfc	; 252
   341D DC                   57 	.db #0xdc	; 220
   341E EC                   58 	.db #0xec	; 236
   341F FC                   59 	.db #0xfc	; 252
   3420 FC                   60 	.db #0xfc	; 252
   3421 EC                   61 	.db #0xec	; 236
   3422 DC                   62 	.db #0xdc	; 220
   3423 FC                   63 	.db #0xfc	; 252
   3424 FC                   64 	.db #0xfc	; 252
   3425 DC                   65 	.db #0xdc	; 220
   3426 EC                   66 	.db #0xec	; 236
   3427 FC                   67 	.db #0xfc	; 252
   3428 FC                   68 	.db #0xfc	; 252
   3429 EC                   69 	.db #0xec	; 236
   342A DC                   70 	.db #0xdc	; 220
   342B FC                   71 	.db #0xfc	; 252
   342C FC                   72 	.db #0xfc	; 252
   342D DC                   73 	.db #0xdc	; 220
   342E EC                   74 	.db #0xec	; 236
   342F FC                   75 	.db #0xfc	; 252
   3430 FC                   76 	.db #0xfc	; 252
   3431 EC                   77 	.db #0xec	; 236
   3432 DC                   78 	.db #0xdc	; 220
   3433 FC                   79 	.db #0xfc	; 252
   3434 FC                   80 	.db #0xfc	; 252
   3435 DC                   81 	.db #0xdc	; 220
   3436 EC                   82 	.db #0xec	; 236
   3437 FC                   83 	.db #0xfc	; 252
   3438                      84 _g_1:
   3438 FC                   85 	.db #0xfc	; 252
   3439 FC                   86 	.db #0xfc	; 252
   343A FC                   87 	.db #0xfc	; 252
   343B FC                   88 	.db #0xfc	; 252
   343C FC                   89 	.db #0xfc	; 252
   343D FC                   90 	.db #0xfc	; 252
   343E FC                   91 	.db #0xfc	; 252
   343F FC                   92 	.db #0xfc	; 252
   3440 FC                   93 	.db #0xfc	; 252
   3441 EC                   94 	.db #0xec	; 236
   3442 CC                   95 	.db #0xcc	; 204
   3443 CC                   96 	.db #0xcc	; 204
   3444 FC                   97 	.db #0xfc	; 252
   3445 FC                   98 	.db #0xfc	; 252
   3446 FC                   99 	.db #0xfc	; 252
   3447 FC                  100 	.db #0xfc	; 252
   3448 FC                  101 	.db #0xfc	; 252
   3449 EC                  102 	.db #0xec	; 236
   344A DC                  103 	.db #0xdc	; 220
   344B FC                  104 	.db #0xfc	; 252
   344C FC                  105 	.db #0xfc	; 252
   344D DC                  106 	.db #0xdc	; 220
   344E EC                  107 	.db #0xec	; 236
   344F FC                  108 	.db #0xfc	; 252
   3450 FC                  109 	.db #0xfc	; 252
   3451 EC                  110 	.db #0xec	; 236
   3452 DC                  111 	.db #0xdc	; 220
   3453 FC                  112 	.db #0xfc	; 252
   3454 CC                  113 	.db #0xcc	; 204
   3455 CC                  114 	.db #0xcc	; 204
   3456 EC                  115 	.db #0xec	; 236
   3457 FC                  116 	.db #0xfc	; 252
   3458                     117 _g_2:
   3458 FC                  118 	.db #0xfc	; 252
   3459 FC                  119 	.db #0xfc	; 252
   345A FC                  120 	.db #0xfc	; 252
   345B FC                  121 	.db #0xfc	; 252
   345C FC                  122 	.db #0xfc	; 252
   345D FC                  123 	.db #0xfc	; 252
   345E FC                  124 	.db #0xfc	; 252
   345F FC                  125 	.db #0xfc	; 252
   3460 CC                  126 	.db #0xcc	; 204
   3461 CC                  127 	.db #0xcc	; 204
   3462 CC                  128 	.db #0xcc	; 204
   3463 CC                  129 	.db #0xcc	; 204
   3464 FC                  130 	.db #0xfc	; 252
   3465 FC                  131 	.db #0xfc	; 252
   3466 FC                  132 	.db #0xfc	; 252
   3467 FC                  133 	.db #0xfc	; 252
   3468 FC                  134 	.db #0xfc	; 252
   3469 FC                  135 	.db #0xfc	; 252
   346A FC                  136 	.db #0xfc	; 252
   346B FC                  137 	.db #0xfc	; 252
   346C FC                  138 	.db #0xfc	; 252
   346D FC                  139 	.db #0xfc	; 252
   346E FC                  140 	.db #0xfc	; 252
   346F FC                  141 	.db #0xfc	; 252
   3470 FC                  142 	.db #0xfc	; 252
   3471 FC                  143 	.db #0xfc	; 252
   3472 FC                  144 	.db #0xfc	; 252
   3473 FC                  145 	.db #0xfc	; 252
   3474 CC                  146 	.db #0xcc	; 204
   3475 CC                  147 	.db #0xcc	; 204
   3476 CC                  148 	.db #0xcc	; 204
   3477 CC                  149 	.db #0xcc	; 204
   3478                     150 _g_3:
   3478 FC                  151 	.db #0xfc	; 252
   3479 FC                  152 	.db #0xfc	; 252
   347A FC                  153 	.db #0xfc	; 252
   347B FC                  154 	.db #0xfc	; 252
   347C FC                  155 	.db #0xfc	; 252
   347D FC                  156 	.db #0xfc	; 252
   347E FC                  157 	.db #0xfc	; 252
   347F FC                  158 	.db #0xfc	; 252
   3480 CC                  159 	.db #0xcc	; 204
   3481 CC                  160 	.db #0xcc	; 204
   3482 DC                  161 	.db #0xdc	; 220
   3483 FC                  162 	.db #0xfc	; 252
   3484 FC                  163 	.db #0xfc	; 252
   3485 FC                  164 	.db #0xfc	; 252
   3486 FC                  165 	.db #0xfc	; 252
   3487 FC                  166 	.db #0xfc	; 252
   3488 FC                  167 	.db #0xfc	; 252
   3489 EC                  168 	.db #0xec	; 236
   348A DC                  169 	.db #0xdc	; 220
   348B FC                  170 	.db #0xfc	; 252
   348C FC                  171 	.db #0xfc	; 252
   348D DC                  172 	.db #0xdc	; 220
   348E EC                  173 	.db #0xec	; 236
   348F FC                  174 	.db #0xfc	; 252
   3490 FC                  175 	.db #0xfc	; 252
   3491 EC                  176 	.db #0xec	; 236
   3492 DC                  177 	.db #0xdc	; 220
   3493 FC                  178 	.db #0xfc	; 252
   3494 FC                  179 	.db #0xfc	; 252
   3495 DC                  180 	.db #0xdc	; 220
   3496 CC                  181 	.db #0xcc	; 204
   3497 CC                  182 	.db #0xcc	; 204
   3498                     183 _g_4:
   3498 FC                  184 	.db #0xfc	; 252
   3499 EC                  185 	.db #0xec	; 236
   349A DC                  186 	.db #0xdc	; 220
   349B FC                  187 	.db #0xfc	; 252
   349C FC                  188 	.db #0xfc	; 252
   349D DC                  189 	.db #0xdc	; 220
   349E EC                  190 	.db #0xec	; 236
   349F FC                  191 	.db #0xfc	; 252
   34A0 FC                  192 	.db #0xfc	; 252
   34A1 EC                  193 	.db #0xec	; 236
   34A2 CC                  194 	.db #0xcc	; 204
   34A3 CC                  195 	.db #0xcc	; 204
   34A4 FC                  196 	.db #0xfc	; 252
   34A5 DC                  197 	.db #0xdc	; 220
   34A6 EC                  198 	.db #0xec	; 236
   34A7 FC                  199 	.db #0xfc	; 252
   34A8 FC                  200 	.db #0xfc	; 252
   34A9 FC                  201 	.db #0xfc	; 252
   34AA FC                  202 	.db #0xfc	; 252
   34AB FC                  203 	.db #0xfc	; 252
   34AC FC                  204 	.db #0xfc	; 252
   34AD FC                  205 	.db #0xfc	; 252
   34AE FC                  206 	.db #0xfc	; 252
   34AF FC                  207 	.db #0xfc	; 252
   34B0 FC                  208 	.db #0xfc	; 252
   34B1 FC                  209 	.db #0xfc	; 252
   34B2 FC                  210 	.db #0xfc	; 252
   34B3 FC                  211 	.db #0xfc	; 252
   34B4 CC                  212 	.db #0xcc	; 204
   34B5 CC                  213 	.db #0xcc	; 204
   34B6 EC                  214 	.db #0xec	; 236
   34B7 FC                  215 	.db #0xfc	; 252
   34B8                     216 _g_5:
   34B8 FC                  217 	.db #0xfc	; 252
   34B9 EC                  218 	.db #0xec	; 236
   34BA DC                  219 	.db #0xdc	; 220
   34BB FC                  220 	.db #0xfc	; 252
   34BC FC                  221 	.db #0xfc	; 252
   34BD DC                  222 	.db #0xdc	; 220
   34BE EC                  223 	.db #0xec	; 236
   34BF FC                  224 	.db #0xfc	; 252
   34C0 CC                  225 	.db #0xcc	; 204
   34C1 CC                  226 	.db #0xcc	; 204
   34C2 DC                  227 	.db #0xdc	; 220
   34C3 FC                  228 	.db #0xfc	; 252
   34C4 FC                  229 	.db #0xfc	; 252
   34C5 DC                  230 	.db #0xdc	; 220
   34C6 EC                  231 	.db #0xec	; 236
   34C7 FC                  232 	.db #0xfc	; 252
   34C8 FC                  233 	.db #0xfc	; 252
   34C9 FC                  234 	.db #0xfc	; 252
   34CA FC                  235 	.db #0xfc	; 252
   34CB FC                  236 	.db #0xfc	; 252
   34CC FC                  237 	.db #0xfc	; 252
   34CD FC                  238 	.db #0xfc	; 252
   34CE FC                  239 	.db #0xfc	; 252
   34CF FC                  240 	.db #0xfc	; 252
   34D0 FC                  241 	.db #0xfc	; 252
   34D1 FC                  242 	.db #0xfc	; 252
   34D2 FC                  243 	.db #0xfc	; 252
   34D3 FC                  244 	.db #0xfc	; 252
   34D4 FC                  245 	.db #0xfc	; 252
   34D5 DC                  246 	.db #0xdc	; 220
   34D6 CC                  247 	.db #0xcc	; 204
   34D7 CC                  248 	.db #0xcc	; 204
   34D8                     249 _g_6:
   34D8 FC                  250 	.db #0xfc	; 252
   34D9 FC                  251 	.db #0xfc	; 252
   34DA FC                  252 	.db #0xfc	; 252
   34DB FC                  253 	.db #0xfc	; 252
   34DC FC                  254 	.db #0xfc	; 252
   34DD DE                  255 	.db #0xde	; 222
   34DE ED                  256 	.db #0xed	; 237
   34DF FC                  257 	.db #0xfc	; 252
   34E0 FC                  258 	.db #0xfc	; 252
   34E1 ED                  259 	.db #0xed	; 237
   34E2 DE                  260 	.db #0xde	; 222
   34E3 DE                  261 	.db #0xde	; 222
   34E4 FC                  262 	.db #0xfc	; 252
   34E5 DE                  263 	.db #0xde	; 222
   34E6 ED                  264 	.db #0xed	; 237
   34E7 FC                  265 	.db #0xfc	; 252
   34E8 ED                  266 	.db #0xed	; 237
   34E9 CF                  267 	.db #0xcf	; 207
   34EA DE                  268 	.db #0xde	; 222
   34EB FC                  269 	.db #0xfc	; 252
   34EC FC                  270 	.db #0xfc	; 252
   34ED DE                  271 	.db #0xde	; 222
   34EE ED                  272 	.db #0xed	; 237
   34EF FC                  273 	.db #0xfc	; 252
   34F0 ED                  274 	.db #0xed	; 237
   34F1 ED                  275 	.db #0xed	; 237
   34F2 DE                  276 	.db #0xde	; 222
   34F3 FC                  277 	.db #0xfc	; 252
   34F4 DE                  278 	.db #0xde	; 222
   34F5 CF                  279 	.db #0xcf	; 207
   34F6 ED                  280 	.db #0xed	; 237
   34F7 FC                  281 	.db #0xfc	; 252
   34F8                     282 _g_7:
   34F8 FC                  283 	.db #0xfc	; 252
   34F9 FC                  284 	.db #0xfc	; 252
   34FA FC                  285 	.db #0xfc	; 252
   34FB FC                  286 	.db #0xfc	; 252
   34FC FC                  287 	.db #0xfc	; 252
   34FD FC                  288 	.db #0xfc	; 252
   34FE FC                  289 	.db #0xfc	; 252
   34FF FC                  290 	.db #0xfc	; 252
   3500 FC                  291 	.db #0xfc	; 252
   3501 FC                  292 	.db #0xfc	; 252
   3502 FC                  293 	.db #0xfc	; 252
   3503 FC                  294 	.db #0xfc	; 252
   3504 FC                  295 	.db #0xfc	; 252
   3505 FC                  296 	.db #0xfc	; 252
   3506 FC                  297 	.db #0xfc	; 252
   3507 FC                  298 	.db #0xfc	; 252
   3508 FC                  299 	.db #0xfc	; 252
   3509 FC                  300 	.db #0xfc	; 252
   350A FC                  301 	.db #0xfc	; 252
   350B FC                  302 	.db #0xfc	; 252
   350C FC                  303 	.db #0xfc	; 252
   350D FC                  304 	.db #0xfc	; 252
   350E FC                  305 	.db #0xfc	; 252
   350F FC                  306 	.db #0xfc	; 252
   3510 FC                  307 	.db #0xfc	; 252
   3511 FC                  308 	.db #0xfc	; 252
   3512 FC                  309 	.db #0xfc	; 252
   3513 FC                  310 	.db #0xfc	; 252
   3514 FC                  311 	.db #0xfc	; 252
   3515 FC                  312 	.db #0xfc	; 252
   3516 FC                  313 	.db #0xfc	; 252
   3517 FC                  314 	.db #0xfc	; 252
                            315 	.area _INITIALIZER
                            316 	.area _CABS (ABS)
