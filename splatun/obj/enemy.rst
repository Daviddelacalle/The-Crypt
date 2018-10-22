ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                              2 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                              3 ;; ENTIDAD ENEMIGO
                              4 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                              5 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                              6 
                              7 .area _DATA
                              8 .area _CODE
                              9 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                             10 .include "cpctelera.h.s"
                              1 ;;-----------------------------LICENSE NOTICE------------------------------------
                              2 ;;  This file is part of CPCtelera: An Amstrad CPC Game Engine
                              3 ;;  Copyright (C) 2017 ronaldo / Fremos / Cheesetea / ByteRealms (@FranGallegoBR)
                              4 ;;
                              5 ;;  This program is free software: you can redistribute it and/or modify
                              6 ;;  it under the terms of the GNU Lesser General Public License as published by
                              7 ;;  the Free Software Foundation, either version 3 of the License, or
                              8 ;;  (at your option) any later version.
                              9 ;;
                             10 ;;  This program is distributed in the hope that it will be useful,
                             11 ;;  but WITHOUT ANY WARRANTY; without even the implied warranty of
                             12 ;;  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                             13 ;;  GNU Lesser General Public License for more details.
                             14 ;;
                             15 ;;  You should have received a copy of the GNU Lesser General Public License
                             16 ;;  along with this program.  If not, see <http://www.gnu.org/licenses/>.
                             17 ;;-------------------------------------------------------------------------------
                             18 
                             19 ;; All CPCtelera include files
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



                             20 .include "macros/allmacros.h.s"
                              1 ;;-----------------------------LICENSE NOTICE------------------------------------
                              2 ;;  This file is part of CPCtelera: An Amstrad CPC Game Engine
                              3 ;;  Copyright (C) 2017 ronaldo / Fremos / Cheesetea / ByteRealms (@FranGallegoBR)
                              4 ;;
                              5 ;;  This program is free software: you can redistribute it and/or modify
                              6 ;;  it under the terms of the GNU Lesser General Public License as published by
                              7 ;;  the Free Software Foundation, either version 3 of the License, or
                              8 ;;  (at your option) any later version.
                              9 ;;
                             10 ;;  This program is distributed in the hope that it will be useful,
                             11 ;;  but WITHOUT ANY WARRANTY; without even the implied warranty of
                             12 ;;  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                             13 ;;  GNU Lesser General Public License for more details.
                             14 ;;
                             15 ;;  You should have received a copy of the GNU Lesser General Public License
                             16 ;;  along with this program.  If not, see <http://www.gnu.org/licenses/>.
                             17 ;;-------------------------------------------------------------------------------
                             18 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
Hexadecimal [16-Bits]



                             19 .include "macros/cpct_maths.h.s"
                              1 ;;-----------------------------LICENSE NOTICE------------------------------------
                              2 ;;  This file is part of CPCtelera: An Amstrad CPC Game Engine 
                              3 ;;  Copyright (C) 2017 ronaldo / Fremos / Cheesetea / ByteRealms (@FranGallegoBR)
                              4 ;;
                              5 ;;  This program is free software: you can redistribute it and/or modify
                              6 ;;  it under the terms of the GNU Lesser General Public License as published by
                              7 ;;  the Free Software Foundation, either version 3 of the License, or
                              8 ;;  (at your option) any later version.
                              9 ;;
                             10 ;;  This program is distributed in the hope that it will be useful,
                             11 ;;  but WITHOUT ANY WARRANTY; without even the implied warranty of
                             12 ;;  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                             13 ;;  GNU Lesser General Public License for more details.
                             14 ;;
                             15 ;;  You should have received a copy of the GNU Lesser General Public License
                             16 ;;  along with this program.  If not, see <http://www.gnu.org/licenses/>.
                             17 ;;-------------------------------------------------------------------------------
                             18 
                             19 ;;
                             20 ;; File: Math Macros
                             21 ;;
                             22 ;;    Useful assembler macros for doing common math operations
                             23 ;;
                             24 
                             25 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                             26 ;; Macro: add_REGPAIR_a 
                             27 ;;
                             28 ;;    Performs the operation REGPAIR = REGPAIR + A. REGPAIR is any given pair of 8-bit registers.
                             29 ;;
                             30 ;; ASM Definition:
                             31 ;;    .macro <add_REGPAIR_a> RH, RL
                             32 ;;
                             33 ;; Parameters:
                             34 ;;    RH    - Register 1 of the REGPAIR. Holds higher-byte value
                             35 ;;    RL    - Register 2 of the REGPAIR. Holds lower-byte value
                             36 ;; 
                             37 ;; Input Registers: 
                             38 ;;    RH:RL - 16-value used as left-operand and final storage for the sum
                             39 ;;    A     - Second sum operand
                             40 ;;
                             41 ;; Return Value:
                             42 ;;    RH:RL - Holds the sum of RH:RL + A
                             43 ;;
                             44 ;; Details:
                             45 ;;    This macro performs the sum of RH:RL + A and stores it directly on RH:RL.
                             46 ;; It uses only RH:RL and A to perform the operation.
                             47 ;;
                             48 ;; Modified Registers: 
                             49 ;;    A, RH, RL
                             50 ;;
                             51 ;; Required memory:
                             52 ;;    5 bytes
                             53 ;;
                             54 ;; Time Measures:
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



                             55 ;; (start code)
                             56 ;;  Case | microSecs(us) | CPU Cycles
                             57 ;; ------------------------------------
                             58 ;;  Any  |       5       |     20
                             59 ;; ------------------------------------
                             60 ;; (end code)
                             61 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                             62 .macro add_REGPAIR_a rh, rl
                             63    ;; First Perform RH = E + A
                             64    add rl    ;; [1] A' = RL + A 
                             65    ld  rl, a ;; [1] RL' = A' = RL + A. It might generate Carry that must be added to RH
                             66    
                             67    ;; Then Perform RH = RH + Carry 
                             68    adc rh    ;; [1] A'' = A' + RH + Carry = RL + A + RH + Carry
                             69    sub rl    ;; [1] Remove RL'. A''' = A'' - RL' = RL + A + RH + Carry - (RL + A) = RH + Carry
                             70    ld  rh, a ;; [1] Save into RH (RH' = A''' = RH + Carry)
                             71 .endm
                             72 
                             73 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                             74 ;; Macro: add_de_a
                             75 ;;
                             76 ;;    Performs the operation DE = DE + A
                             77 ;;
                             78 ;; ASM Definition:
                             79 ;;    .macro <add_de_a>
                             80 ;;
                             81 ;; Parameters:
                             82 ;;    None
                             83 ;; 
                             84 ;; Input Registers: 
                             85 ;;    DE    - First sum operand and Destination Register
                             86 ;;    A     - Second sum operand
                             87 ;;
                             88 ;; Return Value:
                             89 ;;    DE - Holds the sum of DE + A
                             90 ;;
                             91 ;; Details:
                             92 ;;    This macro performs the sum of DE + A and stores it directly on DE.
                             93 ;; It uses only DE and A to perform the operation.
                             94 ;;    This macro is a direct instantiation of the macro <add_REGPAIR_a>.
                             95 ;;
                             96 ;; Modified Registers: 
                             97 ;;    A, DE
                             98 ;;
                             99 ;; Required memory:
                            100 ;;    5 bytes
                            101 ;;
                            102 ;; Time Measures:
                            103 ;; (start code)
                            104 ;;  Case | microSecs(us) | CPU Cycles
                            105 ;; ------------------------------------
                            106 ;;  Any  |       5       |     20
                            107 ;; ------------------------------------
                            108 ;; (end code)
                            109 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



                            110 .macro add_de_a
                            111    add_REGPAIR_a  d, e
                            112 .endm
                            113 
                            114 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            115 ;; Macro: add_hl_a
                            116 ;;
                            117 ;;    Performs the operation HL = HL + A
                            118 ;;
                            119 ;; ASM Definition:
                            120 ;;    .macro <add_hl_a>
                            121 ;;
                            122 ;; Parameters:
                            123 ;;    None
                            124 ;; 
                            125 ;; Input Registers: 
                            126 ;;    HL    - First sum operand and Destination Register
                            127 ;;    A     - Second sum operand
                            128 ;;
                            129 ;; Return Value:
                            130 ;;    HL - Holds the sum of HL + A
                            131 ;;
                            132 ;; Details:
                            133 ;;    This macro performs the sum of HL + A and stores it directly on HL.
                            134 ;; It uses only HL and A to perform the operation.
                            135 ;;    This macro is a direct instantiation of the macro <add_REGPAIR_a>.
                            136 ;;
                            137 ;; Modified Registers: 
                            138 ;;    A, HL
                            139 ;;
                            140 ;; Required memory:
                            141 ;;    5 bytes
                            142 ;;
                            143 ;; Time Measures:
                            144 ;; (start code)
                            145 ;;  Case | microSecs(us) | CPU Cycles
                            146 ;; ------------------------------------
                            147 ;;  Any  |       5       |     20
                            148 ;; ------------------------------------
                            149 ;; (end code)
                            150 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            151 .macro add_hl_a
                            152    add_REGPAIR_a  h, l
                            153 .endm
                            154 
                            155 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            156 ;; Macro: add_bc_a
                            157 ;;
                            158 ;;    Performs the operation BC = BC + A
                            159 ;;
                            160 ;; ASM Definition:
                            161 ;;    .macro <add_bc_a>
                            162 ;;
                            163 ;; Parameters:
                            164 ;;    None
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 7.
Hexadecimal [16-Bits]



                            165 ;; 
                            166 ;; Input Registers: 
                            167 ;;    BC    - First sum operand and Destination Register
                            168 ;;    A     - Second sum operand
                            169 ;;
                            170 ;; Return Value:
                            171 ;;    BC - Holds the sum of BC + A
                            172 ;;
                            173 ;; Details:
                            174 ;;    This macro performs the sum of BC + A and stores it directly on BC.
                            175 ;; It uses only BC and A to perform the operation.
                            176 ;;    This macro is a direct instantiation of the macro <add_REGPAIR_a>.
                            177 ;;
                            178 ;; Modified Registers: 
                            179 ;;    A, BC
                            180 ;;
                            181 ;; Required memory:
                            182 ;;    5 bytes
                            183 ;;
                            184 ;; Time Measures:
                            185 ;; (start code)
                            186 ;;  Case | microSecs(us) | CPU Cycles
                            187 ;; ------------------------------------
                            188 ;;  Any  |       5       |     20
                            189 ;; ------------------------------------
                            190 ;; (end code)
                            191 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            192 .macro add_bc_a
                            193    add_REGPAIR_a  b, c
                            194 .endm
                            195 
                            196 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            197 ;; Macro: sub_REGPAIR_a 
                            198 ;;
                            199 ;;    Performs the operation REGPAIR = REGPAIR - A. REGPAIR is any given pair of 8-bit registers.
                            200 ;;
                            201 ;; ASM Definition:
                            202 ;;    .macro <sub_REGPAIR_a> RH, RL
                            203 ;;
                            204 ;; Parameters:
                            205 ;;    RH    - Register 1 of the REGPAIR. Holds higher-byte value
                            206 ;;    RL    - Register 2 of the REGPAIR. Holds lower-byte value
                            207 ;;  ?JMPLBL - Optional Jump label. A temporal one will be produced if none is given.
                            208 ;; 
                            209 ;; Input Registers: 
                            210 ;;    RH:RL - 16-value used as left-operand and final storage for the subtraction
                            211 ;;    A     - Second subtraction operand
                            212 ;;
                            213 ;; Return Value:
                            214 ;;    RH:RL - Holds the result of RH:RL - A
                            215 ;;
                            216 ;; Details:
                            217 ;;    This macro performs the subtraction of RH:RL - A and stores it directly on RH:RL.
                            218 ;; It uses only RH:RL and A to perform the operation.
                            219 ;;    With respect to the optional label ?JMPLBL, it is often better not to provide 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 8.
Hexadecimal [16-Bits]



                            220 ;; this parameter. A temporal local symbol will be automatically generated for that label.
                            221 ;; Only provide it when you have a specific reason to do that.
                            222 ;;
                            223 ;; Modified Registers: 
                            224 ;;    A, RH, RL
                            225 ;;
                            226 ;; Required memory:
                            227 ;;    7 bytes
                            228 ;;
                            229 ;; Time Measures:
                            230 ;; (start code)
                            231 ;;  Case | microSecs(us) | CPU Cycles
                            232 ;; ------------------------------------
                            233 ;;  Any  |       7       |     28
                            234 ;; ------------------------------------
                            235 ;; (end code)
                            236 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            237 .macro sub_REGPAIR_a rh, rl, ?jmplbl
                            238    ;; First Perform A' = A - 1 - RL 
                            239    ;; (Inverse subtraction minus 1, used  to test for Carry, needed to know when to subtract 1 from RH)
                            240    dec    a          ;; [1] --A (In case A == RL, inverse subtraction should produce carry not to decrement RH)
                            241    sub   rl          ;; [1] A' = A - 1 - RL
                            242    jr     c, jmplbl  ;; [2/3] If A <= RL, Carry will be produced, and no decrement of RH is required, so jump over it
                            243      dec   rh        ;; [1] --RH (A > RL, so RH must be decremented)
                            244 jmplbl:   
                            245    ;; Now invert A to get the subtraction we wanted 
                            246    ;; { RL' = -A' - 1 = -(A - 1 - RL) - 1 = RL - A }
                            247    cpl            ;; [1] A'' = RL - A (Original subtraction we wanted, calculated trough one's complement of A')
                            248    ld    rl, a    ;; [1] Save into RL (RL' = RL - A)
                            249 .endm
                            250 
                            251 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            252 ;; Macro: sub_de_a 
                            253 ;;
                            254 ;;    Performs the operation DE = DE - A. DE is any given pair of 8-bit registers.
                            255 ;;
                            256 ;; ASM Definition:
                            257 ;;    .macro <sub_de_a>
                            258 ;; 
                            259 ;; Input Registers: 
                            260 ;;    DE - 16-value used as left-operand and final storage for the subtraction
                            261 ;;    A  - Second subtraction operand
                            262 ;;
                            263 ;; Return Value:
                            264 ;;    DE - Holds the result of DE - A
                            265 ;;
                            266 ;; Details:
                            267 ;;    This macro performs the subtraction of DE - A and stores it directly on DE.
                            268 ;; It uses only DE and A to perform the operation.
                            269 ;;
                            270 ;; Modified Registers: 
                            271 ;;    A, DE
                            272 ;;
                            273 ;; Required memory:
                            274 ;;    7 bytes
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 9.
Hexadecimal [16-Bits]



                            275 ;;
                            276 ;; Time Measures:
                            277 ;; (start code)
                            278 ;;  Case | microSecs(us) | CPU Cycles
                            279 ;; ------------------------------------
                            280 ;;  Any  |       7       |     28
                            281 ;; ------------------------------------
                            282 ;; (end code)
                            283 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            284 .macro sub_de_a
                            285    sub_REGPAIR_a  d, e
                            286 .endm
                            287 
                            288 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            289 ;; Macro: sub_hl_a 
                            290 ;;
                            291 ;;    Performs the operation HL = HL - A. HL is any given pair of 8-bit registers.
                            292 ;;
                            293 ;; ASM Definition:
                            294 ;;    .macro <sub_hl_a>
                            295 ;; 
                            296 ;; Input Registers: 
                            297 ;;    HL - 16-value used as left-operand and final storage for the subtraction
                            298 ;;    A  - Second subtraction operand
                            299 ;;
                            300 ;; Return Value:
                            301 ;;    HL - Holds the result of HL - A
                            302 ;;
                            303 ;; Details:
                            304 ;;    This macro performs the subtraction of HL - A and stores it directly on HL.
                            305 ;; It uses only HL and A to perform the operation.
                            306 ;;
                            307 ;; Modified Registers: 
                            308 ;;    A, HL
                            309 ;;
                            310 ;; Required memory:
                            311 ;;    7 bytes
                            312 ;;
                            313 ;; Time Measures:
                            314 ;; (start code)
                            315 ;;  Case | microSecs(us) | CPU Cycles
                            316 ;; ------------------------------------
                            317 ;;  Any  |       7       |     28
                            318 ;; ------------------------------------
                            319 ;; (end code)
                            320 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            321 .macro sub_hl_a
                            322    sub_REGPAIR_a  h, l
                            323 .endm
                            324 
                            325 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            326 ;; Macro: sub_bc_a 
                            327 ;;
                            328 ;;    Performs the operation BC = BC - A. BC is any given pair of 8-bit registers.
                            329 ;;
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 10.
Hexadecimal [16-Bits]



                            330 ;; ASM Definition:
                            331 ;;    .macro <sub_bc_a>
                            332 ;; 
                            333 ;; Input Registers: 
                            334 ;;    BC - 16-value used as left-operand and final storage for the subtraction
                            335 ;;    A  - Second subtraction operand
                            336 ;;
                            337 ;; Return Value:
                            338 ;;    BC - Holds the result of BC - A
                            339 ;;
                            340 ;; Details:
                            341 ;;    This macro performs the subtraction of BC - A and stores it directly on BC.
                            342 ;; It uses only BC and A to perform the operation.
                            343 ;;
                            344 ;; Modified Registers: 
                            345 ;;    A, BC
                            346 ;;
                            347 ;; Required memory:
                            348 ;;    7 bytes
                            349 ;;
                            350 ;; Time Measures:
                            351 ;; (start code)
                            352 ;;  Case | microSecs(us) | CPU Cycles
                            353 ;; ------------------------------------
                            354 ;;  Any  |       7       |     28
                            355 ;; ------------------------------------
                            356 ;; (end code)
                            357 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            358 .macro sub_bc_a
                            359    sub_REGPAIR_a  b, c
                            360 .endm
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 11.
Hexadecimal [16-Bits]



                             20 .include "macros/cpct_opcodeConstants.h.s"
                              1 ;;-----------------------------LICENSE NOTICE------------------------------------
                              2 ;;  This file is part of CPCtelera: An Amstrad CPC Game Engine 
                              3 ;;  Copyright (C) 2016 ronaldo / Fremos / Cheesetea / ByteRealms (@FranGallegoBR)
                              4 ;;
                              5 ;;  This program is free software: you can redistribute it and/or modify
                              6 ;;  it under the terms of the GNU Lesser General Public License as published by
                              7 ;;  the Free Software Foundation, either version 3 of the License, or
                              8 ;;  (at your option) any later version.
                              9 ;;
                             10 ;;  This program is distributed in the hope that it will be useful,
                             11 ;;  but WITHOUT ANY WARRANTY; without even the implied warranty of
                             12 ;;  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                             13 ;;  GNU Lesser General Public License for more details.
                             14 ;;
                             15 ;;  You should have received a copy of the GNU Lesser General Public License
                             16 ;;  along with this program.  If not, see <http://www.gnu.org/licenses/>.
                             17 ;;-------------------------------------------------------------------------------
                             18 
                             19 ;;
                             20 ;; File: Opcodes
                             21 ;;
                             22 ;;    Constant definitions of Z80 opcodes. This will be normally used as data
                             23 ;; for self-modifying code.
                             24 ;;
                             25 
                             26 ;; Constant: opc_JR
                             27 ;;    Opcode for "JR xx" instruction. Requires 1-byte parameter (xx)
                     0018    28 opc_JR   = 0x18
                             29 
                             30 ;; Constant: opc_LD_D
                             31 ;;    Opcode for "LD d, xx" instruction. Requires 1-byte parameter (xx)
                     0016    32 opc_LD_D = 0x16
                             33 
                             34 ;; Constant: opc_EI
                             35 ;;    Opcode for "EI" instruction. 
                     00FB    36 opc_EI = 0xFB
                             37 
                             38 ;; Constant: opc_DI
                             39 ;;    Opcode for "DI" instruction. 
                     00F3    40 opc_DI = 0xF3
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 12.
Hexadecimal [16-Bits]



                             21 .include "macros/cpct_reverseBits.h.s"
                              1 ;;-----------------------------LICENSE NOTICE------------------------------------
                              2 ;;  This file is part of CPCtelera: An Amstrad CPC Game Engine 
                              3 ;;  Copyright (C) 2016 ronaldo / Fremos / Cheesetea / ByteRealms (@FranGallegoBR)
                              4 ;;
                              5 ;;  This program is free software: you can redistribute it and/or modify
                              6 ;;  it under the terms of the GNU Lesser General Public License as published by
                              7 ;;  the Free Software Foundation, either version 3 of the License, or
                              8 ;;  (at your option) any later version.
                              9 ;;
                             10 ;;  This program is distributed in the hope that it will be useful,
                             11 ;;  but WITHOUT ANY WARRANTY; without even the implied warranty of
                             12 ;;  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                             13 ;;  GNU Lesser General Public License for more details.
                             14 ;;
                             15 ;;  You should have received a copy of the GNU Lesser General Public License
                             16 ;;  along with this program.  If not, see <http://www.gnu.org/licenses/>.
                             17 ;;-------------------------------------------------------------------------------
                             18 
                             19 ;;
                             20 ;; File: Reverse Bits
                             21 ;;
                             22 ;;    Useful macros for bit reversing and selecting in different ways. Only
                             23 ;; valid to be used from assembly language (not from C).
                             24 ;;
                             25 
                             26 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                             27 ;; Macro: cpctm_reverse_and_select_bits_of_A
                             28 ;;
                             29 ;;    Reorders the bits of A and mixes them letting the user select the 
                             30 ;; new order for the bits by using a selection mask.
                             31 ;;
                             32 ;; Parameters:
                             33 ;;    TReg          - An 8-bits register that will be used for intermediate calculations.
                             34 ;; This register may be one of these: B, C, D, E, H, L
                             35 ;;    SelectionMask - An 8-bits mask that will be used to select the bits to get from 
                             36 ;; the reordered bits. It might be an 8-bit register or even (hl).
                             37 ;; 
                             38 ;; Input Registers: 
                             39 ;;    A     - Byte to be reversed
                             40 ;;    TReg  - Should have a copy of A (same exact value)
                             41 ;;
                             42 ;; Return Value:
                             43 ;;    A - Resulting value with bits reversed and selected 
                             44 ;;
                             45 ;; Details:
                             46 ;;    This macro reorders the bits in A and mixes them with the same bits in
                             47 ;; their original order by using a *SelectionMask*. The process is as follows:
                             48 ;;
                             49 ;;    1. Consider the 8 bits of A = TReg = [01234567]
                             50 ;;    2. Reorder the 8 bits of A, producing A2 = [32547610]
                             51 ;;    2. Reorder the bits of TReg, producing TReg2 = [76103254]
                             52 ;;    3. Combines both reorders into final result using a *SelectionMask*. Each 
                             53 ;; 0 bit from the selection mask means "select bit from A2", whereas each 1 bit
                             54 ;; means "select bit from TReg2".
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 13.
Hexadecimal [16-Bits]



                             55 ;;
                             56 ;;    For instance, a selection mask 0b11001100 will produce this result:
                             57 ;;
                             58 ;; (start code)
                             59 ;;       A2 = [ 32 54 76 10 ]
                             60 ;;    TReg2 = [ 76 10 32 54 ]
                             61 ;;  SelMask = [ 11 00 11 00 ] // 1 = TReg2-bits, 0 = A2-bits
                             62 ;;  ---------------------------
                             63 ;;   Result = [ 76 54 32 10 ]
                             64 ;; (end code)
                             65 ;;
                             66 ;;    Therefore, mask 0b11001100 produces the effect of reversing the bits of A
                             67 ;; completely. Other masks will produce different reorders of the bits in A, for
                             68 ;; different requirements or needs.
                             69 ;;
                             70 ;; Modified Registers: 
                             71 ;;    AF, TReg
                             72 ;;
                             73 ;; Required memory:
                             74 ;;    16 bytes
                             75 ;;
                             76 ;; Time Measures:
                             77 ;; (start code)
                             78 ;;  Case | microSecs(us) | CPU Cycles
                             79 ;; ------------------------------------
                             80 ;;  Any  |      16       |     64
                             81 ;; ------------------------------------
                             82 ;; (end code)
                             83 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                             84 .macro cpctm_reverse_and_select_bits_of_A  TReg, SelectionMask
                             85    rlca            ;; [1] | Rotate left twice so that...
                             86    rlca            ;; [1] | ... A=[23456701]
                             87 
                             88    ;; Mix bits of TReg and A so that all bits are in correct relative order
                             89    ;; but displaced from their final desired location
                             90    xor TReg        ;; [1] TReg = [01234567] (original value)
                             91    and #0b01010101 ;; [2]    A = [23456701] (bits rotated twice left)
                             92    xor TReg        ;; [1]   A2 = [03254761] (TReg mixed with A to get bits in order)
                             93    
                             94    ;; Now get bits 54 and 10 in their right location and save them into TReg
                             95    rlca            ;; [1]    A = [ 32 54 76 10 ] (54 and 10 are in their desired place)
                             96    ld TReg, a      ;; [1] TReg = A (Save this bit location into TReg)
                             97    
                             98    ;; Now get bits 76 and 32 in their right location in A
                             99    rrca            ;; [1] | Rotate A right 4 times to...
                            100    rrca            ;; [1] | ... get bits 76 and 32 located at their ...
                            101    rrca            ;; [1] | ... desired location :
                            102    rrca            ;; [1] | ... A = [ 76 10 32 54 ] (76 and 32 are in their desired place)
                            103    
                            104    ;; Finally, mix bits from TReg and A to get all bits reversed and selected
                            105    xor TReg          ;; [1] TReg = [32547610] (Mixed bits with 54 & 10 in their right place)
                            106    and SelectionMask ;; [2]    A = [76103254] (Mixed bits with 76 & 32 in their right place)
                            107    xor TReg          ;; [1]   A2 = [xxxxxxxx] final value: bits of A reversed and selected using *SelectionMask*
                            108 .endm
                            109 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 14.
Hexadecimal [16-Bits]



                            110 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            111 ;; Macro: cpctm_reverse_bits_of_A 
                            112 ;; Macro: cpctm_reverse_mode_2_pixels_of_A
                            113 ;;
                            114 ;;    Reverses the 8-bits of A, from [01234567] to [76543210]. This also reverses
                            115 ;; all pixels contained in A when A is in screen pixel format, mode 2.
                            116 ;;
                            117 ;; Parameters:
                            118 ;;    TReg - An 8-bits register that will be used for intermediate calculations.
                            119 ;; This register may be one of these: B, C, D, E, H, L
                            120 ;; 
                            121 ;; Input Registers: 
                            122 ;;    A    - Byte to be reversed
                            123 ;;    TReg - Should have a copy of A (same exact value)
                            124 ;;
                            125 ;; Return Value:
                            126 ;;    A - Resulting value with bits reversed 
                            127 ;;
                            128 ;; Requires:
                            129 ;;   - Uses the macro <cpctm_reverse_and_select_bits_of_A>.
                            130 ;;
                            131 ;; Details:
                            132 ;;    This macro reverses the bits in A. If bits of A = [01234567], the final
                            133 ;; result after processing this macro will be A = [76543210]. Register TReg is
                            134 ;; used for intermediate calculations and its value is destroyed.
                            135 ;;
                            136 ;; Modified Registers: 
                            137 ;;    AF, TReg
                            138 ;;
                            139 ;; Required memory:
                            140 ;;    16 bytes
                            141 ;;
                            142 ;; Time Measures:
                            143 ;; (start code)
                            144 ;;  Case | microSecs(us) | CPU Cycles
                            145 ;; ------------------------------------
                            146 ;;  Any  |      16       |     64
                            147 ;; ------------------------------------
                            148 ;; (end code)
                            149 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            150 .macro cpctm_reverse_bits_of_A  TReg
                            151    cpctm_reverse_and_select_bits_of_A  TReg, #0b11001100
                            152 .endm
                            153 .macro cpctm_reverse_mode_2_pixels_of_A   TReg
                            154    cpctm_reverse_bits_of_A  TReg
                            155 .endm
                            156 
                            157 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            158 ;; Macro: cpctm_reverse_mode_1_pixels_of_A
                            159 ;;
                            160 ;;    Reverses the order of pixel values contained in register A, assuming A is 
                            161 ;; in screen pixel format, mode 1.
                            162 ;;
                            163 ;; Parameters:
                            164 ;;    TReg - An 8-bits register that will be used for intermediate calculations.
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 15.
Hexadecimal [16-Bits]



                            165 ;; This register may be one of these: B, C, D, E, H, L
                            166 ;; 
                            167 ;; Input Registers: 
                            168 ;;    A    - Byte with pixel values to be reversed
                            169 ;;    TReg - Should have a copy of A (same exact value)
                            170 ;;
                            171 ;; Return Value:
                            172 ;;    A - Resulting byte with the 4 pixels values reversed in order
                            173 ;;
                            174 ;; Requires:
                            175 ;;   - Uses the macro <cpctm_reverse_and_select_bits_of_A>.
                            176 ;;
                            177 ;; Details:
                            178 ;;    This macro considers that A contains a byte that codifies 4 pixels in 
                            179 ;; screen pixel format, mode 1. It modifies A to reverse the order of its 4 
                            180 ;; contained pixel values left-to-right (1234 -> 4321). With respect to the 
                            181 ;; order of the 8-bits of A, the concrete operations performed is:
                            182 ;; (start code)
                            183 ;;    A = [01234567] == reverse-pixels ==> [32107654] = A2
                            184 ;; (end code)
                            185 ;;    You may want to check <cpct_px2byteM1> to know how bits codify both pixels
                            186 ;; in one single byte for screen pixel format, mode 1.
                            187 ;;
                            188 ;;    *TReg* is an 8-bit register that will be used for intermediate calculations,
                            189 ;; destroying its original value (that should be same as A, at the start).
                            190 ;;
                            191 ;; Modified Registers: 
                            192 ;;    AF, TReg
                            193 ;;
                            194 ;; Required memory:
                            195 ;;    16 bytes
                            196 ;;
                            197 ;; Time Measures:
                            198 ;; (start code)
                            199 ;;  Case | microSecs(us) | CPU Cycles
                            200 ;; ------------------------------------
                            201 ;;  Any  |      16       |     64
                            202 ;; ------------------------------------
                            203 ;; (end code)
                            204 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            205 .macro cpctm_reverse_mode_1_pixels_of_A  TReg
                            206    cpctm_reverse_and_select_bits_of_A  TReg, #0b00110011
                            207 .endm
                            208 
                            209 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            210 ;; Macro: cpctm_reverse_mode_0_pixels_of_A
                            211 ;;
                            212 ;;    Reverses the order of pixel values contained in register A, assuming A is 
                            213 ;; in screen pixel format, mode 0.
                            214 ;;
                            215 ;; Parameters:
                            216 ;;    TReg - An 8-bits register that will be used for intermediate calculations.
                            217 ;; This register may be one of these: B, C, D, E, H, L
                            218 ;; 
                            219 ;; Input Registers: 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 16.
Hexadecimal [16-Bits]



                            220 ;;    A    - Byte with pixel values to be reversed
                            221 ;;    TReg - Should have a copy of A (same exact value)
                            222 ;;
                            223 ;; Return Value:
                            224 ;;    A - Resulting byte with the 2 pixels values reversed in order
                            225 ;;
                            226 ;; Details:
                            227 ;;    This macro considers that A contains a byte that codifies 2 pixels in 
                            228 ;; screen pixel format, mode 0. It modifies A to reverse the order of its 2 
                            229 ;; contained pixel values left-to-right (12 -> 21). With respect to the 
                            230 ;; order of the 8-bits of A, the concrete operation performed is:
                            231 ;; (start code)
                            232 ;;    A = [01234567] == reverse-pixels ==> [10325476] = A2
                            233 ;; (end code)
                            234 ;;    You may want to check <cpct_px2byteM0> to know how bits codify both pixels
                            235 ;; in one single byte for screen pixel format, mode 0.
                            236 ;;
                            237 ;;    *TReg* is an 8-bit register that will be used for intermediate calculations,
                            238 ;; destroying its original value (that should be same as A, at the start).
                            239 ;;
                            240 ;; Modified Registers: 
                            241 ;;    AF, TReg
                            242 ;;
                            243 ;; Required memory:
                            244 ;;    7 bytes
                            245 ;;
                            246 ;; Time Measures:
                            247 ;; (start code)
                            248 ;;  Case | microSecs(us) | CPU Cycles
                            249 ;; ------------------------------------
                            250 ;;  Any  |       7       |     28
                            251 ;; ------------------------------------
                            252 ;; (end code)
                            253 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            254 .macro cpctm_reverse_mode_0_pixels_of_A  TReg
                            255    rlca            ;; [1] | Rotate A twice to the left to get bits ordered...
                            256    rlca            ;; [1] | ... in the way we need for mixing, A = [23456701]
                            257   
                            258    ;; Mix TReg with A to get pixels reversed by reordering bits
                            259    xor TReg        ;; [1] | TReg = [01234567]
                            260    and #0b01010101 ;; [2] |    A = [23456701]
                            261    xor TReg        ;; [1] |   A2 = [03254761]
                            262    rrca            ;; [1] Rotate right to get pixels reversed A = [10325476]
                            263 .endm
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 17.
Hexadecimal [16-Bits]



                             22 .include "macros/cpct_undocumentedOpcodes.h.s"
                              1 ;;-----------------------------LICENSE NOTICE------------------------------------
                              2 ;;  This file is part of CPCtelera: An Amstrad CPC Game Engine 
                              3 ;;  Copyright (C) 2016 ronaldo / Fremos / Cheesetea / ByteRealms (@FranGallegoBR)
                              4 ;;
                              5 ;;  This program is free software: you can redistribute it and/or modify
                              6 ;;  it under the terms of the GNU Lesser General Public License as published by
                              7 ;;  the Free Software Foundation, either version 3 of the License, or
                              8 ;;  (at your option) any later version.
                              9 ;;
                             10 ;;  This program is distributed in the hope that it will be useful,
                             11 ;;  but WITHOUT ANY WARRANTY; without even the implied warranty of
                             12 ;;  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                             13 ;;  GNU Lesser General Public License for more details.
                             14 ;;
                             15 ;;  You should have received a copy of the GNU Lesser General Public License
                             16 ;;  along with this program.  If not, see <http://www.gnu.org/licenses/>.
                             17 ;;-------------------------------------------------------------------------------
                             18 
                             19 ;;
                             20 ;; File: Undocumented Opcodes
                             21 ;;
                             22 ;;    Macros to clarify source code when using undocumented opcodes. Only
                             23 ;; valid to be used from assembly language (not from C).
                             24 ;;
                             25 
                             26 ;; Macro: jr__0
                             27 ;;    Opcode for "JR #0" instruction
                             28 ;; 
                             29 .macro jr__0
                             30    .DW #0x0018  ;; JR #00 (Normally used as a modifiable jump, as jr 0 is an infinite loop)
                             31 .endm
                             32 
                             33 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;,
                             34 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;,
                             35 ;; SLL Instructions
                             36 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;,
                             37 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;,
                             38 
                             39 ;; Macro: sll__b
                             40 ;;    Opcode for "SLL b" instruction
                             41 ;; 
                             42 .macro sll__b
                             43    .db #0xCB, #0x30  ;; Opcode for sll b
                             44 .endm
                             45 
                             46 ;; Macro: sll__c
                             47 ;;    Opcode for "SLL c" instruction
                             48 ;; 
                             49 .macro sll__c
                             50    .db #0xCB, #0x31  ;; Opcode for sll c
                             51 .endm
                             52 
                             53 ;; Macro: sll__d
                             54 ;;    Opcode for "SLL d" instruction
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 18.
Hexadecimal [16-Bits]



                             55 ;; 
                             56 .macro sll__d
                             57    .db #0xCB, #0x32  ;; Opcode for sll d
                             58 .endm
                             59 
                             60 ;; Macro: sll__e
                             61 ;;    Opcode for "SLL e" instruction
                             62 ;; 
                             63 .macro sll__e
                             64    .db #0xCB, #0x33  ;; Opcode for sll e
                             65 .endm
                             66 
                             67 ;; Macro: sll__h
                             68 ;;    Opcode for "SLL h" instruction
                             69 ;; 
                             70 .macro sll__h
                             71    .db #0xCB, #0x34  ;; Opcode for sll h
                             72 .endm
                             73 
                             74 ;; Macro: sll__l
                             75 ;;    Opcode for "SLL l" instruction
                             76 ;; 
                             77 .macro sll__l
                             78    .db #0xCB, #0x35  ;; Opcode for sll l
                             79 .endm
                             80 
                             81 ;; Macro: sll___hl_
                             82 ;;    Opcode for "SLL (hl)" instruction
                             83 ;; 
                             84 .macro sll___hl_
                             85    .db #0xCB, #0x36  ;; Opcode for sll (hl)
                             86 .endm
                             87 
                             88 ;; Macro: sll__a
                             89 ;;    Opcode for "SLL a" instruction
                             90 ;; 
                             91 .macro sll__a
                             92    .db #0xCB, #0x37  ;; Opcode for sll a
                             93 .endm
                             94 
                             95 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;,
                             96 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;,
                             97 ;; IXL Related Macros
                             98 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;,
                             99 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;,
                            100 
                            101 ;; Macro: ld__ixl    Value
                            102 ;;    Opcode for "LD ixl, Value" instruction
                            103 ;;  
                            104 ;; Parameters:
                            105 ;;    Value - An inmediate 8-bits value that will be loaded into ixl
                            106 ;; 
                            107 .macro ld__ixl    Value 
                            108    .db #0xDD, #0x2E, Value  ;; Opcode for ld ixl, Value
                            109 .endm
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 19.
Hexadecimal [16-Bits]



                            110 
                            111 ;; Macro: ld__ixl_a
                            112 ;;    Opcode for "LD ixl, a" instruction
                            113 ;; 
                            114 .macro ld__ixl_a
                            115    .dw #0x6FDD  ;; Opcode for ld ixl, a
                            116 .endm
                            117 
                            118 ;; Macro: ld__ixl_b
                            119 ;;    Opcode for "LD ixl, B" instruction
                            120 ;; 
                            121 .macro ld__ixl_b
                            122    .dw #0x68DD  ;; Opcode for ld ixl, b
                            123 .endm
                            124 
                            125 ;; Macro: ld__ixl_c
                            126 ;;    Opcode for "LD ixl, C" instruction
                            127 ;; 
                            128 .macro ld__ixl_c
                            129    .dw #0x69DD  ;; Opcode for ld ixl, c
                            130 .endm
                            131 
                            132 ;; Macro: ld__ixl_d
                            133 ;;    Opcode for "LD ixl, D" instruction
                            134 ;; 
                            135 .macro ld__ixl_d
                            136    .dw #0x6ADD  ;; Opcode for ld ixl, d
                            137 .endm
                            138 
                            139 ;; Macro: ld__ixl_e
                            140 ;;    Opcode for "LD ixl, E" instruction
                            141 ;; 
                            142 .macro ld__ixl_e
                            143    .dw #0x6BDD  ;; Opcode for ld ixl, e
                            144 .endm
                            145 
                            146 ;; Macro: ld__ixl_ixh
                            147 ;;    Opcode for "LD ixl, IXH" instruction
                            148 ;; 
                            149 .macro ld__ixl_ixh
                            150    .dw #0x6CDD  ;; Opcode for ld ixl, ixh
                            151 .endm
                            152 
                            153 ;; Macro: ld__a_ixl
                            154 ;;    Opcode for "LD A, ixl" instruction
                            155 ;; 
                            156 .macro ld__a_ixl
                            157    .dw #0x7DDD  ;; Opcode for ld a, ixl
                            158 .endm
                            159 
                            160 ;; Macro: ld__b_ixl
                            161 ;;    Opcode for "LD B, ixl" instruction
                            162 ;; 
                            163 .macro ld__b_ixl
                            164    .dw #0x45DD  ;; Opcode for ld b, ixl
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 20.
Hexadecimal [16-Bits]



                            165 .endm
                            166 
                            167 ;; Macro: ld__c_ixl
                            168 ;;    Opcode for "LD c, ixl" instruction
                            169 ;; 
                            170 .macro ld__c_ixl
                            171    .dw #0x4DDD  ;; Opcode for ld c, ixl
                            172 .endm
                            173 
                            174 ;; Macro: ld__d_ixl
                            175 ;;    Opcode for "LD D, ixl" instruction
                            176 ;; 
                            177 .macro ld__d_ixl
                            178    .dw #0x55DD  ;; Opcode for ld d, ixl
                            179 .endm
                            180 
                            181 ;; Macro: ld__e_ixl
                            182 ;;    Opcode for "LD e, ixl" instruction
                            183 ;; 
                            184 .macro ld__e_ixl
                            185    .dw #0x5DDD  ;; Opcode for ld e, ixl
                            186 .endm
                            187 
                            188 ;; Macro: add__ixl
                            189 ;;    Opcode for "Add ixl" instruction
                            190 ;; 
                            191 .macro add__ixl
                            192    .dw #0x85DD  ;; Opcode for add ixl
                            193 .endm
                            194 
                            195 ;; Macro: sub__ixl
                            196 ;;    Opcode for "SUB ixl" instruction
                            197 ;; 
                            198 .macro sub__ixl
                            199    .dw #0x95DD  ;; Opcode for sub ixl
                            200 .endm
                            201 
                            202 ;; Macro: adc__ixl
                            203 ;;    Opcode for "ADC ixl" instruction
                            204 ;; 
                            205 .macro adc__ixl
                            206    .dw #0x8DDD  ;; Opcode for adc ixl
                            207 .endm
                            208 
                            209 ;; Macro: sbc__ixl
                            210 ;;    Opcode for "SBC ixl" instruction
                            211 ;; 
                            212 .macro sbc__ixl
                            213    .dw #0x9DDD  ;; Opcode for sbc ixl
                            214 .endm
                            215 
                            216 ;; Macro: and__ixl
                            217 ;;    Opcode for "AND ixl" instruction
                            218 ;; 
                            219 .macro and__ixl
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 21.
Hexadecimal [16-Bits]



                            220    .dw #0xA5DD  ;; Opcode for and ixl
                            221 .endm
                            222 
                            223 ;; Macro: or__ixl
                            224 ;;    Opcode for "OR ixl" instruction
                            225 ;; 
                            226 .macro or__ixl
                            227    .dw #0xB5DD  ;; Opcode for or ixl
                            228 .endm
                            229 
                            230 ;; Macro: xor__ixl
                            231 ;;    Opcode for "XOR ixl" instruction
                            232 ;; 
                            233 .macro xor__ixl
                            234    .dw #0xADDD  ;; Opcode for xor ixl
                            235 .endm
                            236 
                            237 ;; Macro: cp__ixl
                            238 ;;    Opcode for "CP ixl" instruction
                            239 ;; 
                            240 .macro cp__ixl
                            241    .dw #0xBDDD  ;; Opcode for cp ixl
                            242 .endm
                            243 
                            244 ;; Macro: dec__ixl
                            245 ;;    Opcode for "DEC ixl" instruction
                            246 ;; 
                            247 .macro dec__ixl
                            248    .dw #0x2DDD  ;; Opcode for dec ixl
                            249 .endm
                            250 
                            251 ;; Macro: inc__ixl
                            252 ;;    Opcode for "INC ixl" instruction
                            253 ;; 
                            254 .macro inc__ixl
                            255    .dw #0x2CDD  ;; Opcode for inc ixl
                            256 .endm
                            257 
                            258 
                            259 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;,
                            260 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;,
                            261 ;; IXH Related Macros
                            262 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;,
                            263 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;,
                            264 
                            265 ;; Macro: ld__ixh    Value
                            266 ;;    Opcode for "LD IXH, Value" instruction
                            267 ;;  
                            268 ;; Parameters:
                            269 ;;    Value - An inmediate 8-bits value that will be loaded into IXH
                            270 ;; 
                            271 .macro ld__ixh    Value 
                            272    .db #0xDD, #0x26, Value  ;; Opcode for ld ixh, Value
                            273 .endm
                            274 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 22.
Hexadecimal [16-Bits]



                            275 ;; Macro: ld__ixh_a
                            276 ;;    Opcode for "LD IXH, a" instruction
                            277 ;; 
                            278 .macro ld__ixh_a
                            279    .dw #0x67DD  ;; Opcode for ld ixh, a
                            280 .endm
                            281 
                            282 ;; Macro: ld__ixh_b
                            283 ;;    Opcode for "LD IXH, B" instruction
                            284 ;; 
                            285 .macro ld__ixh_b
                            286    .dw #0x60DD  ;; Opcode for ld ixh, b
                            287 .endm
                            288 
                            289 ;; Macro: ld__ixh_c
                            290 ;;    Opcode for "LD IXH, C" instruction
                            291 ;; 
                            292 .macro ld__ixh_c
                            293    .dw #0x61DD  ;; Opcode for ld ixh, c
                            294 .endm
                            295 
                            296 ;; Macro: ld__ixh_d
                            297 ;;    Opcode for "LD IXH, D" instruction
                            298 ;; 
                            299 .macro ld__ixh_d
                            300    .dw #0x62DD  ;; Opcode for ld ixh, d
                            301 .endm
                            302 
                            303 ;; Macro: ld__ixh_e
                            304 ;;    Opcode for "LD IXH, E" instruction
                            305 ;; 
                            306 .macro ld__ixh_e
                            307    .dw #0x63DD  ;; Opcode for ld ixh, e
                            308 .endm
                            309 
                            310 ;; Macro: ld__ixh_ixl
                            311 ;;    Opcode for "LD IXH, IXL" instruction
                            312 ;; 
                            313 .macro ld__ixh_ixl
                            314    .dw #0x65DD  ;; Opcode for ld ixh, ixl
                            315 .endm
                            316 
                            317 ;; Macro: ld__a_ixh
                            318 ;;    Opcode for "LD A, IXH" instruction
                            319 ;; 
                            320 .macro ld__a_ixh
                            321    .dw #0x7CDD  ;; Opcode for ld a, ixh
                            322 .endm
                            323 
                            324 ;; Macro: ld__b_ixh
                            325 ;;    Opcode for "LD B, IXH" instruction
                            326 ;; 
                            327 .macro ld__b_ixh
                            328    .dw #0x44DD  ;; Opcode for ld b, ixh
                            329 .endm
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 23.
Hexadecimal [16-Bits]



                            330 
                            331 ;; Macro: ld__c_ixh
                            332 ;;    Opcode for "LD c, IXH" instruction
                            333 ;; 
                            334 .macro ld__c_ixh
                            335    .dw #0x4CDD  ;; Opcode for ld c, ixh
                            336 .endm
                            337 
                            338 ;; Macro: ld__d_ixh
                            339 ;;    Opcode for "LD D, IXH" instruction
                            340 ;; 
                            341 .macro ld__d_ixh
                            342    .dw #0x54DD  ;; Opcode for ld d, ixh
                            343 .endm
                            344 
                            345 ;; Macro: ld__e_ixh
                            346 ;;    Opcode for "LD e, IXH" instruction
                            347 ;; 
                            348 .macro ld__e_ixh
                            349    .dw #0x5CDD  ;; Opcode for ld e, ixh
                            350 .endm
                            351 
                            352 ;; Macro: add__ixh
                            353 ;;    Opcode for "ADD IXH" instruction
                            354 ;; 
                            355 .macro add__ixh
                            356    .dw #0x84DD  ;; Opcode for add ixh
                            357 .endm
                            358 
                            359 ;; Macro: sub__ixh
                            360 ;;    Opcode for "SUB IXH" instruction
                            361 ;; 
                            362 .macro sub__ixh
                            363    .dw #0x94DD  ;; Opcode for sub ixh
                            364 .endm
                            365 
                            366 ;; Macro: adc__ixh
                            367 ;;    Opcode for "ADC IXH" instruction
                            368 ;; 
                            369 .macro adc__ixh
                            370    .dw #0x8CDD  ;; Opcode for adc ixh
                            371 .endm
                            372 
                            373 ;; Macro: sbc__ixh
                            374 ;;    Opcode for "SBC IXH" instruction
                            375 ;; 
                            376 .macro sbc__ixh
                            377    .dw #0x9CDD  ;; Opcode for sbc ixh
                            378 .endm
                            379 
                            380 ;; Macro: and__ixh
                            381 ;;    Opcode for "AND IXH" instruction
                            382 ;; 
                            383 .macro and__ixh
                            384    .dw #0xA4DD  ;; Opcode for and ixh
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 24.
Hexadecimal [16-Bits]



                            385 .endm
                            386 
                            387 ;; Macro: or__ixh
                            388 ;;    Opcode for "OR IXH" instruction
                            389 ;; 
                            390 .macro or__ixh
                            391    .dw #0xB4DD  ;; Opcode for or ixh
                            392 .endm
                            393 
                            394 ;; Macro: xor__ixh
                            395 ;;    Opcode for "XOR IXH" instruction
                            396 ;; 
                            397 .macro xor__ixh
                            398    .dw #0xACDD  ;; Opcode for xor ixh
                            399 .endm
                            400 
                            401 ;; Macro: cp__ixh
                            402 ;;    Opcode for "CP IXH" instruction
                            403 ;; 
                            404 .macro cp__ixh
                            405    .dw #0xBCDD  ;; Opcode for cp ixh
                            406 .endm
                            407 
                            408 ;; Macro: dec__ixh
                            409 ;;    Opcode for "DEC IXH" instruction
                            410 ;; 
                            411 .macro dec__ixh
                            412    .dw #0x25DD  ;; Opcode for dec ixh
                            413 .endm
                            414 
                            415 ;; Macro: inc__ixh
                            416 ;;    Opcode for "INC IXH" instruction
                            417 ;; 
                            418 .macro inc__ixh
                            419    .dw #0x24DD  ;; Opcode for inc ixh
                            420 .endm
                            421 
                            422 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;,
                            423 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;,
                            424 ;; IYL Related Macros
                            425 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;,
                            426 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;,
                            427 
                            428 ;; Macro: ld__iyl    Value
                            429 ;;    Opcode for "LD iyl, Value" instruction
                            430 ;;  
                            431 ;; Parameters:
                            432 ;;    Value - An inmediate 8-bits value that will be loaded into iyl
                            433 ;; 
                            434 .macro ld__iyl    Value 
                            435    .db #0xFD, #0x2E, Value  ;; Opcode for ld iyl, Value
                            436 .endm
                            437 
                            438 ;; Macro: ld__iyl_a
                            439 ;;    Opcode for "LD iyl, a" instruction
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 25.
Hexadecimal [16-Bits]



                            440 ;; 
                            441 .macro ld__iyl_a
                            442    .dw #0x6FFD  ;; Opcode for ld iyl, a
                            443 .endm
                            444 
                            445 ;; Macro: ld__iyl_b
                            446 ;;    Opcode for "LD iyl, B" instruction
                            447 ;; 
                            448 .macro ld__iyl_b
                            449    .dw #0x68FD  ;; Opcode for ld iyl, b
                            450 .endm
                            451 
                            452 ;; Macro: ld__iyl_c
                            453 ;;    Opcode for "LD iyl, C" instruction
                            454 ;; 
                            455 .macro ld__iyl_c
                            456    .dw #0x69FD  ;; Opcode for ld iyl, c
                            457 .endm
                            458 
                            459 ;; Macro: ld__iyl_d
                            460 ;;    Opcode for "LD iyl, D" instruction
                            461 ;; 
                            462 .macro ld__iyl_d
                            463    .dw #0x6AFD  ;; Opcode for ld iyl, d
                            464 .endm
                            465 
                            466 ;; Macro: ld__iyl_e
                            467 ;;    Opcode for "LD iyl, E" instruction
                            468 ;; 
                            469 .macro ld__iyl_e
                            470    .dw #0x6BFD  ;; Opcode for ld iyl, e
                            471 .endm
                            472 
                            473 ;; Macro: ld__iyl_iyh
                            474 ;;    Opcode for "LD iyl, IXL" instruction
                            475 ;; 
                            476 .macro ld__iyl_iyh
                            477    .dw #0x6CFD  ;; Opcode for ld iyl, ixl
                            478 .endm
                            479 
                            480 ;; Macro: ld__a_iyl
                            481 ;;    Opcode for "LD A, iyl" instruction
                            482 ;; 
                            483 .macro ld__a_iyl
                            484    .dw #0x7DFD  ;; Opcode for ld a, iyl
                            485 .endm
                            486 
                            487 ;; Macro: ld__b_iyl
                            488 ;;    Opcode for "LD B, iyl" instruction
                            489 ;; 
                            490 .macro ld__b_iyl
                            491    .dw #0x45FD  ;; Opcode for ld b, iyl
                            492 .endm
                            493 
                            494 ;; Macro: ld__c_iyl
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 26.
Hexadecimal [16-Bits]



                            495 ;;    Opcode for "LD c, iyl" instruction
                            496 ;; 
                            497 .macro ld__c_iyl
                            498    .dw #0x4DFD  ;; Opcode for ld c, iyl
                            499 .endm
                            500 
                            501 ;; Macro: ld__d_iyl
                            502 ;;    Opcode for "LD D, iyl" instruction
                            503 ;; 
                            504 .macro ld__d_iyl
                            505    .dw #0x55FD  ;; Opcode for ld d, iyl
                            506 .endm
                            507 
                            508 ;; Macro: ld__e_iyl
                            509 ;;    Opcode for "LD e, iyl" instruction
                            510 ;; 
                            511 .macro ld__e_iyl
                            512    .dw #0x5DFD  ;; Opcode for ld e, iyl
                            513 .endm
                            514 
                            515 ;; Macro: add__iyl
                            516 ;;    Opcode for "Add iyl" instruction
                            517 ;; 
                            518 .macro add__iyl
                            519    .dw #0x85FD  ;; Opcode for add iyl
                            520 .endm
                            521 
                            522 ;; Macro: sub__iyl
                            523 ;;    Opcode for "SUB iyl" instruction
                            524 ;; 
                            525 .macro sub__iyl
                            526    .dw #0x95FD  ;; Opcode for sub iyl
                            527 .endm
                            528 
                            529 ;; Macro: adc__iyl
                            530 ;;    Opcode for "ADC iyl" instruction
                            531 ;; 
                            532 .macro adc__iyl
                            533    .dw #0x8DFD  ;; Opcode for adc iyl
                            534 .endm
                            535 
                            536 ;; Macro: sbc__iyl
                            537 ;;    Opcode for "SBC iyl" instruction
                            538 ;; 
                            539 .macro sbc__iyl
                            540    .dw #0x9DFD  ;; Opcode for sbc iyl
                            541 .endm
                            542 
                            543 ;; Macro: and__iyl
                            544 ;;    Opcode for "AND iyl" instruction
                            545 ;; 
                            546 .macro and__iyl
                            547    .dw #0xA5FD  ;; Opcode for and iyl
                            548 .endm
                            549 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 27.
Hexadecimal [16-Bits]



                            550 ;; Macro: or__iyl
                            551 ;;    Opcode for "OR iyl" instruction
                            552 ;; 
                            553 .macro or__iyl
                            554    .dw #0xB5FD  ;; Opcode for or iyl
                            555 .endm
                            556 
                            557 ;; Macro: xor__iyl
                            558 ;;    Opcode for "XOR iyl" instruction
                            559 ;; 
                            560 .macro xor__iyl
                            561    .dw #0xADFD  ;; Opcode for xor iyl
                            562 .endm
                            563 
                            564 ;; Macro: cp__iyl
                            565 ;;    Opcode for "CP iyl" instruction
                            566 ;; 
                            567 .macro cp__iyl
                            568    .dw #0xBDFD  ;; Opcode for cp iyl
                            569 .endm
                            570 
                            571 ;; Macro: dec__iyl
                            572 ;;    Opcode for "DEC iyl" instruction
                            573 ;; 
                            574 .macro dec__iyl
                            575    .dw #0x2DFD  ;; Opcode for dec iyl
                            576 .endm
                            577 
                            578 ;; Macro: inc__iyl
                            579 ;;    Opcode for "INC iyl" instruction
                            580 ;; 
                            581 .macro inc__iyl
                            582    .dw #0x2CFD  ;; Opcode for inc iyl
                            583 .endm
                            584 
                            585 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;,
                            586 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;,
                            587 ;; IYH Related Macros
                            588 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;,
                            589 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;,
                            590 
                            591 ;; Macro: ld__iyh    Value
                            592 ;;    Opcode for "LD iyh, Value" instruction
                            593 ;;  
                            594 ;; Parameters:
                            595 ;;    Value - An inmediate 8-bits value that will be loaded into iyh
                            596 ;; 
                            597 .macro ld__iyh    Value 
                            598    .db #0xFD, #0x26, Value  ;; Opcode for ld iyh, Value
                            599 .endm
                            600 
                            601 ;; Macro: ld__iyh_a
                            602 ;;    Opcode for "LD iyh, a" instruction
                            603 ;; 
                            604 .macro ld__iyh_a
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 28.
Hexadecimal [16-Bits]



                            605    .dw #0x67FD  ;; Opcode for ld iyh, a
                            606 .endm
                            607 
                            608 ;; Macro: ld__iyh_b
                            609 ;;    Opcode for "LD iyh, B" instruction
                            610 ;; 
                            611 .macro ld__iyh_b
                            612    .dw #0x60FD  ;; Opcode for ld iyh, b
                            613 .endm
                            614 
                            615 ;; Macro: ld__iyh_c
                            616 ;;    Opcode for "LD iyh, C" instruction
                            617 ;; 
                            618 .macro ld__iyh_c
                            619    .dw #0x61FD  ;; Opcode for ld iyh, c
                            620 .endm
                            621 
                            622 ;; Macro: ld__iyh_d
                            623 ;;    Opcode for "LD iyh, D" instruction
                            624 ;; 
                            625 .macro ld__iyh_d
                            626    .dw #0x62FD  ;; Opcode for ld iyh, d
                            627 .endm
                            628 
                            629 ;; Macro: ld__iyh_e
                            630 ;;    Opcode for "LD iyh, E" instruction
                            631 ;; 
                            632 .macro ld__iyh_e
                            633    .dw #0x63FD  ;; Opcode for ld iyh, e
                            634 .endm
                            635 
                            636 ;; Macro: ld__iyh_iyl
                            637 ;;    Opcode for "LD iyh, IyL" instruction
                            638 ;; 
                            639 .macro ld__iyh_iyl
                            640    .dw #0x65FD  ;; Opcode for ld iyh, iyl
                            641 .endm
                            642 
                            643 ;; Macro: ld__a_iyh
                            644 ;;    Opcode for "LD A, iyh" instruction
                            645 ;; 
                            646 .macro ld__a_iyh
                            647    .dw #0x7CFD  ;; Opcode for ld a, iyh
                            648 .endm
                            649 
                            650 ;; Macro: ld__b_iyh
                            651 ;;    Opcode for "LD B, iyh" instruction
                            652 ;; 
                            653 .macro ld__b_iyh
                            654    .dw #0x44FD  ;; Opcode for ld b, iyh
                            655 .endm
                            656 
                            657 ;; Macro: ld__c_iyh
                            658 ;;    Opcode for "LD c, iyh" instruction
                            659 ;; 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 29.
Hexadecimal [16-Bits]



                            660 .macro ld__c_iyh
                            661    .dw #0x4CFD  ;; Opcode for ld c, iyh
                            662 .endm
                            663 
                            664 ;; Macro: ld__d_iyh
                            665 ;;    Opcode for "LD D, iyh" instruction
                            666 ;; 
                            667 .macro ld__d_iyh
                            668    .dw #0x54FD  ;; Opcode for ld d, iyh
                            669 .endm
                            670 
                            671 ;; Macro: ld__e_iyh
                            672 ;;    Opcode for "LD e, iyh" instruction
                            673 ;; 
                            674 .macro ld__e_iyh
                            675    .dw #0x5CFD  ;; Opcode for ld e, iyh
                            676 .endm
                            677 
                            678 ;; Macro: add__iyh
                            679 ;;    Opcode for "Add iyh" instruction
                            680 ;; 
                            681 .macro add__iyh
                            682    .dw #0x84FD  ;; Opcode for add iyh
                            683 .endm
                            684 
                            685 ;; Macro: sub__iyh
                            686 ;;    Opcode for "SUB iyh" instruction
                            687 ;; 
                            688 .macro sub__iyh
                            689    .dw #0x94FD  ;; Opcode for sub iyh
                            690 .endm
                            691 
                            692 ;; Macro: adc__iyh
                            693 ;;    Opcode for "ADC iyh" instruction
                            694 ;; 
                            695 .macro adc__iyh
                            696    .dw #0x8CFD  ;; Opcode for adc iyh
                            697 .endm
                            698 
                            699 ;; Macro: sbc__iyh
                            700 ;;    Opcode for "SBC iyh" instruction
                            701 ;; 
                            702 .macro sbc__iyh
                            703    .dw #0x9CFD  ;; Opcode for sbc iyh
                            704 .endm
                            705 
                            706 ;; Macro: and__iyh
                            707 ;;    Opcode for "AND iyh" instruction
                            708 ;; 
                            709 .macro and__iyh
                            710    .dw #0xA4FD  ;; Opcode for and iyh
                            711 .endm
                            712 
                            713 ;; Macro: or__iyh
                            714 ;;    Opcode for "OR iyh" instruction
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 30.
Hexadecimal [16-Bits]



                            715 ;; 
                            716 .macro or__iyh
                            717    .dw #0xB4FD  ;; Opcode for or iyh
                            718 .endm
                            719 
                            720 ;; Macro: xor__iyh
                            721 ;;    Opcode for "XOR iyh" instruction
                            722 ;; 
                            723 .macro xor__iyh
                            724    .dw #0xACFD  ;; Opcode for xor iyh
                            725 .endm
                            726 
                            727 ;; Macro: cp__iyh
                            728 ;;    Opcode for "CP iyh" instruction
                            729 ;; 
                            730 .macro cp__iyh
                            731    .dw #0xBCFD  ;; Opcode for cp iyh
                            732 .endm
                            733 
                            734 ;; Macro: dec__iyh
                            735 ;;    Opcode for "DEC iyh" instruction
                            736 ;; 
                            737 .macro dec__iyh
                            738    .dw #0x25FD  ;; Opcode for dec iyh
                            739 .endm
                            740 
                            741 ;; Macro: inc__iyh
                            742 ;;    Opcode for "INC iyh" instruction
                            743 ;; 
                            744 .macro inc__iyh
                            745    .dw #0x24FD  ;; Opcode for inc iyh
                            746 .endm
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 31.
Hexadecimal [16-Bits]



                             23 
                             24 ;;//////////////////////////////////////////////////////////////////////
                             25 ;; Group: General Useful Macros
                             26 ;;//////////////////////////////////////////////////////////////////////
                             27 
                             28 ;;
                             29 ;; Macro: cpctm_produceHalts_asm
                             30 ;;
                             31 ;;   Produce a set of consecutive halt instructions in order to wait for 
                             32 ;; a given number of interrupts.
                             33 ;;
                             34 ;; C Definition:
                             35 ;;   .macro <cpctm_produceHalts_asm> *N*
                             36 ;;
                             37 ;; Input Parameters:
                             38 ;;   (_) N - Number of consecutive halts to be produced
                             39 ;;
                             40 ;; Known issues:
                             41 ;;    * *N* must be a constant expression that can evaluate to a number
                             42 ;; at compile time.
                             43 ;;    * If the code generated by this macro is executed with interrupts
                             44 ;; being disabled, your CPU will effectively hang forever.
                             45 ;;    * This macro can only be used from assembler code. For C callings
                             46 ;; use <cpctm_produceHalts> instead.
                             47 ;;
                             48 ;; Size of generated code:
                             49 ;;    * *N* bytes (1 byte each halt instruction produced)
                             50 ;;
                             51 ;; Time Measures:
                             52 ;;    * Time depends on the exact moment of execution and the status of
                             53 ;; interrupts. *N* interrupts will pass.
                             54 ;;
                             55 ;; Details:
                             56 ;;    This macro produces a set of *N* consecutive *halt* assembly 
                             57 ;; instructions. Each *halt* instruction stops de Z80 CPU until 
                             58 ;; an interrupt is received. Therefore, this waits for *N* interrupts
                             59 ;; to be produced. This can be used for waiting or synchronization 
                             60 ;; purposes.
                             61 ;;
                             62 ;;    Please, take into account that this is a macro, and not a function.
                             63 ;; Each time this macro is used in your code it will produce the requested
                             64 ;; amount of halts. That can produce more code than you effectively need.
                             65 ;; For a unique function that controls a loop of *halt* waiting use
                             66 ;; <cpct_waitHalts> instead.
                             67 ;;
                             68 ;;
                             69 .macro cpctm_produceHalts N
                             70    .rept N
                             71       halt
                             72    .endm
                             73 .endm
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 32.
Hexadecimal [16-Bits]



                             21 .include "keyboard/keyboard.h.s"
                              1 ;;-----------------------------LICENSE NOTICE------------------------------------
                              2 ;;  This file is part of CPCtelera: An Amstrad CPC Game Engine 
                              3 ;;  Copyright (C) 2017 ronaldo / Fremos / Cheesetea / ByteRealms (@FranGallegoBR)
                              4 ;;
                              5 ;;  This program is free software: you can redistribute it and/or modify
                              6 ;;  it under the terms of the GNU Lesser General Public License as published by
                              7 ;;  the Free Software Foundation, either version 3 of the License, or
                              8 ;;  (at your option) any later version.
                              9 ;;
                             10 ;;  This program is distributed in the hope that it will be useful,
                             11 ;;  but WITHOUT ANY WARRANTY; without even the implied warranty of
                             12 ;;  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                             13 ;;  GNU Lesser General Public License for more details.
                             14 ;;
                             15 ;;  You should have received a copy of the GNU Lesser General Public License
                             16 ;;  along with this program.  If not, see <http://www.gnu.org/licenses/>.
                             17 ;;-------------------------------------------------------------------------------
                             18 .module cpct_keyboard
                             19 
                             20 ;;
                             21 ;; Constant: Key Definitions (asm)
                             22 ;;
                             23 ;;    Definitions of the KeyCodes required by <cpct_isKeyPressed> 
                             24 ;; function for assembler programs. These are 16-bit values that define 
                             25 ;; matrix line in the keyboard layout (Most Significant Byte) and bit to
                             26 ;; be tested in that matrix line status for the given key (Least Significant
                             27 ;; byte). Each matrix line in the keyboard returns a byte containing the
                             28 ;; status of 8 keys, 1 bit each.
                             29 ;;
                             30 ;; CPCtelera include file:
                             31 ;;    _keyboard/keyboard.h.s_
                             32 ;;
                             33 ;; Keycode constant names:
                             34 ;; (start code)
                             35 ;;  KeyCode | Constant        || KeyCode | Constant      || KeyCode |  Constant
                             36 ;; -------------------------------------------------------------------------------
                             37 ;;   0x0100 | Key_CursorUp    ||  0x0803 | Key_P         ||  0x4006 |  Key_B
                             38 ;;          |                 ||         |               ||     ''  |  Joy1_Fire3
                             39 ;;   0x0200 | Key_CursorRight ||  0x1003 | Key_SemiColon ||  0x8006 |  Key_V
                             40 ;;   0x0400 | Key_CursorDown  ||  0x2003 | Key_Colon     ||  0x0107 |  Key_4
                             41 ;;   0x0800 | Key_F9          ||  0x4003 | Key_Slash     ||  0x0207 |  Key_3
                             42 ;;   0x1000 | Key_F6          ||  0x8003 | Key_Dot       ||  0x0407 |  Key_E
                             43 ;;   0x2000 | Key_F3          ||  0x0104 | Key_0         ||  0x0807 |  Key_W
                             44 ;;   0x4000 | Key_Enter       ||  0x0204 | Key_9         ||  0x1007 |  Key_S
                             45 ;;   0x8000 | Key_FDot        ||  0x0404 | Key_O         ||  0x2007 |  Key_D
                             46 ;;   0x0101 | Key_CursorLeft  ||  0x0804 | Key_I         ||  0x4007 |  Key_C
                             47 ;;   0x0201 | Key_Copy        ||  0x1004 | Key_L         ||  0x8007 |  Key_X
                             48 ;;   0x0401 | Key_F7          ||  0x2004 | Key_K         ||  0x0108 |  Key_1
                             49 ;;   0x0801 | Key_F8          ||  0x4004 | Key_M         ||  0x0208 |  Key_2
                             50 ;;   0x1001 | Key_F5          ||  0x8004 | Key_Comma     ||  0x0408 |  Key_Esc
                             51 ;;   0x2001 | Key_F1          ||  0x0105 | Key_8         ||  0x0808 |  Key_Q
                             52 ;;   0x4001 | Key_F2          ||  0x0205 | Key_7         ||  0x1008 |  Key_Tab
                             53 ;;   0x8001 | Key_F0          ||  0x0405 | Key_U         ||  0x2008 |  Key_A
                             54 ;;   0x0102 | Key_Clr         ||  0x0805 | Key_Y         ||  0x4008 |  Key_CapsLock
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 33.
Hexadecimal [16-Bits]



                             55 ;;   0x0202 | Key_OpenBracket ||  0x1005 | Key_H         ||  0x8008 |  Key_Z
                             56 ;;   0x0402 | Key_Return      ||  0x2005 | Key_J         ||  0x0109 |  Joy0_Up
                             57 ;;   0x0802 | Key_CloseBracket||  0x4005 | Key_N         ||  0x0209 |  Joy0_Down
                             58 ;;   0x1002 | Key_F4          ||  0x8005 | Key_Space     ||  0x0409 |  Joy0_Left
                             59 ;;   0x2002 | Key_Shift       ||  0x0106 | Key_6         ||  0x0809 |  Joy0_Right
                             60 ;;          |                 ||     ''  | Joy1_Up       ||         |
                             61 ;;   0x4002 | Key_BackSlash   ||  0x0206 | Key_5         ||  0x1009 |  Joy0_Fire1
                             62 ;;          |                 ||     ''  | Joy1_Down     ||         |
                             63 ;;   0x8002 | Key_Control     ||  0x0406 | Key_R         ||  0x2009 |  Joy0_Fire2
                             64 ;;          |                 ||     ''  | Joy1_Left     ||         |
                             65 ;;   0x0103 | Key_Caret       ||  0x0806 | Key_T         ||  0x4009 |  Joy0_Fire3
                             66 ;;          |                 ||     ''  | Joy1 Right    ||
                             67 ;;   0x0203 | Key_Hyphen      ||  0x1006 | Key_G         ||  0x8009 |  Key_Del
                             68 ;;          |                 ||     ''  | Joy1_Fire1    ||
                             69 ;;   0x0403 | Key_At          ||  0x2006 | Key_F         ||
                             70 ;;          |                 ||     ''  | Joy1_Fire2    ||
                             71 ;; -------------------------------------------------------------------------------
                             72 ;;  Table 1. KeyCodes defined for each possible key, ordered by KeyCode
                             73 ;; (end)
                             74 ;;
                             75 
                             76 ;; Matrix Line 0x00
                     0100    77 Key_CursorUp     = #0x0100  ;; Bit 0 (01h) => | 0000 0001 |
                     0200    78 Key_CursorRight  = #0x0200  ;; Bit 1 (02h) => | 0000 0010 |
                     0400    79 Key_CursorDown   = #0x0400  ;; Bit 2 (04h) => | 0000 0100 |
                     0800    80 Key_F9           = #0x0800  ;; Bit 3 (08h) => | 0000 1000 |
                     1000    81 Key_F6           = #0x1000  ;; Bit 4 (10h) => | 0001 0000 |
                     2000    82 Key_F3           = #0x2000  ;; Bit 5 (20h) => | 0010 0000 |
                     4000    83 Key_Enter        = #0x4000  ;; Bit 6 (40h) => | 0100 0000 |
                     8000    84 Key_FDot         = #0x8000  ;; Bit 7 (80h) => | 1000 0000 |
                             85 ;; Matrix Line 0x01
                     0101    86 Key_CursorLeft   = #0x0101
                     0201    87 Key_Copy         = #0x0201
                     0401    88 Key_F7           = #0x0401
                     0801    89 Key_F8           = #0x0801
                     1001    90 Key_F5           = #0x1001
                     2001    91 Key_F1           = #0x2001
                     4001    92 Key_F2           = #0x4001
                     8001    93 Key_F0           = #0x8001
                             94 ;; Matrix Line 0x02
                     0102    95 Key_Clr          = #0x0102
                     0202    96 Key_OpenBracket  = #0x0202
                     0402    97 Key_Return       = #0x0402
                     0802    98 Key_CloseBracket = #0x0802
                     1002    99 Key_F4           = #0x1002
                     2002   100 Key_Shift        = #0x2002
                     4002   101 Key_BackSlash    = #0x4002
                     8002   102 Key_Control      = #0x8002
                            103 ;; Matrix Line 0x03
                     0103   104 Key_Caret        = #0x0103
                     0203   105 Key_Hyphen       = #0x0203
                     0403   106 Key_At           = #0x0403
                     0803   107 Key_P            = #0x0803
                     1003   108 Key_SemiColon    = #0x1003
                     2003   109 Key_Colon        = #0x2003
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 34.
Hexadecimal [16-Bits]



                     4003   110 Key_Slash        = #0x4003
                     8003   111 Key_Dot          = #0x8003
                            112 ;; Matrix Line 0x04
                     0104   113 Key_0            = #0x0104
                     0204   114 Key_9            = #0x0204
                     0404   115 Key_O            = #0x0404
                     0804   116 Key_I            = #0x0804
                     1004   117 Key_L            = #0x1004
                     2004   118 Key_K            = #0x2004
                     4004   119 Key_M            = #0x4004
                     8004   120 Key_Comma        = #0x8004
                            121 ;; Matrix Line 0x05
                     0105   122 Key_8            = #0x0105
                     0205   123 Key_7            = #0x0205
                     0405   124 Key_U            = #0x0405
                     0805   125 Key_Y            = #0x0805
                     1005   126 Key_H            = #0x1005
                     2005   127 Key_J            = #0x2005
                     4005   128 Key_N            = #0x4005
                     8005   129 Key_Space        = #0x8005
                            130 ;; Matrix Line 0x06
                     0106   131 Key_6            = #0x0106
                     0106   132 Joy1_Up          = #0x0106
                     0206   133 Key_5            = #0x0206
                     0206   134 Joy1_Down        = #0x0206
                     0406   135 Key_R            = #0x0406
                     0406   136 Joy1_Left        = #0x0406
                     0806   137 Key_T            = #0x0806
                     0806   138 Joy1_Right       = #0x0806
                     1006   139 Key_G            = #0x1006
                     1006   140 Joy1_Fire1       = #0x1006
                     2006   141 Key_F            = #0x2006
                     2006   142 Joy1_Fire2       = #0x2006
                     4006   143 Key_B            = #0x4006
                     4006   144 Joy1_Fire3       = #0x4006
                     8006   145 Key_V            = #0x8006
                            146 ;; Matrix Line 0x07
                     0107   147 Key_4            = #0x0107
                     0207   148 Key_3            = #0x0207
                     0407   149 Key_E            = #0x0407
                     0807   150 Key_W            = #0x0807
                     1007   151 Key_S            = #0x1007
                     2007   152 Key_D            = #0x2007
                     4007   153 Key_C            = #0x4007
                     8007   154 Key_X            = #0x8007
                            155 ;; Matrix Line 0x08
                     0108   156 Key_1            = #0x0108
                     0208   157 Key_2            = #0x0208
                     0408   158 Key_Esc          = #0x0408
                     0808   159 Key_Q            = #0x0808
                     1008   160 Key_Tab          = #0x1008
                     2008   161 Key_A            = #0x2008
                     4008   162 Key_CapsLock     = #0x4008
                     8008   163 Key_Z            = #0x8008
                            164 ;; Matrix Line 0x09
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 35.
Hexadecimal [16-Bits]



                     0109   165 Joy0_Up          = #0x0109
                     0209   166 Joy0_Down        = #0x0209
                     0409   167 Joy0_Left        = #0x0409
                     0809   168 Joy0_Right       = #0x0809
                     1009   169 Joy0_Fire1       = #0x1009
                     2009   170 Joy0_Fire2       = #0x2009
                     4009   171 Joy0_Fire3       = #0x4009
                     8009   172 Key_Del          = #0x8009
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 36.
Hexadecimal [16-Bits]



                             22 .include "video/videomode.h.s"
                              1 ;;-----------------------------LICENSE NOTICE------------------------------------
                              2 ;;  This file is part of CPCtelera: An Amstrad CPC Game Engine
                              3 ;;  Copyright (C) 2017 ronaldo / Fremos / Cheesetea / ByteRealms (@FranGallegoBR)
                              4 ;;
                              5 ;;  This program is free software: you can redistribute it and/or modify
                              6 ;;  it under the terms of the GNU Lesser General Public License as published by
                              7 ;;  the Free Software Foundation, either version 3 of the License, or
                              8 ;;  (at your option) any later version.
                              9 ;;
                             10 ;;  This program is distributed in the hope that it will be useful,
                             11 ;;  but WITHOUT ANY WARRANTY; without even the implied warranty of
                             12 ;;  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                             13 ;;  GNU Lesser General Public License for more details.
                             14 ;;
                             15 ;;  You should have received a copy of the GNU Lesser General Public License
                             16 ;;  along with this program.  If not, see <http://www.gnu.org/licenses/>.
                             17 ;;-------------------------------------------------------------------------------
                             18 .module cpct_video
                             19    
                             20 ;;
                             21 ;; Includes
                             22 ;;
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 37.
Hexadecimal [16-Bits]



                             23 .include "video/video_macros.h.s"
                              1 ;;-----------------------------LICENSE NOTICE------------------------------------
                              2 ;;  This file is part of CPCtelera: An Amstrad CPC Game Engine
                              3 ;;  Copyright (C) 2017 ronaldo / Fremos / Cheesetea / ByteRealms (@FranGallegoBR)
                              4 ;;
                              5 ;;  This program is free software: you can redistribute it and/or modify
                              6 ;;  it under the terms of the GNU Lesser General Public License as published by
                              7 ;;  the Free Software Foundation, either version 3 of the License, or
                              8 ;;  (at your option) any later version.
                              9 ;;
                             10 ;;  This program is distributed in the hope that it will be useful,
                             11 ;;  but WITHOUT ANY WARRANTY; without even the implied warranty of
                             12 ;;  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                             13 ;;  GNU Lesser General Public License for more details.
                             14 ;;
                             15 ;;  You should have received a copy of the GNU Lesser General Public License
                             16 ;;  along with this program.  If not, see <http://www.gnu.org/licenses/>.
                             17 ;;-------------------------------------------------------------------------------
                             18 
                             19 ;;//////////////////////////////////////////////////////////////////////
                             20 ;;//////////////////////////////////////////////////////////////////////
                             21 ;; File: Macros (asm)
                             22 ;;//////////////////////////////////////////////////////////////////////
                             23 ;;//////////////////////////////////////////////////////////////////////
                             24 
                             25 ;;//////////////////////////////////////////////////////////////////////
                             26 ;; Group: Video memory manipulation
                             27 ;;//////////////////////////////////////////////////////////////////////
                             28 
                             29 ;;
                             30 ;; Constant: CPCT_VMEM_START_ASM
                             31 ;;
                             32 ;;    The address where screen video memory starts by default in the Amstrad CPC.
                             33 ;;
                             34 ;;    This address is exactly 0xC000, and this macro represents this number but
                             35 ;; automatically converted to <u8>* (Pointer to unsigned byte). You can use this
                             36 ;; macro for any function requiring the start of video memory, like 
                             37 ;; <cpct_getScreenPtr>.
                             38 ;;
                     C000    39 CPCT_VMEM_START_ASM = 0xC000
                             40 
                             41 ;;
                             42 ;; Constants: Video Memory Pages
                             43 ;;
                             44 ;; Useful constants defining some typical Video Memory Pages to be used as 
                             45 ;; parameters for <cpct_setVideoMemoryPage>
                             46 ;;
                             47 ;; cpct_pageCO - Video Memory Page 0xC0 (0xC0··)
                             48 ;; cpct_page8O - Video Memory Page 0x80 (0x80··)
                             49 ;; cpct_page4O - Video Memory Page 0x40 (0x40··)
                             50 ;; cpct_page0O - Video Memory Page 0x00 (0x00··)
                             51 ;;
                     0030    52 cpct_pageC0_asm = 0x30
                     0020    53 cpct_page80_asm = 0x20
                     0010    54 cpct_page40_asm = 0x10
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 38.
Hexadecimal [16-Bits]



                     0000    55 cpct_page00_asm = 0x00
                             56 
                             57 ;;
                             58 ;; Macro: cpctm_memPage6_asm
                             59 ;;
                             60 ;;    Macro that encodes a video memory page in the 6 Least Significant bits (LSb)
                             61 ;; of a byte, required as parameter for <cpct_setVideoMemoryPage>. It loads resulting
                             62 ;; value into a given 8-bits register.
                             63 ;;
                             64 ;; ASM Definition:
                             65 ;; .macro <cpct_memPage6_asm> *REG8*, *PAGE*
                             66 ;;
                             67 ;; Parameters (1 byte):
                             68 ;; (__) REG8 - 8bits register where result will be loaded
                             69 ;; (1B) PAGE - Video memory page wanted 
                             70 ;;
                             71 ;; Known issues:
                             72 ;;   * This macro can only be used from assembler code. It is not accessible from 
                             73 ;; C scope. For C programs, please refer to <cpct_memPage6>
                             74 ;;   * This macro will work *only* with constant values, as its value needs to
                             75 ;; be calculated in compilation time. If fed with variable values, it will give 
                             76 ;; an assembler error.
                             77 ;;
                             78 ;; Destroyed Registers:
                             79 ;;    REG8
                             80 ;;
                             81 ;; Size of generated code:
                             82 ;;    2 bytes 
                             83 ;;
                             84 ;; Time Measures:
                             85 ;;    * 2 microseconds
                             86 ;;    * 8 CPU Cycles
                             87 ;;
                             88 ;; Details:
                             89 ;;  This is just a macro that shifts *PAGE* 2 bits to the right, to leave it
                             90 ;; with just 6 significant bits. For more information, check functions
                             91 ;; <cpct_setVideoMemoryPage> and <cpct_setVideoMemoryOffset>.
                             92 ;;
                             93 .macro cpctm_memPage6_asm REG8, PAGE 
                             94    ld REG8, #PAGE / 4      ;; [2] REG8 = PAGE/4
                             95 .endm
                             96 
                             97 ;;
                             98 ;; Macro: cpctm_screenPtr_asm
                             99 ;;
                            100 ;;    Macro that calculates the video memory location (byte pointer) of a 
                            101 ;; given pair of coordinates (*X*, *Y*). Value resulting from calculation 
                            102 ;; will be loaded into a 16-bits register.
                            103 ;;
                            104 ;; ASM Definition:
                            105 ;;    .macro <cpctm_screenPtr_asm> *REG16*, *VMEM*, *X*, *Y*
                            106 ;;
                            107 ;; Parameters:
                            108 ;;    (__) REG16 - 16-bits register where the resulting value will be loaded
                            109 ;;    (2B) VMEM  - Start of video memory buffer where (*X*, *Y*) coordinates will be calculated
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 39.
Hexadecimal [16-Bits]



                            110 ;;    (1B) X     - X Coordinate of the video memory location *in bytes* (*BEWARE! NOT in pixels!*)
                            111 ;;    (1B) Y     - Y Coordinate of the video memory location in pixels / bytes (they are same amount)
                            112 ;;
                            113 ;; Parameter Restrictions:
                            114 ;;    * *REG16* has to be a 16-bits register that can perform ld REG16, #value.
                            115 ;;    * *VMEM* will normally be the start of the video memory buffer where you want to 
                            116 ;; draw something. It could theoretically be any 16-bits value. 
                            117 ;;    * *X* must be in the range [0-79] for normal screen sizes (modes 0,1,2). Screen is
                            118 ;; always 80 bytes wide in these modes and this function is byte-aligned, so you have to 
                            119 ;; give it a byte coordinate (*NOT a pixel one!*).
                            120 ;;    * *Y* must be in the range [0-199] for normal screen sizes (modes 0,1,2). Screen is 
                            121 ;; always 200 pixels high in these modes. Pixels and bytes always coincide in vertical
                            122 ;; resolution, so this coordinate is the same in bytes that in pixels.
                            123 ;;    * If you give incorrect values to this function, the returned pointer could
                            124 ;; point anywhere in memory. This function will not cause any damage by itself, 
                            125 ;; but you may destroy important parts of your memory if you use its result to 
                            126 ;; write to memory, and you gave incorrect parameters by mistake. Take always
                            127 ;; care.
                            128 ;;
                            129 ;; Known issues:
                            130 ;;   * This macro can only be used from assembler code. It is not accessible from 
                            131 ;; C scope. For C programs, please refer to <cpct_getScreenPtr>
                            132 ;;   * This macro will work *only* with constant values, as calculations need to be 
                            133 ;; performed at assembler time.
                            134 ;;
                            135 ;; Destroyed Registers:
                            136 ;;    REG16
                            137 ;;
                            138 ;; Size of generated code:
                            139 ;;    3 bytes 
                            140 ;;
                            141 ;; Time Measures:
                            142 ;;    * 3 microseconds
                            143 ;;    * 12 CPU Cycles
                            144 ;;
                            145 ;; Details:
                            146 ;;    This macro does the same calculation than the function <cpct_getScreenPtr>. However,
                            147 ;; as it is a macro, if all 3 parameters (*VMEM*, *X*, *Y*) are constants, the calculation
                            148 ;; will be done at compile-time. This will free the binary from code or data, just putting in
                            149 ;; the result of this calculation (2 bytes with the resulting address). It is highly 
                            150 ;; recommended to use this macro instead of the function <cpct_getScreenPtr> when values
                            151 ;; involved are all constant. 
                            152 ;;
                            153 ;; Recommendations:
                            154 ;;    All constant values - Use this macro <cpctm_screenPtr_asm>
                            155 ;;    Any variable value  - Use the function <cpct_getScreenPtr>
                            156 ;;
                            157 .macro cpctm_screenPtr_asm REG16, VMEM, X, Y 
                            158    ld REG16, #VMEM + 80 * (Y / 8) + 2048 * (Y & 7) + X   ;; [3] REG16 = screenPtr
                            159 .endm
                            160 
                            161 ;;
                            162 ;; Macro: cpctm_setCRTCReg
                            163 ;;
                            164 ;;    Macro that sets a new value for a given CRTC register.
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 40.
Hexadecimal [16-Bits]



                            165 ;;
                            166 ;; ASM Definition:
                            167 ;;    .macro <cpctm_setCRTCReg> *HEXREG*, *HEXVAL*
                            168 ;;
                            169 ;; Parameters:
                            170 ;;    (1B) HEXREG - New value to be set for the register (in hexadecimal)
                            171 ;;    (1B) HEXVAL - Number of the register to be set (in hexadecimal)
                            172 ;;
                            173 ;; Parameter Restrictions:
                            174 ;;    * *HEXREG* has to be an hexadecimal value from 00 to 1F
                            175 ;;    * *HEXVAL* has to be an hexadecimal value. Its valid range will depend
                            176 ;;          upon the selected register that will be modified. 
                            177 ;;
                            178 ;; Known issues:
                            179 ;;   * This macro can *only* be used from assembler code. It is not accessible from 
                            180 ;; C scope. 
                            181 ;;   * This macro can only be used with *constant values*. As given values are 
                            182 ;; concatenated with a number, they must also be hexadecimal numbers. If a 
                            183 ;; register or other value is given, this macro will not work.
                            184 ;;   * Using values out of range have unpredicted behaviour and can even 
                            185 ;; potentially cause damage to real Amstrad CPC monitors. Please, use with care.
                            186 ;;
                            187 ;; Destroyed Registers:
                            188 ;;    BC
                            189 ;;
                            190 ;; Size of generated code:
                            191 ;;    10 bytes 
                            192 ;;
                            193 ;; Time Measures:
                            194 ;;    * 14 microseconds
                            195 ;;    * 56 CPU Cycles
                            196 ;;
                            197 ;; Details:
                            198 ;;    This macro expands to two CRTC commands: Register selection and Register setting.
                            199 ;; It selects the register given as first parameter, then sets its new value to 
                            200 ;; that given as second parameter. Both given parameters must be of exactly 1 byte
                            201 ;; in size and the have to be provided in hexadecimal. This is due to the way
                            202 ;; that macro expansion and concatenation works. Given values will be concatenated
                            203 ;; with another 8-bit hexadecimal value to form a unique 16-bits hexadecimal value.
                            204 ;; Therefore, any parameter given will always be considered hexadecimal.
                            205 ;;
                            206 .macro cpctm_setCRTCReg_asm HEXREG, HEXVAL
                            207    ld    bc, #0xBC'HEXREG  ;; [3] B=0xBC CRTC Select Register, C=register number to be selected
                            208    out  (c), c             ;; [4] Select register
                            209    ld    bc, #0xBD'HEXVAL  ;; [3] B=0xBD CRTC Set Register, C=Value to be set
                            210    out  (c), c             ;; [4] Set the value
                            211 .endm
                            212 
                            213 ;;//////////////////////////////////////////////////////////////////////
                            214 ;; Group: Setting the border
                            215 ;;//////////////////////////////////////////////////////////////////////
                            216 
                            217 ;;
                            218 ;; Macro: cpctm_setBorder_asm
                            219 ;;
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 41.
Hexadecimal [16-Bits]



                            220 ;;   Changes the colour of the screen border.
                            221 ;;
                            222 ;; ASM Definition:
                            223 ;;   .macro <cpct_setBorder_asm> HWC 
                            224 ;;
                            225 ;; Input Parameters (1 Byte):
                            226 ;;   (1B) HWC - Hardware colour value for the screen border in *hexadecimal [00-1B]*.
                            227 ;;
                            228 ;; Known issues:
                            229 ;;   * *Beware!* *HWC* colour value must be given in *hexadecimal*, as it is
                            230 ;; substituted in place, and must be in the range [00-1B].
                            231 ;;   * This macro can only be used from assembler code. It is not accessible from 
                            232 ;; C scope. For C programs, please refer to <cpct_setBorder>
                            233 ;;   * This macro will work *only* with constant values, as calculations need to be 
                            234 ;; performed at assembler time.
                            235 ;;
                            236 ;; Destroyed Registers:
                            237 ;;    HL
                            238 ;;
                            239 ;; Size of generated code:
                            240 ;;    * 16 bytes 
                            241 ;;     6b - generated code
                            242 ;;    10b - cpct_setPALColour_asm code
                            243 ;;
                            244 ;; Time Measures:
                            245 ;;    * 28 microseconds
                            246 ;;    * 112 CPU Cycles
                            247 ;;
                            248 ;; Details:
                            249 ;;   This is not a real function, but an assembler macro. Beware of using it along
                            250 ;; with complex expressions or calculations, as it may expand in non-desired
                            251 ;; ways.
                            252 ;;
                            253 ;;   For more information, check the real function <cpct_setPALColour>, which
                            254 ;; is called when using <cpct_setBorder_asm> (It is called using 16 as *pen*
                            255 ;; argument, which identifies the border).
                            256 ;;
                            257 .macro cpctm_setBorder_asm HWC
                            258    .globl cpct_setPALColour_asm
                            259    ld   hl, #0x'HWC'10         ;; [3]  H=Hardware value of desired colour, L=Border INK (16)
                            260    call cpct_setPALColour_asm  ;; [25] Set Palette colour of the border
                            261 .endm
                            262 
                            263 ;;//////////////////////////////////////////////////////////////////////
                            264 ;; Group: Screen clearing
                            265 ;;//////////////////////////////////////////////////////////////////////
                            266 
                            267 ;;
                            268 ;; Macro: cpctm_clearScreen_asm
                            269 ;;
                            270 ;;    Macro to simplify clearing the screen.
                            271 ;;
                            272 ;; ASM Definition:
                            273 ;;   .macro <cpct_clearScreen_asm> COL
                            274 ;;
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 42.
Hexadecimal [16-Bits]



                            275 ;; Input Parameters (1 byte):
                            276 ;;   (1B) COL - Colour pattern to be used for screen clearing. 
                            277 ;;
                            278 ;; Parameters:
                            279 ;;    *COL* - Any 8-bits value or the A register are valid. Typically, a 0x00 is used 
                            280 ;; to fill up all the screen with 0's (firmware colour 0). However, you may use it in 
                            281 ;; combination with <cpct_px2byteM0>, <cpct_px2byteM1> or a manually created colour pattern.
                            282 ;;
                            283 ;; Known issues:
                            284 ;;   * This macro can only be used from assembler code. It is not accessible from 
                            285 ;; C scope. For C programs, please refer to <cpct_clearScreen>
                            286 ;;
                            287 ;; Details:
                            288 ;;   Fills up all the standard screen (range [0xC000-0xFFFF]) with *COL* byte, the colour 
                            289 ;; pattern given.
                            290 ;;
                            291 ;; Destroyed Registers:
                            292 ;;    BC, DE, HL
                            293 ;;
                            294 ;; Size of generated code:
                            295 ;;    13 bytes 
                            296 ;;
                            297 ;; Time Measures:
                            298 ;;    98309 microseconds (*4.924 VSYNCs* on a 50Hz display).
                            299 ;;    393236 CPU Cycles 
                            300 ;;
                            301 .macro cpctm_clearScreen_asm COL
                            302    ld    hl, #0xC000    ;; [3] HL Points to Start of Video Memory
                            303    ld    de, #0xC001    ;; [3] DE Points to the next byte
                            304    ld    bc, #0x4000    ;; [3] BC = 16384 bytes to be copied
                            305    ld   (hl), #COL      ;; [3] First Byte = given Colour
                            306    ldir                 ;; [98297] Perform the copy
                            307 .endm
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 43.
Hexadecimal [16-Bits]



                             24 .include "video/colours.h.s"
                              1 ;;-----------------------------LICENSE NOTICE------------------------------------
                              2 ;;  This file is part of CPCtelera: An Amstrad CPC Game Engine
                              3 ;;  Copyright (C) 2017 ronaldo / Fremos / Cheesetea / ByteRealms (@FranGallegoBR)
                              4 ;;
                              5 ;;  This program is free software: you can redistribute it and/or modify
                              6 ;;  it under the terms of the GNU Lesser General Public License as published by
                              7 ;;  the Free Software Foundation, either version 3 of the License, or
                              8 ;;  (at your option) any later version.
                              9 ;;
                             10 ;;  This program is distributed in the hope that it will be useful,
                             11 ;;  but WITHOUT ANY WARRANTY; without even the implied warranty of
                             12 ;;  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                             13 ;;  GNU Lesser General Public License for more details.
                             14 ;;
                             15 ;;  You should have received a copy of the GNU Lesser General Public License
                             16 ;;  along with this program.  If not, see <http://www.gnu.org/licenses/>.
                             17 ;;-------------------------------------------------------------------------------
                             18 
                             19 ;; File: Colours (asm)
                             20 ;;
                             21 ;;    Constants and utilities to manage the 27 colours from
                             22 ;; the CPC Palette comfortably in assembler.
                             23 ;;
                             24 
                             25 ;; Constant: Firmware colour values
                             26 ;;
                             27 ;;    Enumerates all 27 firmware colours for assembler programs
                             28 ;;
                             29 ;; Values:
                             30 ;; (start code)
                             31 ;;   [=================================================]
                             32 ;;   | Identifier        | Val| Identifier        | Val|
                             33 ;;   |-------------------------------------------------|
                             34 ;;   | FW_BLACK          |  0 | FW_BLUE           |  1 |
                             35 ;;   | FW_BRIGHT_BLUE    |  2 | FW_RED            |  3 |
                             36 ;;   | FW_MAGENTA        |  4 | FW_MAUVE          |  5 |
                             37 ;;   | FW_BRIGHT_RED     |  6 | FW_PURPLE         |  7 |
                             38 ;;   | FW_BRIGHT_MAGENTA |  8 | FW_GREEN          |  9 |
                             39 ;;   | FW_CYAN           | 10 | FW_SKY_BLUE       | 11 |
                             40 ;;   | FW_YELLOW         | 12 | FW_WHITE          | 13 |
                             41 ;;   | FW_PASTEL_BLUE    | 14 | FW_ORANGE         | 15 |
                             42 ;;   | FW_PINK           | 16 | FW_PASTEL_MAGENTA | 17 |
                             43 ;;   | FW_BRIGHT_GREEN   | 18 | FW_SEA_GREEN      | 19 |
                             44 ;;   | FW_BRIGHT_CYAN    | 20 | FW_LIME           | 21 |
                             45 ;;   | FW_PASTEL_GREEN   | 22 | FW_PASTEL_CYAN    | 23 |
                             46 ;;   | FW_BRIGHT_YELLOW  | 24 | FW_PASTEL_YELLOW  | 25 |
                             47 ;;   | FW_BRIGHT_WHITE   | 26 |                   |    |
                             48 ;;   [=================================================]
                             49 ;;(end code)
                             50 ;;
                     0000    51 FW_BLACK          =  0
                     0001    52 FW_BLUE           =  1
                     0002    53 FW_BRIGHT_BLUE    =  2
                     0003    54 FW_RED            =  3
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 44.
Hexadecimal [16-Bits]



                     0004    55 FW_MAGENTA        =  4
                     0005    56 FW_MAUVE          =  5
                     0006    57 FW_BRIGHT_RED     =  6
                     0007    58 FW_PURPLE         =  7
                     0008    59 FW_BRIGHT_MAGENTA =  8
                     0009    60 FW_GREEN          =  9
                     000A    61 FW_CYAN           = 10
                     000B    62 FW_SKY_BLUE       = 11
                     000C    63 FW_YELLOW         = 12
                     000D    64 FW_WHITE          = 13
                     000E    65 FW_PASTEL_BLUE    = 14
                     000F    66 FW_ORANGE         = 15
                     0010    67 FW_PINK           = 16
                     0011    68 FW_PASTEL_MAGENTA = 17
                     0012    69 FW_BRIGHT_GREEN   = 18
                     0013    70 FW_SEA_GREEN      = 19
                     0014    71 FW_BRIGHT_CYAN    = 20
                     0015    72 FW_LIME           = 21
                     0016    73 FW_PASTEL_GREEN   = 22
                     0017    74 FW_PASTEL_CYAN    = 23
                     0018    75 FW_BRIGHT_YELLOW  = 24
                     0019    76 FW_PASTEL_YELLOW  = 25
                     001A    77 FW_BRIGHT_WHITE   = 26
                             78 
                             79 ;; Constant: Hardware colour values
                             80 ;;
                             81 ;;    Enumerates all 27 hardware colours for assembler programs
                             82 ;;
                             83 ;; Values:
                             84 ;; (start code)
                             85 ;;   [=====================================================]
                             86 ;;   | Identifier        | Value| Identifier        | Value|
                             87 ;;   |-----------------------------------------------------|
                             88 ;;   | HW_BLACK          | 0x14 | HW_BLUE           | 0x04 |
                             89 ;;   | HW_BRIGHT_BLUE    | 0x15 | HW_RED            | 0x1C |
                             90 ;;   | HW_MAGENTA        | 0x18 | HW_MAUVE          | 0x1D |
                             91 ;;   | HW_BRIGHT_RED     | 0x0C | HW_PURPLE         | 0x05 |
                             92 ;;   | HW_BRIGHT_MAGENTA | 0x0D | HW_GREEN          | 0x16 |
                             93 ;;   | HW_CYAN           | 0x06 | HW_SKY_BLUE       | 0x17 |
                             94 ;;   | HW_YELLOW         | 0x1E | HW_WHITE          | 0x00 |
                             95 ;;   | HW_PASTEL_BLUE    | 0x1F | HW_ORANGE         | 0x0E |
                             96 ;;   | HW_PINK           | 0x07 | HW_PASTEL_MAGENTA | 0x0F |
                             97 ;;   | HW_BRIGHT_GREEN   | 0x12 | HW_SEA_GREEN      | 0x02 |
                             98 ;;   | HW_BRIGHT_CYAN    | 0x13 | HW_LIME           | 0x1A |
                             99 ;;   | HW_PASTEL_GREEN   | 0x19 | HW_PASTEL_CYAN    | 0x1B |
                            100 ;;   | HW_BRIGHT_YELLOW  | 0x0A | HW_PASTEL_YELLOW  | 0x03 |
                            101 ;;   | HW_BRIGHT_WHITE   | 0x0B |                   |      |
                            102 ;;   [=====================================================]
                            103 ;;(end code)
                            104 ;;
                     0014   105 HW_BLACK          = 0x14
                     0004   106 HW_BLUE           = 0x04
                     0015   107 HW_BRIGHT_BLUE    = 0x15
                     001C   108 HW_RED            = 0x1C
                     0018   109 HW_MAGENTA        = 0x18
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 45.
Hexadecimal [16-Bits]



                     001D   110 HW_MAUVE          = 0x1D
                     000C   111 HW_BRIGHT_RED     = 0x0C
                     0005   112 HW_PURPLE         = 0x05
                     000D   113 HW_BRIGHT_MAGENTA = 0x0D
                     0016   114 HW_GREEN          = 0x16
                     0006   115 HW_CYAN           = 0x06
                     0017   116 HW_SKY_BLUE       = 0x17
                     001E   117 HW_YELLOW         = 0x1E
                     0000   118 HW_WHITE          = 0x00
                     001F   119 HW_PASTEL_BLUE    = 0x1F
                     000E   120 HW_ORANGE         = 0x0E
                     0007   121 HW_PINK           = 0x07
                     000F   122 HW_PASTEL_MAGENTA = 0x0F
                     0012   123 HW_BRIGHT_GREEN   = 0x12
                     0002   124 HW_SEA_GREEN      = 0x02
                     0013   125 HW_BRIGHT_CYAN    = 0x13
                     001A   126 HW_LIME           = 0x1A
                     0019   127 HW_PASTEL_GREEN   = 0x19
                     001B   128 HW_PASTEL_CYAN    = 0x1B
                     000A   129 HW_BRIGHT_YELLOW  = 0x0A
                     0003   130 HW_PASTEL_YELLOW  = 0x03
                     000B   131 HW_BRIGHT_WHITE   = 0x0B
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 46.
Hexadecimal [16-Bits]



                             25 
                             26 ;;
                             27 ;; Constant values
                             28 ;;
                     7F00    29 GA_port        = 0x7F00  ;; 16-bit Port of the Gate Array (for the use with BC register)
                     007F    30 GA_port_byte   = 0x7F    ;; 8-bit Port of the Gate Array
                     0000    31 PAL_PENR       = 0x00    ;; Command to select a PEN register in the PAL chip
                     0040    32 PAL_INKR       = 0x40    ;; Command to set the INK of a previously selected PEN register in the PAL chip
                     00F5    33 PPI_PORT_B     = 0xF5    ;; Port B of the PPI, used to read Vsync/Jumpers/PrinterBusy/CasIn/Exp information
                     00BC    34 CRTC_SELECTREG = 0xBC    ;; CRTC Port and command "Select Register"
                     00BD    35 CRTC_SETVAL    = 0xBD    ;; CRTC Port and command "Set Value"
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 47.
Hexadecimal [16-Bits]



                             23 .include "sprites/sprites.h.s"
                              1 ;;-----------------------------LICENSE NOTICE------------------------------------
                              2 ;;  This file is part of CPCtelera: An Amstrad CPC Game Engine
                              3 ;;  Copyright (C) 2018 ronaldo / Fremos / Cheesetea / ByteRealms (@FranGallegoBR)
                              4 ;;
                              5 ;;  This program is free software: you can redistribute it and/or modify
                              6 ;;  it under the terms of the GNU Lesser General Public License as published by
                              7 ;;  the Free Software Foundation, either version 3 of the License, or
                              8 ;;  (at your option) any later version.
                              9 ;;
                             10 ;;  This program is distributed in the hope that it will be useful,
                             11 ;;  but WITHOUT ANY WARRANTY; without even the implied warranty of
                             12 ;;  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                             13 ;;  GNU Lesser General Public License for more details.
                             14 ;;
                             15 ;;  You should have received a copy of the GNU Lesser General Public License
                             16 ;;  along with this program.  If not, see <http://www.gnu.org/licenses/>.
                             17 ;;-------------------------------------------------------------------------------
                             18 
                             19 ;;#####################################################################
                             20 ;;### MODULE: Sprites
                             21 ;;#####################################################################
                             22 ;;### Functions, macros and definitions used for managing sprites
                             23 ;;### in assembler code
                             24 ;;#####################################################################
                             25 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 48.
Hexadecimal [16-Bits]



                             26 .include "sprites/flipping/flipping_macros.h.s"
                              1 ;;-----------------------------LICENSE NOTICE------------------------------------
                              2 ;;  This file is part of CPCtelera: An Amstrad CPC Game Engine
                              3 ;;  Copyright (C) 2018 ronaldo / Fremos / Cheesetea / ByteRealms (@FranGallegoBR)
                              4 ;;
                              5 ;;  This program is free software: you can redistribute it and/or modify
                              6 ;;  it under the terms of the GNU Lesser General Public License as published by
                              7 ;;  the Free Software Foundation, either version 3 of the License, or
                              8 ;;  (at your option) any later version.
                              9 ;;
                             10 ;;  This program is distributed in the hope that it will be useful,
                             11 ;;  but WITHOUT ANY WARRANTY; without even the implied warranty of
                             12 ;;  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                             13 ;;  GNU Lesser General Public License for more details.
                             14 ;;
                             15 ;;  You should have received a copy of the GNU Lesser General Public License
                             16 ;;  along with this program.  If not, see <http://www.gnu.org/licenses/>.
                             17 ;;-------------------------------------------------------------------------------
                             18 
                             19 ;;#####################################################################
                             20 ;;### MODULE: Sprites
                             21 ;;### SUBMODULE: flipping.macros
                             22 ;;#####################################################################
                             23 ;;### Macros used to speed up calculations required for to assist
                             24 ;;### flipping functions. Assembler version.
                             25 ;;#####################################################################
                             26 
                             27 ;;
                             28 ;; Macro: cpctm_spbloff
                             29 ;;
                             30 ;;    Macro that calculates the offset to add to a sprite pointer to point 
                             31 ;; to its bottom left pixel.
                             32 ;;
                             33 ;; ASM Definition:
                             34 ;;    .macro <cpctm_ld_sblo> *REG*, *X*, *Y*
                             35 ;;
                             36 ;; Acronym stands for:
                             37 ;;    ld_sblo = Load Sprite Bottom Left Offset
                             38 ;;
                             39 ;; Parameters:
                             40 ;;    (1-2B) REG - Register that will load the resulting offset (8 or 16 bits)
                             41 ;;    (1B) X     - Width of the sprite in *bytes*
                             42 ;;    (1B) Y     - Height of the sprite in pixels
                             43 ;;
                             44 ;; Parameter Restrictions:
                             45 ;;    *REG* - Must be a valid 8/16 bits register that can be immediately loaded
                             46 ;; using ld REG, #immediate.
                             47 ;;    *X*   - Must be an immediate value representing the width of the sprite 
                             48 ;; in *bytes* (Beware! Not in pixels). For sprites having interlaced mask, you 
                             49 ;; may input 2 times the width of the sprite for appropriate results.
                             50 ;;    *Y*   - Must be an immediate value representing the height of the sprite 
                             51 ;; in pixels.
                             52 ;;
                             53 ;; Returns:
                             54 ;;    REG = X * (Y - 1) ;; Register loaded with the offset
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 49.
Hexadecimal [16-Bits]



                             55 ;;
                             56 ;; Details:
                             57 ;;    This macro calculates the offset of the initial byte of the last row 
                             58 ;; of a given sprite (i.e. its bottom-left byte), with respect to its first
                             59 ;; byte (top-left corner). This value can easily be added to any sprite 
                             60 ;; pointer to get a pointer to the bottom-left byte. This pointer is required
                             61 ;; byte many flipping functions (like <cpct_vflipSpriteM0>). Values for width
                             62 ;; and height of the sprite must be constant immediate values. Otherwise, this
                             63 ;; macro will generate incorrect code that will fail to compile. 
                             64 ;;    The macro calculates *X* * (*Y*-1) at compile-time and loads it into
                             65 ;; the given register. Please, take into account that the macro does no check
                             66 ;; about the size of the resulting values. If multiplication results in a value
                             67 ;; greater than 255, you will need to load it into a 16-bit register. You must
                             68 ;; take care of the expected size of the offset value.
                             69 ;;
                             70 ;; Known issues:
                             71 ;;    * This is a assembler macro. It cannot be called or used from C code.
                             72 ;;
                             73 .macro cpctm_ld_sblo REG, X, Y
                             74    ld    REG, #X * (Y-1)
                             75 .endm
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 50.
Hexadecimal [16-Bits]



                             11 .include "struct.h.s"
                              1 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                              2 ;; DEFINICION DE LAS MACROS PARA LA CREACION DE ENTIDADES ;;
                              3 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                              4 
                              5 ;; Entidad drawable
                              6 .macro DefineDrawableEnt _name, _x, _y, _w, _h
                              7 _name:
                              8    .db   _x, _y      ;; Posicion    (x,y)
                              9    .db   _w, _h      ;; Dimensiones (w,h)
                             10 .endm
                             11 
                             12 ;; Entidad movable
                             13 .macro DefineMovableEnt _name, _vx, _vy
                             14 _name:
                             15    .db   _vx, _vy    ;; Variables de la velocidad
                             16 .endm
                             17 
                             18 ;; Entidad por defecto
                             19 .macro DefineEntityDefault _name, _suf
                             20    DefineEntity _name'_suf, 0xAA, 0, 0, 0, 0, 0, 0, 0xFFFF           ;;'
                             21 .endm
                             22 
                             23 ;; Definir N entidades
                             24 .macro DefineNEntities _name, _n
                             25    _c = 0
                             26    .rept _n
                             27       DefineEntityDefault _name, \_c
                             28       _c = _c + 1
                             29    .endm
                             30 .endm
                             31 
                             32 ;; Entidad heroe/enemigo
                             33 .macro DefineEntity  _name, _x, _y, _w, _h, _vx, _vy, _col, _upd
                             34 _name:
                             35    DefineDrawableEnt _name'_dw, _x, _y, _w, _h                       ;;'
                             36    DefineMovableEnt  _name'_mv, _vx, _vy                             ;;'
                             37 ;; Si no tiene sprite
                             38    .db   _col        ;; Color
                             39 ;; Si tiene sprite
                             40 ;;.dw   _spr
                             41    .dw   _upd        ;; Puntero a la funcion de update
                             42 
                             43 ;; Aqui falta saber el tamanyo de la entidad
                             44 e_size = . - (_name)
                             45 .endm
                             46 
                             47 ;;;;;;;;;;;;;;;;;;;
                             48 ;; Constantes de las entidades hero/enemy
                             49 ;;;;;;;;;;;;;;;;;;;
                     0001    50    e_x = 0      e_y = 1
                     0003    51    e_w = 2      e_h = 3
                     0005    52   e_vx = 4     e_vy = 5
                     0006    53  e_col = 6
                     0008    54 e_up_l = 7   e_up_h = 8
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 51.
Hexadecimal [16-Bits]



                             55 
                             56 ;;-----------------------------------------------------------------------------------------;;
                             57 ;; Entidad bullet
                             58 .macro DefineBullet  _name, _x, _y, _w, _h, _vx, _vy, _col, _alive, _upd
                             59 _name:
                             60    DefineDrawableEnt _name'_dw, _x, _y, _w, _h                       ;;'
                             61    DefineMovableEnt  _name'_mv, _vx, _vy                             ;;'
                             62    .db   _col        ;; Color / Sprite (cuando haya)
                             63    .db   _alive      ;; _alive>0? Se actualiza/dibuja
                             64    .dw   _upd        ;; Funcion de update
                             65 
                             66 ;; Saber tamanyo de entidad bala
                             67 .endm
                             68 
                             69 ;; Entidad por defecto de bullet
                             70 .macro DefineBulletDefault _name, _suf
                             71    DefineBullet _name'_suf, 0xAA, 0, 0, 0, 0, 0, 0, 0, 0xFFFF        ;;'
                             72 .endm
                             73 
                             74 ;; Bucle de crear entidades bullet
                             75 .macro DefineNBullets _name, _n
                             76    _c = 0
                             77    .rept _n
                             78       DefineBulletDefault _name, \_c
                             79       _c = _c + 1
                             80    .endm
                             81 .endm
                             82 
                             83 ;;;;;;;;;;;;;;;;;;;
                             84 ;; Constantes de las entidades bullet
                             85 ;;;;;;;;;;;;;;;;;;;
                     0001    86     b_x = 0      b_y = 1
                     0003    87     b_w = 2      b_h = 3
                     0005    88    b_vx = 4     b_vy = 5
                     0007    89   b_col = 6  b_alive = 7
                     0009    90  b_up_l = 8   b_up_h = 9
                             91 
                             92 
                             93 
                             94  ;;-----------------------------------------------------------------------------------------;;
                             95  ;; Entidad enemigo por defecto
                             96  .macro DefineEnemyDefault _name, _suf
                             97     DefineEnemy _name'_suf, #0xAA, #0, #0, #0, #0, #0, #0, #0xFFFF, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #1           ;;'
                             98  .endm
                             99 
                            100  ;; Definir N entidades enemigo
                            101  .macro DefineNEnemies _name, _n
                            102     _c = 0
                            103     .rept _n
                            104        DefineEnemyDefault _name, \_c
                            105        _c = _c + 1
                            106     .endm
                            107  .endm
                            108 
                            109  ;; Entidad enemigo
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 52.
Hexadecimal [16-Bits]



                            110  .macro DefineEnemy  _name, _x, _y, _w, _h, _vx, _vy, _col, _upd, _goal_flag, _goal_x, _goal_y, save_dX, save_dY, IncYr, IncXr, av, avR, avI, flag_vel
                            111  _name:
                            112     DefineDrawableEnt _name'_dw, _x, _y, _w, _h                       ;;'
                            113     DefineMovableEnt  _name'_mv, _vx, _vy                             ;;'
                            114  ;; Si no tiene sprite
                            115     .db  _col        ;; Color
                            116  ;; Si tiene sprite
                            117  ;;.dw   _spr
                            118     .dw  _upd        ;; Puntero a la funcion de update
                            119     .db  _goal_flag  ;; 0 -> No se ha
                            120     .db  _goal_x     ;; X de la posicion final
                            121     .db  _goal_y     ;; Y de la posicion final
                            122 
                            123     ;;BRESENHAM
                            124     .dw  save_dX     ;; Distancia en X del objetivo
                            125     .dw  save_dY     ;; Distancia en Y del objetivo
                            126     .db  IncYr       ;; Incremento recto en Y
                            127     .db  IncXr       ;; Incremento recto en X
                            128     .dw  av          ;; Avance
                            129     .dw  avR         ;; Avance recto
                            130     .dw  avI         ;; Avance inclinado
                            131     .db  flag_vel    ;; 1 = Esta utilizando IncYi/IncXi |------------| 0 = Esta utilizando IncYr/IncXr
                            132  ;; Aqui falta saber el tamanyo de la entidad
                            133  en_size = . - (_name)
                            134  .endm
                            135 
                            136  ;;;;;;;;;;;;;;;;;;;
                            137  ;; Constantes de las entidades hero/enemy
                            138  ;;;;;;;;;;;;;;;;;;;
                            139 
                     0001   140       en_x = 0         en_y = 1
                     0003   141       en_w = 2         en_h = 3
                     0005   142      en_vx = 4        en_vy = 5
                     0006   143     en_col = 6
                     0008   144    en_up_l = 7      en_up_h = 8
                     0009   145  en_g_flag = 9
                            146  ;;------------------------------BRESENHAM
                     000B   147     en_g_x = 10      en_g_y = 11
                     000D   148    en_dX_l = 12     en_dX_h = 13
                     000F   149    en_dY_l = 14     en_dY_h = 15
                     0011   150   en_incYr = 16    en_incXr = 17
                     0013   151    en_av_l = 18     en_av_h = 19
                     0015   152   en_avR_l = 20    en_avR_h = 21
                     0017   153   en_avI_l = 22    en_avI_h = 23
                     0018   154 en_flagVel = 24
                            155 
                            156 
                            157 
                            158 
                            159 
                            160 
                            161 
                            162 
                            163 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 53.
Hexadecimal [16-Bits]



                             12 ;;======================================================================
                             13 ;;======================================================================
                             14 ;; DATOS PRIVADOS
                             15 ;;======================================================================
                             16 ;;======================================================================
                     0019    17 enemy_size = en_size           ;; Tamanyo parametrizado
                     0001    18 k_max_enemies = 1
                             19 
   3A3D                      20 DefineEnemy enemy_copy, 39, 50, #1, #4, #0, #0, #0x0F, #enemy_randomGoal, #0, #0, #0, #0x0000, #0x0000, #0, #0, #0x0000, #0x0000, #0x0000, #1
   3A3D                       1  enemy_copy:
   0000                       2     DefineDrawableEnt enemy_copy_dw, 39, 50, #1, #4                       ;;'
   0000                       1 enemy_copy_dw:
   3A3D 27 32                 2    .db   39, 50      ;; Posicion    (x,y)
   3A3F 01 04                 3    .db   #1, #4      ;; Dimensiones (w,h)
   3A41                       3     DefineMovableEnt  enemy_copy_mv, #0, #0                             ;;'
   0004                       1 enemy_copy_mv:
   3A41 00 00                 2    .db   #0, #0    ;; Variables de la velocidad
                              4  ;; Si no tiene sprite
   3A43 0F                    5     .db  #0x0F        ;; Color
                              6  ;; Si tiene sprite
                              7  ;;.dw   _spr
   3A44 E4 3A                 8     .dw  #enemy_randomGoal        ;; Puntero a la funcion de update
   3A46 00                    9     .db  #0  ;; 0 -> No se ha
   3A47 00                   10     .db  #0     ;; X de la posicion final
   3A48 00                   11     .db  #0     ;; Y de la posicion final
                             12 
                             13     ;;BRESENHAM
   3A49 00 00                14     .dw  #0x0000     ;; Distancia en X del objetivo
   3A4B 00 00                15     .dw  #0x0000     ;; Distancia en Y del objetivo
   3A4D 00                   16     .db  #0       ;; Incremento recto en Y
   3A4E 00                   17     .db  #0       ;; Incremento recto en X
   3A4F 00 00                18     .dw  #0x0000          ;; Avance
   3A51 00 00                19     .dw  #0x0000         ;; Avance recto
   3A53 00 00                20     .dw  #0x0000         ;; Avance inclinado
   3A55 01                   21     .db  #1    ;; 1 = Esta utilizando IncYi/IncXi |------------| 0 = Esta utilizando IncYr/IncXr
                             22  ;; Aqui falta saber el tamanyo de la entidad
                     0019    23  en_size = . - (enemy_copy)
                             21 
                             22 ;; ANCHO:   0 - 79
                             23 ;; ALTO:    0 - ~100 -> COMO ESTAMOS EN MODO 0, SE CONSIGUE LA MITAD DE RESOLUCION EN Y
                     001D    24 x_range = 29
                     001D    25 y_range = 29
                     0006    26 var_r_max   = 6
                     0000    27 var_r_min   = 0
   3A56                      28 vector_init:                  ;; Etiqueta de inicio del vector
                             29 ;DefineNEnemies enemy, k_max_enemies
   3A56                      30 DefineEnemy enemy1, #5, #5, #2, #8, #0, #0, #0x0F, #enemy_randomGoal, #0, #0, #0, #0x0000, #0x0000, #0, #0, #0x0000, #0x0000, #0x0000, #1
   3A56                       1  enemy1:
   0019                       2     DefineDrawableEnt enemy1_dw, #5, #5, #2, #8                       ;;'
   0019                       1 enemy1_dw:
   3A56 05 05                 2    .db   #5, #5      ;; Posicion    (x,y)
   3A58 02 08                 3    .db   #2, #8      ;; Dimensiones (w,h)
   3A5A                       3     DefineMovableEnt  enemy1_mv, #0, #0                             ;;'
   001D                       1 enemy1_mv:
   3A5A 00 00                 2    .db   #0, #0    ;; Variables de la velocidad
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 54.
Hexadecimal [16-Bits]



                              4  ;; Si no tiene sprite
   3A5C 0F                    5     .db  #0x0F        ;; Color
                              6  ;; Si tiene sprite
                              7  ;;.dw   _spr
   3A5D E4 3A                 8     .dw  #enemy_randomGoal        ;; Puntero a la funcion de update
   3A5F 00                    9     .db  #0  ;; 0 -> No se ha
   3A60 00                   10     .db  #0     ;; X de la posicion final
   3A61 00                   11     .db  #0     ;; Y de la posicion final
                             12 
                             13     ;;BRESENHAM
   3A62 00 00                14     .dw  #0x0000     ;; Distancia en X del objetivo
   3A64 00 00                15     .dw  #0x0000     ;; Distancia en Y del objetivo
   3A66 00                   16     .db  #0       ;; Incremento recto en Y
   3A67 00                   17     .db  #0       ;; Incremento recto en X
   3A68 00 00                18     .dw  #0x0000          ;; Avance
   3A6A 00 00                19     .dw  #0x0000         ;; Avance recto
   3A6C 00 00                20     .dw  #0x0000         ;; Avance inclinado
   3A6E 01                   21     .db  #1    ;; 1 = Esta utilizando IncYi/IncXi |------------| 0 = Esta utilizando IncYr/IncXr
                             22  ;; Aqui falta saber el tamanyo de la entidad
                     0019    23  en_size = . - (enemy1)
   3A6F                      31 DefineEnemy enemy2, #28, #28, #2, #8, #0, #0, #0x0F, #enemy_randomGoal, #0, #0, #0, #0x0000, #0x0000, #0, #0, #0x0000, #0x0000, #0x0000, #1
   3A6F                       1  enemy2:
   0032                       2     DefineDrawableEnt enemy2_dw, #28, #28, #2, #8                       ;;'
   0032                       1 enemy2_dw:
   3A6F 1C 1C                 2    .db   #28, #28      ;; Posicion    (x,y)
   3A71 02 08                 3    .db   #2, #8      ;; Dimensiones (w,h)
   3A73                       3     DefineMovableEnt  enemy2_mv, #0, #0                             ;;'
   0036                       1 enemy2_mv:
   3A73 00 00                 2    .db   #0, #0    ;; Variables de la velocidad
                              4  ;; Si no tiene sprite
   3A75 0F                    5     .db  #0x0F        ;; Color
                              6  ;; Si tiene sprite
                              7  ;;.dw   _spr
   3A76 E4 3A                 8     .dw  #enemy_randomGoal        ;; Puntero a la funcion de update
   3A78 00                    9     .db  #0  ;; 0 -> No se ha
   3A79 00                   10     .db  #0     ;; X de la posicion final
   3A7A 00                   11     .db  #0     ;; Y de la posicion final
                             12 
                             13     ;;BRESENHAM
   3A7B 00 00                14     .dw  #0x0000     ;; Distancia en X del objetivo
   3A7D 00 00                15     .dw  #0x0000     ;; Distancia en Y del objetivo
   3A7F 00                   16     .db  #0       ;; Incremento recto en Y
   3A80 00                   17     .db  #0       ;; Incremento recto en X
   3A81 00 00                18     .dw  #0x0000          ;; Avance
   3A83 00 00                19     .dw  #0x0000         ;; Avance recto
   3A85 00 00                20     .dw  #0x0000         ;; Avance inclinado
   3A87 01                   21     .db  #1    ;; 1 = Esta utilizando IncYi/IncXi |------------| 0 = Esta utilizando IncYr/IncXr
                             22  ;; Aqui falta saber el tamanyo de la entidad
                     0019    23  en_size = . - (enemy2)
                             32 ; DefineEnemy enemy3, #1, #28, #2, #8, #0, #0, #0x0F, #enemy_randomGoal, #0, #0, #0, #0x0000, #0x0000, #0, #0, #0x0000, #0x0000, #0x0000, #1
                             33 ; DefineEnemy enemy4, #28, #1, #2, #8, #0, #0, #0x0F, #enemy_randomGoal, #0, #0, #0, #0x0000, #0x0000, #0, #0, #0x0000, #0x0000, #0x0000, #1
   3A88 FF                   34 vector_end:    .db #0xFF      ;; Indico 0xFF como fin del vector
                             35 
   3A89 14                   36 flag_move:     .db #20        ;; Cambia en cada frame [0,1] -> 1 = Se mueve
   3A8A 40 00                37 ptr_map:       .dw #decompress_buffer   ;; Puntero al array de id de tiles que forman el mapa
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 55.
Hexadecimal [16-Bits]



                             38 
                     0005    39 k_update_count = 5
   3A8C 05                   40 update_count:  .db #k_update_count        ;; Limita el update a cada k_update_count frames
                             41 
                             42 ;;======================================================================
                             43 ;;======================================================================
                             44 ;; FUNCIONES PUBLICAS
                             45 ;;======================================================================
                             46 ;;======================================================================
                             47 ;;;;;;;;;;;;;;;;;;;;;;;;;;;
                             48 ;; COPIA LOS ENEMIGOS DEL BUCLE CON UNA ENTIDAD "MODELO"
                             49 ;; _______________________
                             50 ;; DESTRUYE:   HL
                             51 ;;;;;;;;;;;;;;;;;;;;;;;;;;;
   3A8D                      52 enemy_create::
   3A8D 21 CB 3A      [10]   53    ld hl, #enemy_init
   3A90 C3 B4 3A      [10]   54    jp enemy_search
                             55 
                             56 ;;;;;;;;;;;;;;;;;;;;;;;;;;;
                             57 ;; ASIGNA LA FUNCION DE DIBUJADO EN HL Y RECORRE EL BUCLE
                             58 ;; _______________________
                             59 ;; DESTRUYE:   HL
                             60 ;;;;;;;;;;;;;;;;;;;;;;;;;;;
   3A93                      61 enemy_draw_ALL::
   3A93 21 99 3A      [10]   62    ld hl, #enemy_call_draw
   3A96 C3 B4 3A      [10]   63    jp enemy_search
                             64 
   3A99                      65 enemy_call_draw:
   3A99 3E AA         [ 7]   66    ld a, #0xAA
   3A9B C3 32 39      [10]   67    jp dw_draw
                             68 
                             69 ;;;;;;;;;;;;;;;;;;;;;;;;;;;
                             70 ;; ASIGNA LA FUNCION DE UPDATE EN HL Y RECORRE EL BUCLE
                             71 ;; _______________________
                             72 ;; DESTRUYE:   HL
                             73 ;;;;;;;;;;;;;;;;;;;;;;;;;;;
   3A9E                      74 enemy_update_ALL::
   3A9E 3A 8C 3A      [13]   75    ld    a, (update_count)                ;; ======================== ;;
   3AA1 3D            [ 4]   76    dec   a                                ;;     POR SI AL FINAL      ;;
   3AA2 32 8C 3A      [13]   77    ld    (update_count), a                ;;    SE QUIERE LIMITAR     ;;
   3AA5 FE 00         [ 7]   78    cp    #0                               ;;  EL UPDATE DEL ENEMIGO   ;;
   3AA7 C0            [11]   79    ret   nz                               ;; ======================== ;;
                             80 
                             81 
   3AA8 21 D7 3A      [10]   82    ld hl, #enemy_update
   3AAB CD B4 3A      [17]   83    call enemy_search
                             84 
   3AAE 3E 05         [ 7]   85    ld    a, #k_update_count               ;; REINICIAR EL CONTADOR
   3AB0 32 8C 3A      [13]   86    ld    (update_count), a                ;;       DEL UPDATE
   3AB3 C9            [10]   87    ret
                             88 
                             89 ;;======================================================================
                             90 ;;======================================================================
                             91 ;; FUNCIONES PRIVADAS
                             92 ;;======================================================================
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 56.
Hexadecimal [16-Bits]



                             93 ;;======================================================================
                             94 ;;;;;;;;;;;;;;;;;;;;;;;;;;;
                             95 ;; RECORRE EL BUCLE DE ENEMIGOS
                             96 ;; _______________________
                             97 ;; ENTRADA:    HL -> Puntero a funcion custom
                             98 ;; DESTRUYE:   A, DE, IX
                             99 ;;;;;;;;;;;;;;;;;;;;;;;;;;;
   3AB4                     100 enemy_search:
   3AB4 DD 21 56 3A   [14]  101    ld    ix,   #vector_init      ;; IX apunta al inicio de vector de enemigos (a la primera entidad)
   3AB8 22 C2 3A      [16]  102    ld    (f_custom), hl          ;; Cargo en el call de abajo la funcion a la que quiero llamar en cada momento determinado
   3ABB                     103    search_loop:
   3ABB DD 7E 00      [19]  104       ld     a,   0(ix)                ;; Compruebo que no he llegado al final del vector
   3ABE FE FF         [ 7]  105       cp    #0xFF                      ;; A - 0xFF
   3AC0 C8            [11]  106       ret    z                         ;; if(A==0xFF) -> Sale del vector
                            107 
                     0085   108       f_custom = . +1                  ;; . apunta a 'call' y con el '+1' apunta a '(0x0000)' -> (siempre va a cambiar)
   3AC1 CD 00 00      [17]  109       call (0x0000)                    ;; LLAMADA A FUNCION PERSONALIZABLE
   3AC4 11 19 00      [10]  110       ld    de,   #enemy_size          ;; Cargo en DE el tamanyo de la entidad bullet para despues sumarlo a HL
   3AC7 DD 19         [15]  111       add   ix,   de                   ;; IX + DE = Apunta a la siguiente entidad bullet
   3AC9 18 F0         [12]  112    jr search_loop
                            113 
                            114 ;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            115 ;; COPIA LA ENTIDAD EN IX CON EL ENEMIGO POR DEFECTO
                            116 ;; _______________________
                            117 ;; ENTRADA:    IX -> Puntero a entidad enemigo del bucle
                            118 ;;;;;;;;;;;;;;;;;;;;;;;;;;;
   3ACB                     119 enemy_init:
   3ACB DD E5         [15]  120    push  ix                ;; El valor de IX va a la pila
   3ACD D1            [10]  121    pop   de                ;; DE ahora tiene el valor de IX
   3ACE 21 3D 3A      [10]  122    ld    hl, #enemy_copy   ;; HL apunta al destino de la copia
   3AD1 01 19 00      [10]  123    ld    bc, #enemy_size   ;; BC tiene el tamanyo del enemigo
   3AD4 ED B0         [21]  124    ldir                    ;; ELEDIR
   3AD6 C9            [10]  125    ret
                            126 
                            127 ;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            128 ;; LLAMA A LA FUNCION PROPIA DE UPDATE DE CADA ENEMIGO
                            129 ;; _______________________
                            130 ;; ENTRADA:    IX -> Puntero a entidad enemigo del bucle
                            131 ;;;;;;;;;;;;;;;;;;;;;;;;;;;
   3AD7                     132 enemy_update:
   3AD7 CD 36 3D      [17]  133    call enemy_heroInRadius
   3ADA CD 9F 3D      [17]  134    call kill
   3ADD DD 6E 07      [19]  135    ld    l, en_up_l(ix)     ;; Cargo el byte bajo en L
   3AE0 DD 66 08      [19]  136    ld    h, en_up_h(ix)     ;; Cargo el byte alto en H
   3AE3 E9            [ 4]  137    jp    (hl)              ;; Llamo a la funcion
                            138 
                            139 ;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            140 ;; BUSCA UN PUNTO ALEATORIO PARA IR HACIA ALLI
                            141 ;; _______________________
                            142 ;; ENTRADA:    IX -> Puntero a entidad enemigo del bucle
                            143 ;; DESTRUYE:   Se destruyen TODOS los registros, incluso BC',DE' y HL'
                            144 ;;;;;;;;;;;;;;;;;;;;;;;;;;;
   3AE4                     145 enemy_randomGoal:
   3AE4 3A 89 3A      [13]  146    ld    a, (flag_move)          ;; Cargo en A un contador para que no busque todo el rato
   3AE7 3D            [ 4]  147    dec   a                       ;; A--
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 57.
Hexadecimal [16-Bits]



   3AE8 32 89 3A      [13]  148    ld    (flag_move), a          ;; Lo actualizo
   3AEB C0            [11]  149    ret   nz                      ;; Si no ha llegado a 0 hace ret
                            150 
   3AEC 3E 01         [ 7]  151    ld    a, #1                  ;; Inicio de nuevo el contador para despues
   3AEE 32 89 3A      [13]  152    ld (flag_move), a
                            153 
                            154    ;;RESET DE LOS VALORES
   3AF1 DD 36 11 00   [19]  155    ld en_incXr(ix), #0      ;; IncXr
   3AF5 DD 36 10 00   [19]  156    ld en_incYr(ix), #0      ;; IncYr
   3AF9 DD 36 04 00   [19]  157    ld en_vx(ix),    #0      ;; vx = IncXi
   3AFD DD 36 05 00   [19]  158    ld en_vy(ix),    #0      ;; vy = IncYi
                            159 
                            160    ;; PARTE 1 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            161    ;; X
                            162 
                            163 
                            164    ;; Miro si E = 0xEE
                            165    ;; En ese caso, no se consigue ningun random en X nuevo
   3B01 7B            [ 4]  166    ld    a,    e
   3B02 FE EE         [ 7]  167    cp    #0xEE
                            168 
                            169    ;; Cargo en A la posicion en X que he conseguido para después
                            170    ;; en el caso que no vaya a elegir una random
                            171    ;; En otro caso, A sera sobreescrita
                            172    ;; A = X
   3B04 79            [ 4]  173    ld    a,    c
                            174 
                            175    ;; Guardo los registros HL, BC y DE
                            176    ;; Los que importan son BC y E
   3B05 D9            [ 4]  177    exx
   3B06 28 03         [12]  178    jr z, dont_do_random_x
   3B08 CD 9C 3C      [17]  179       call enemy_getRandom_X     ;; A = X_fin
   3B0B                     180    dont_do_random_x:
                            181 
                            182    ;; Saco vector VX del enemigo
   3B0B DD 96 00      [19]  183    sub   en_x(ix)             ;; Resto la posicion actual del enemigo
   3B0E DD 77 0C      [19]  184    ld    en_dX_l(ix), a       ;; GUARDO el valor de dX
   3B11 38 06         [12]  185    jr c, vx_neg               ;; Si C==1, la distancia es negativa
   3B13 DD 36 04 01   [19]  186       ld    en_vx(ix), #1        ;; VX =  1
   3B17 18 0E         [12]  187       jr continua_y
   3B19                     188    vx_neg:
   3B19 DD 36 04 FF   [19]  189       ld    en_vx(ix), #-1       ;; VX = -1
   3B1D ED 44         [ 8]  190       neg
   3B1F DD 77 0C      [19]  191       ld en_dX_l(ix) , a         ;; Lo guardo de nuevo
   3B22 3E 00         [ 7]  192       ld    a,    #0x00          ;; | A = 0xFF
   3B24 DD 77 0D      [19]  193       ld en_dX_h(ix), a          ;; Ya que es negativo -> FF**
   3B27                     194    continua_y:
                            195 
                            196    ;; Recupero BC y E
   3B27 D9            [ 4]  197    exx
                            198 
                            199    ;; Miro si E = 0xEE
                            200    ;; En ese caso, no se consigue ningun random en X nuevo
   3B28 7B            [ 4]  201    ld    a,    e
   3B29 FE EE         [ 7]  202    cp    #0xEE
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 58.
Hexadecimal [16-Bits]



                            203 
                            204    ;; Cargo en A la posicion en X que he conseguido para después
                            205    ;; en el caso que no vaya a elegir una random
                            206    ;; En otro caso, A sera sobreescrita
                            207    ;; A = Y
   3B2B 78            [ 4]  208    ld    a,    b
   3B2C 28 03         [12]  209    jr z, dont_do_random_y
   3B2E CD B9 3C      [17]  210       call enemy_getRandom_Y     ;; A = Y_fin
   3B31                     211    dont_do_random_y:
                            212 
                            213    ;; Saco vector VY del enemigo
   3B31 DD 96 01      [19]  214    sub   a, en_y(ix)             ;; Posicion Y del enemigo
   3B34 DD 77 0E      [19]  215    ld    en_dY_l(ix), a          ;; Guardo el valor para despues
                            216    ;cp    #200                   ;; |
   3B37 38 06         [12]  217    jr c, vy_neg                  ;; Si C==0 la distancia es negativa -> COMPROBAR EN EJECUCION
   3B39 DD 36 05 01   [19]  218       ld    en_vy(ix), #1        ;; VY =  1
   3B3D 18 0E         [12]  219       jr continua_fin
   3B3F                     220    vy_neg:
   3B3F DD 36 05 FF   [19]  221       ld    en_vy(ix), #-1       ;; VY = -1
   3B43 ED 44         [ 8]  222       neg
   3B45 DD 77 0E      [19]  223       ld en_dY_l(ix), a          ;; Lo guardo de nuevo
   3B48 3E 00         [ 7]  224       ld    a,    #0x00          ;; | A = 0xFF
   3B4A DD 77 0F      [19]  225       ld en_dY_h(ix), a          ;; Ya que es negativo -> FF**
   3B4D                     226    continua_fin:
                            227 
                            228    ;; PARTE 2 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            229 
                            230    ;; Primero miro si los numeros estan en un valor absoluto
   3B4D DD 6E 0E      [19]  231    ld    l, en_dY_l(ix)       ;; Cargo en HL el valor de dY
   3B50 DD 66 0F      [19]  232    ld    h, en_dY_h(ix)       ;; Cargo en HL el valor de dY
   3B53 CD D6 3C      [17]  233    call enemy_get_positive
   3B56 EB            [ 4]  234    ex    de,   hl             ;; -- DE = dY
   3B57 DD 6E 0C      [19]  235    ld    l, en_dX_l(ix)        ;; Cargo en HL el valor de dX
   3B5A DD 66 0D      [19]  236    ld    h, en_dX_h(ix)        ;; Cargo en HL el valor de dX
   3B5D CD D6 3C      [17]  237    call enemy_get_positive    ;; -- HL = dX
                            238 
   3B60 30 01         [12]  239    jr    nc, no_carry         ;; Si C = 0, no hago nada
   3B62 3F            [ 4]  240       ccf                     ;; Si entra aqui, C = 1, entonces invierto -> C = 0
   3B63                     241    no_carry:
   3B63 ED 52         [15]  242    sbc   hl,   de             ;; HL - DE = dX - dY ---> AL UTILIZAR TAMBIEN EL CARRY FLAG, LO PONGO A 0 ANTES DE HACER NADA
   3B65 38 0D         [12]  243    jr c, dy_es_mayor          ;; dX - dY = 0013 - 0000 = 13 -> dX ES MAYOR, C=0
                            244       ;;if dX>=dY
   3B67 3E 00         [ 7]  245       ld    a,    #0          ;; A = 0
   3B69 DD 77 10      [19]  246       ld en_incYr(ix), a      ;; --> IncYr = 0
   3B6C DD 7E 04      [19]  247       ld    a, en_vx(ix)      ;; A = IncXi = VX
   3B6F DD 77 11      [19]  248       ld en_incXr(ix), a      ;; --> IncXr = IncXi ----> IncXi = VX = INCREMENTO QUE SE APLICA A LAS SECCIONES CON AVANCE INCLINADO
   3B72 18 25         [12]  249       jr continua_fin2
   3B74                     250    dy_es_mayor:
                            251       ;;if dY>dX
   3B74 3E 00         [ 7]  252       ld    a,    #0          ;; A = 0
   3B76 DD 77 11      [19]  253       ld en_incXr(ix), a      ;; -- IncXr = 0
   3B79 DD 7E 05      [19]  254       ld    a, en_vy(ix)      ;; A = IncYi = VY
   3B7C DD 77 10      [19]  255       ld en_incYr(ix), a      ;; -- IncYr = IncYi ----> IncYi = VY = INCREMENTO QUE SE APLICA A LAS SECCIONES CON AVANCE INCLINADO
                            256 
                            257       ;; =============================== ;;
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 59.
Hexadecimal [16-Bits]



                            258       ;; INTERCAMBIO LOS VALORES dX y dY ;;
                            259       ;;             k  = dX             ;;
                            260       ;;             dX = dY             ;;
                            261       ;;             dY =  k             ;;
                            262       ;; =============================== ;;
   3B7F DD 6E 0C      [19]  263       ld    l, en_dX_l(ix)
   3B82 DD 66 0D      [19]  264       ld    h, en_dX_h(ix)
   3B85 EB            [ 4]  265       ex    de,   hl
   3B86 DD 6E 0E      [19]  266       ld    l, en_dY_l(ix)
   3B89 DD 66 0F      [19]  267       ld    h, en_dY_h(ix)
   3B8C DD 75 0C      [19]  268       ld en_dX_l(ix), l
   3B8F DD 74 0D      [19]  269       ld en_dX_h(ix), h
   3B92 EB            [ 4]  270       ex    de,   hl
   3B93 DD 75 0E      [19]  271       ld en_dY_l(ix), l
   3B96 DD 74 0F      [19]  272       ld en_dY_h(ix), h
                            273 
   3B99                     274    continua_fin2:
                            275 
                            276    ;; INICIALIZAR VALORES RAROS
   3B99 DD 6E 0E      [19]  277    ld    l, en_dY_l(ix)       ;; HL = dY
   3B9C DD 66 0F      [19]  278    ld    h, en_dY_h(ix)       ;; |
   3B9F 29            [11]  279    add   hl,   hl             ;; HL + HL = 2 * dY
   3BA0 DD 75 14      [19]  280    ld en_avR_l(ix), l         ;; --> avR = (2 * dY)
   3BA3 DD 74 15      [19]  281    ld en_avR_h(ix), h         ;; |
                            282 
                            283    ;; Hay que negar dX y luego sumarlo
                            284    ;; En DE tendre el valor de dX y en HL ya he conseguido el valor de avR
                            285    ;; av = (HL + (-DE))
                            286    ;; av = (avR - dX)
   3BA6 DD 6E 0C      [19]  287    ld    l, en_dX_l(ix)       ;; HL =  dX
   3BA9 DD 66 0D      [19]  288    ld    h, en_dX_h(ix)       ;; |
   3BAC CD E1 3C      [17]  289    call enemy_get_negative    ;; HL = -dX
   3BAF EB            [ 4]  290    ex    de,   hl             ;; -- DE = -dX
   3BB0 DD 6E 14      [19]  291    ld    l, en_avR_l(ix)      ;; -- HL = avR
   3BB3 DD 66 15      [19]  292    ld    h, en_avR_h(ix)      ;; |
   3BB6 19            [11]  293    add   hl,   de             ;; HL + DE = avR - dX
   3BB7 DD 75 12      [19]  294    ld en_av_l(ix), l          ;; av = avR - dX
   3BBA DD 74 13      [19]  295    ld en_av_h(ix), h          ;; |
                            296 
                            297    ;; En HL ya tengo av y en DE tengo -dX
                            298    ;; Solo tengo que sumarlo
   3BBD 19            [11]  299    add   hl,   de             ;; av + -(dX)
   3BBE DD 75 16      [19]  300    ld en_avI_l(ix), l         ;; --> avI = (av - dX)
   3BC1 DD 74 17      [19]  301    ld en_avI_h(ix), h         ;; |
                            302 
                            303    ;;; Cambio update
   3BC4 21 CE 3B      [10]  304    ld hl, #enemy_checkGoal
   3BC7 DD 74 08      [19]  305    ld en_up_h(ix), h
   3BCA DD 75 07      [19]  306    ld en_up_l(ix), l
                            307 
                            308    ; jp enemy_checkGoal
   3BCD C9            [10]  309    ret
                            310 
                            311 ;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            312 ;; CHECKEA SI HA LLEGADO A SU DESTINO
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 60.
Hexadecimal [16-Bits]



                            313 ;; _______________________
                            314 ;; ENTRADA:    IX -> Puntero a entidad enemigo del bucle
                            315 ;; DESTRUYE:   A,HL,DE,B
                            316 ;;;;;;;;;;;;;;;;;;;;;;;;;;;
   3BCE                     317 enemy_checkGoal:
                            318    ;; Si ha llegado al destino -> NO MUEVO
                            319    ;; COMPROBACION EN X ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   3BCE DD 7E 0A      [19]  320    ld    a,    en_g_x(ix)           ;; Cargo la posicion del goal
   3BD1 DD BE 00      [19]  321    cp    en_x(ix)                   ;; Le resto la posicion del enemigo
   3BD4 20 12         [12]  322    jr nz, no_goal_yet
   3BD6 DD 36 04 00   [19]  323       ld en_vx(ix),  #0          ;; Pongo a 0 -> RESET
   3BDA DD 36 05 00   [19]  324       ld en_vy(ix),  #0          ;; Pongo a 0 -> RESET
                            325 
   3BDE 21 E4 3A      [10]  326       ld hl, #enemy_randomGoal      ;; Vuelvo a cambiar el update del enemigo
   3BE1 DD 74 08      [19]  327       ld en_up_h(ix), h
   3BE4 DD 75 07      [19]  328       ld en_up_l(ix), l
   3BE7 C9            [10]  329       ret
   3BE8                     330    no_goal_yet:
                            331    ;; El spaghetti code de @daNNi
                            332    ;; THE FINAL BOSS: Actualizo Bresenham
                            333 
   3BE8 DD 6E 12      [19]  334    ld    l, en_av_l(ix)       ;; HL = av
   3BEB DD 66 13      [19]  335    ld    h, en_av_h(ix)       ;; |
   3BEE 11 00 80      [10]  336    ld    de,   #0x8000        ;; DE = 7FFF
   3BF1 30 01         [12]  337    jr    nc, no_carry2        ;; Si C = 0, no hago nada
   3BF3 3F            [ 4]  338       ccf                     ;; Si entra aqui, C = 1, entonces invierto -> C = 0
   3BF4                     339    no_carry2:
   3BF4 ED 52         [15]  340    sbc   hl,   de
   3BF6 30 3E         [12]  341    jr    nc,    av_negativo
                            342       ;; Aqui av, es positivo o 0
   3BF8 DD 7E 18      [19]  343       ld    a,    en_flagVel(ix)
   3BFB FE 01         [ 7]  344       cp    #1
   3BFD 28 21         [12]  345       jr    z, utiliza_i      ;; NECESITA UTILIZAR i
                            346          ;; Cambiar de r a i
                            347          ;; CAMBIO DE LAS Y
   3BFF DD 7E 10      [19]  348          ld    a,    en_incYr(ix)   ;; A = IncYr
   3C02 47            [ 4]  349          ld    b,    a              ;; B = A = IncYr
   3C03 DD 7E 05      [19]  350          ld    a,    en_vy(ix)      ;; A = IncYi
   3C06 DD 77 10      [19]  351          ld en_incYr(ix), a         ;; Intercambio 1
   3C09 78            [ 4]  352          ld    a,    b              ;; A = B = IncYr
   3C0A DD 77 05      [19]  353          ld en_vy(ix), a            ;; Intercambio 2
                            354 
                            355          ;; CAMBIO DE LAS X
   3C0D DD 7E 11      [19]  356          ld    a,    en_incXr(ix)   ;; A = IncXr
   3C10 47            [ 4]  357          ld    b,    a              ;; B = A = IncXr
   3C11 DD 7E 04      [19]  358          ld    a,    en_vx(ix)      ;; A = IncXi
   3C14 DD 77 11      [19]  359          ld en_incXr(ix), a         ;; Intercambio 1
   3C17 78            [ 4]  360          ld    a,    b              ;; A = B = IncXr
   3C18 DD 77 04      [19]  361          ld en_vx(ix), a            ;; Intercambio 2
                            362 
   3C1B 3E 01         [ 7]  363          ld    a,    #1             ;; Finalmente cambio el flag de la velocidad
   3C1D DD 77 18      [19]  364          ld en_flagVel(ix), a       ;; flag_vel = 1
   3C20                     365       utiliza_i:
                            366          ;; Aqui no hace falta cambiar ninguna velocidad
   3C20 DD 6E 12      [19]  367          ld    l, en_av_l(ix)       ;; HL = av
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 61.
Hexadecimal [16-Bits]



   3C23 DD 66 13      [19]  368          ld    h, en_av_h(ix)       ;; |
   3C26 EB            [ 4]  369          ex    de,   hl             ;; -- DE = av
   3C27 DD 6E 16      [19]  370          ld    l, en_avI_l(ix)      ;; -- HL = avI
   3C2A DD 66 17      [19]  371          ld    h, en_avI_h(ix)      ;; |
   3C2D 19            [11]  372          add   hl,   de             ;; DE + HL
   3C2E DD 75 12      [19]  373          ld en_av_l(ix), l          ;; -- av = (av + avI)
   3C31 DD 74 13      [19]  374          ld en_av_h(ix), h          ;; |
   3C34 18 3C         [12]  375       jr end_if
   3C36                     376    av_negativo:
                            377       ;; Aqui av, es negativo
                            378       ;;     X = (X + IncXr)     // X aumenta en recto.
                            379       ;;     Y = (Y + IncYr)     // Y aumenta en recto.
                            380       ;;     av = (av + avR)     // Avance Recto
   3C36 DD 7E 18      [19]  381       ld    a,    en_flagVel(ix)
   3C39 FE 00         [ 7]  382       cp    #0
   3C3B 28 21         [12]  383       jr    z, utiliza_r      ;; NECESITA UTILIZAR r
                            384          ;; Cambiar de i a r
                            385          ;; CAMBIO DE LAS Y
   3C3D DD 7E 10      [19]  386          ld    a,    en_incYr(ix)   ;; A = IncYr
   3C40 47            [ 4]  387          ld    b,    a              ;; B = A = IncYr
   3C41 DD 7E 05      [19]  388          ld    a,    en_vy(ix)      ;; A = IncYi
   3C44 DD 77 10      [19]  389          ld en_incYr(ix), a         ;; Intercambio 1
   3C47 78            [ 4]  390          ld    a,    b              ;; A = B = IncYr
   3C48 DD 77 05      [19]  391          ld en_vy(ix), a            ;; Intercambio 2
                            392 
                            393          ;; CAMBIO DE LAS X
   3C4B DD 7E 11      [19]  394          ld    a,    en_incXr(ix)   ;; A = IncXr
   3C4E 47            [ 4]  395          ld    b,    a              ;; B = A = IncXr
   3C4F DD 7E 04      [19]  396          ld    a,    en_vx(ix)      ;; A = IncXi
   3C52 DD 77 11      [19]  397          ld en_incXr(ix), a         ;; Intercambio 1
   3C55 78            [ 4]  398          ld    a,    b              ;; A = B = IncXr
   3C56 DD 77 04      [19]  399          ld en_vx(ix), a            ;; Intercambio 2
                            400 
   3C59 3E 00         [ 7]  401          ld    a,    #0             ;; Finalmente cambio el flag de la velocidad
   3C5B DD 77 18      [19]  402          ld en_flagVel(ix), a       ;; flag_vel = 0
   3C5E                     403       utiliza_r:
                            404          ;; Aqui no hace falta cambiar ninguna velocidad
   3C5E DD 6E 12      [19]  405          ld    l, en_av_l(ix)       ;; HL = av
   3C61 DD 66 13      [19]  406          ld    h, en_av_h(ix)       ;; |
   3C64 EB            [ 4]  407          ex    de,   hl             ;; -- DE = av
   3C65 DD 6E 14      [19]  408          ld    l, en_avR_l(ix)      ;; -- HL = avI
   3C68 DD 66 15      [19]  409          ld    h, en_avR_h(ix)      ;; |
   3C6B 19            [11]  410          add   hl,   de             ;; DE + HL
   3C6C DD 75 12      [19]  411          ld en_av_l(ix), l          ;; -- av = (av + avI)
   3C6F DD 74 13      [19]  412          ld en_av_h(ix), h          ;; |
   3C72                     413    end_if:
                            414 
                            415    ;; Primero hay que comprobar si la posicion
                            416    ;; a la que se va a mover NO ES UN OBSTACULO
                            417    ;; - OBSTACULO = EL BIT MAS SIGNIFICATIVO ES 0 (por ahora)
                            418 
   3C72 CD EC 3C      [17]  419    call checkTileCollision
   3C75 20 12         [12]  420    jr nz, no_colision       ;; SI EL BIT 3 ES 1 -> HAY COLISION
   3C77 DD 36 04 00   [19]  421       ld en_vx(ix),  #0          ;; Pongo a 0 -> RESET
   3C7B DD 36 05 00   [19]  422       ld en_vy(ix),  #0          ;; Pongo a 0 -> RESET
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 62.
Hexadecimal [16-Bits]



                            423 
   3C7F 21 E4 3A      [10]  424       ld hl, #enemy_randomGoal      ;; Vuelvo a cambiar el update del enemigo
   3C82 DD 74 08      [19]  425       ld en_up_h(ix), h
   3C85 DD 75 07      [19]  426       ld en_up_l(ix), l
   3C88 C9            [10]  427       ret
   3C89                     428    no_colision:
   3C89 DD 7E 00      [19]  429    ld a, en_x(ix)          ;; Actualizo posicion en X
   3C8C DD 86 04      [19]  430    add en_vx(ix)           ;; |
   3C8F DD 77 00      [19]  431    ld en_x(ix), a          ;; x = x + vx
                            432 
   3C92 DD 7E 01      [19]  433    ld a, en_y(ix)          ;; Actualizo posicion en Y
   3C95 DD 86 05      [19]  434    add en_vy(ix)           ;; |
   3C98 DD 77 01      [19]  435    ld en_y(ix), a          ;; y = y + vy
   3C9B C9            [10]  436    ret
                            437 
                            438 
                            439 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            440 ;; CONSIGUE UN VALOR ALEATORIO CORRESPONDIENTE CON LA POSICION EN X
                            441 ;; _________________________________________________________________
                            442 ;; ENTRADA:    IX -> Puntero a entidad enemigo
                            443 ;; DESTRUYE:   A,BC
                            444 ;; SALIDA:     A  -> Posicion aleatoria  en X
                            445 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   3C9C                     446 enemy_getRandom_X:
   3C9C DD 7E 00      [19]  447    ld a, en_x(ix)              ;; Cojo la X actual del jugador
   3C9F D6 06         [ 7]  448    sub #var_r_max              ;; Le resto la distancia maxima a la que quiero ir para sacar el minimo
   3CA1 47            [ 4]  449    ld b, a
   3CA2 30 02         [12]  450    jr nc, not_negative_x       ;; Si el mínimo es menor que 0
   3CA4 06 00         [ 7]  451        ld b, #0                ;; Se pone a 0
   3CA6                     452    not_negative_x:
                            453 
   3CA6 DD 7E 00      [19]  454    ld a, en_x(ix)              ;; Cojo la X actual de nuevo
   3CA9 C6 06         [ 7]  455    add #var_r_max              ;; Le sumo la distancia maxima para sacar el maximo
   3CAB 4F            [ 4]  456    ld c, a
   3CAC FE 1E         [ 7]  457    cp #MAP_WIDTH               ;; Si el maximo es mayor que el ancho del mapa
   3CAE 38 02         [12]  458    jr c, not_over_Map_Max_x
   3CB0 0E 1E         [ 7]  459        ld c, #MAP_WIDTH        ;; Lo pongo al ancho total del mapa
   3CB2                     460    not_over_Map_Max_x:
   3CB2 CD 81 3D      [17]  461    call getRandomInRange       ;; Genero un numero aleatorio entre MIN y MAX
                            462 
   3CB5 DD 77 0A      [19]  463    ld en_g_x(ix), a             ;; Cargo la posicion random en el enemigo
   3CB8 C9            [10]  464    ret
                            465 
                            466 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            467 ;; CONSIGUE UN VALOR ALEATORIO CORRESPONDIENTE CON LA POSICION EN Y
                            468 ;; _________________________________________________________________
                            469 ;; ENTRADA:    IX -> Puntero a entidad enemigo
                            470 ;; DESTRUYE:   A,BC
                            471 ;; SALIDA:     A  -> Posicion aleatoria  en Y
                            472 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   3CB9                     473 enemy_getRandom_Y:
   3CB9 DD 7E 01      [19]  474    ld a, en_y(ix)               ;; Cojo la Y actual del jugador
   3CBC D6 06         [ 7]  475    sub #var_r_max               ;; Le resto la distancia maxima a la que quiero ir para sacar el minimo
   3CBE 47            [ 4]  476    ld b, a
   3CBF 30 02         [12]  477    jr nc, not_negative_y        ;; Si el mínimo es menor que 0
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 63.
Hexadecimal [16-Bits]



   3CC1 06 00         [ 7]  478        ld b, #0                 ;; Lo pongo a 0
   3CC3                     479    not_negative_y:
                            480 
   3CC3 DD 7E 01      [19]  481    ld a, en_y(ix)               ;; Cojo la Y actual de nuevo
   3CC6 C6 06         [ 7]  482    add #var_r_max               ;; Le sumo la distancia maxima para sacar el maximo
   3CC8 4F            [ 4]  483    ld c, a
   3CC9 FE 1E         [ 7]  484    cp #MAP_HEIGHT               ;; Si el maximo es mayor que el ancho del mapa
   3CCB 38 02         [12]  485    jr c, not_over_Map_Max_y
   3CCD 0E 1E         [ 7]  486        ld c, #MAP_HEIGHT        ;; Lo pongo al ancho total del mapa
   3CCF                     487    not_over_Map_Max_y:
   3CCF CD 81 3D      [17]  488    call getRandomInRange
                            489 
   3CD2 DD 77 0B      [19]  490    ld en_g_y(ix), a                          ;; Cargo la posicion random en el enemigo
   3CD5 C9            [10]  491    ret
                            492 
                            493 ;; ENTRADA:    HL -> Valor de 2 bytes a llevar a valor positivo, en caso que sea negativo
                            494 ;; DESTRUYE:   A, HL
                            495 ;; SALIDA:     HL -> Valor negativo negado = valor positivo
   3CD6                     496 enemy_get_positive:
   3CD6 7C            [ 4]  497    ld     a, h                ;; A = 00/FF
   3CD7 FE 00         [ 7]  498    cp    #0                   ;; |
   3CD9 C8            [11]  499    ret     z
   3CDA 7D            [ 4]  500       ld    a, l              ;; A = -dY
   3CDB 2F            [ 4]  501       cpl
   3CDC 3C            [ 4]  502       inc a                   ;; A =  dY -> Aqui ya tengo dY en positivo
   3CDD 26 00         [ 7]  503       ld    h, #0             ;; H = 00
   3CDF 6F            [ 4]  504       ld    l, a              ;; L = dY --> HL = 00**, donde ** = dY
   3CE0 C9            [10]  505    ret
                            506 
                            507 ;; Lo mismo que enemy_get_positive pero con negativos
   3CE1                     508 enemy_get_negative:
   3CE1 7C            [ 4]  509    ld    a, h                ;; A = FF/00
   3CE2 FE FF         [ 7]  510    cp    #0xFF               ;; |
   3CE4 C8            [11]  511    ret   z
   3CE5 7D            [ 4]  512       ld    a,    l          ;; A = -dY
   3CE6 2F            [ 4]  513       cpl
   3CE7 3C            [ 4]  514       inc   a                ;; A =  dY -> Aqui ya tengo dY en positivo
   3CE8 26 FF         [ 7]  515       ld    h,    #0xFF      ;; H = FF
   3CEA 6F            [ 4]  516       ld    l,    a          ;; L = dY --> HL = FF**, donde ** = dY
   3CEB C9            [10]  517    ret
                            518 
                            519 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            520 ;; DETERMINA SI HA COLISIONADO CON ALGUN TILE CON COLISION DEL MAPA
                            521 ;; NOTA:       Aplicar una comprobacion de z despues del call para comprobar colision
                            522 ;; ___________________________________________________________________________________
                            523 ;; ENTRADA:    IX -> Entidad a comprobar con COORDENADAS en TILES
                            524 ;; DESTRUYE:   A,BC,DE,HL -> LA DETRUCCIONE E TOTALE
                            525 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   3CEC                     526 checkTileCollision::
                            527    ;; Guardo en C,A (x,y) para las comprobaciones
   3CEC DD 7E 01      [19]  528    ld a, en_y(ix)          ;; Guardo posicion Y nueva en A
   3CEF DD 86 05      [19]  529    add en_vy(ix)           ;; |
                            530 
                            531    ;; Miro en el array del mapa comprobando cada tile
   3CF2 6F            [ 4]  532    ld    l,    a        ;; L = A \
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 64.
Hexadecimal [16-Bits]



   3CF3 26 00         [ 7]  533    ld    h,    #0       ;; H = 0 | -> HL = A
                            534 
   3CF5 4F            [ 4]  535    ld    c,    a        ;; C = A = enemy_y
   3CF6 06 00         [ 7]  536    ld    b,    #0       ;; B = 0 ----------------> BC = A
                            537 
   3CF8 16 1D         [ 7]  538    ld    d,    #29      ;; Multiplicar por 30
   3CFA                     539    loop_mult_y:
   3CFA 09            [11]  540       add hl, bc        ;; HL += BC
   3CFB 15            [ 4]  541       dec d             ;; D--
   3CFC 20 FC         [12]  542    jr nz, loop_mult_y
                            543 
   3CFE EB            [ 4]  544    ex    de,   hl          ;; DE = Aumento 'vertical' del array
                            545 
   3CFF 2A 8A 3A      [16]  546    ld    hl, (ptr_map)     ;; HL apunta a nivel1
   3D02 19            [11]  547    add   hl, de            ;; HL + incremento en vertical
                            548 
   3D03 DD 7E 00      [19]  549    ld    a,    en_x(ix)    ;; |
   3D06 DD 86 04      [19]  550    add en_vx(ix)           ;; E  = Aumento 'horizontal' del array
   3D09 5F            [ 4]  551    ld    e,    a
   3D0A 16 00         [ 7]  552    ld    d,    #0          ;; DE = Aumento 'horizontal' del array
   3D0C 19            [11]  553    add   hl, de
                            554 
                            555    ;; Ahora HL apunta al tile en concreto donde se va a mover el enemigo
   3D0D CB 66         [12]  556    bit 4, (hl)
   3D0F C9            [10]  557    ret
                            558 
                            559 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            560 ;; COLISION DE MAPA CON IX EN COORDENADAS DE PANTALLA
                            561 ;; NOTA:       Aplicar una comprobacion de z despues del call para comprobar colision
                            562 ;; ___________________________________________________________________________________
                            563 ;; ENTRADA:    IX -> Entidad a comprobar con COORDENADAS en TILES
                            564 ;; DESTRUYE:   A,BC,DE,HL -> LA DETRUCCIONE E CASI TOTALE
                            565 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   3D10                     566 checkTileCollision_m::
                            567    ;; ================================ ;;
                            568    ;; IX EN COORDENADAS DE PANTALLA !! ;;
                            569    ;; ================================ ;;
                            570    ;; Guardar en AF' las coordenadas para que no se pierdan
   3D10 DD 6E 00      [19]  571    ld    l,    en_x(ix)       ;; L = X_pantalla
   3D13 DD 66 01      [19]  572    ld    h,    en_y(ix)       ;; H = Y_pantalla
   3D16 CD B2 39      [17]  573    call mapa_a_tile           ;; B = X, C = Y
                            574 
                            575    ;; Guardo en C,A (x,y) para las comprobaciones
   3D19 78            [ 4]  576    ld    a,    b              ;; Guardo posicion Y nueva en A
   3D1A D9            [ 4]  577    exx                        ;; Guardo el valor de BC en BC' para no destruirlo
                            578    ; add en_vy(ix)              ;; |
                            579 
                            580    ;; Miro en el array del mapa comprobando cada tile
   3D1B 6F            [ 4]  581    ld    l,    a        ;; L = A \
   3D1C 26 00         [ 7]  582    ld    h,    #0       ;; H = 0 | -> HL = A
                            583 
   3D1E 4F            [ 4]  584    ld    c,    a        ;; C = A = enemy_y actualizada con vy
   3D1F 06 00         [ 7]  585    ld    b,    #0       ;; B = 0 ----------------> BC = A
                            586 
   3D21 16 1D         [ 7]  587    ld    d,    #29      ;; Multiplicar por 30
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 65.
Hexadecimal [16-Bits]



   3D23                     588    loop_mult_y_m:
   3D23 09            [11]  589       add hl, bc        ;; HL += BC
   3D24 15            [ 4]  590       dec d             ;; D--
   3D25 20 FC         [12]  591    jr nz, loop_mult_y_m
                            592 
   3D27 EB            [ 4]  593    ex    de,   hl          ;; DE = Aumento 'vertical' del array
                            594 
   3D28 2A 8A 3A      [16]  595    ld    hl, (ptr_map)     ;; HL apunta a nivel1
   3D2B 19            [11]  596    add   hl, de            ;; HL + incremento en vertical
                            597 
   3D2C D9            [ 4]  598    exx                     ;; Devuelvo de nuevo el valor de BC
   3D2D 79            [ 4]  599    ld    a,    c
   3D2E D9            [ 4]  600    exx
                            601 
                            602    ; add en_vx(ix)
   3D2F 5F            [ 4]  603    ld    e,    a           ;; E  = Aumento 'horizontal' del array
   3D30 16 00         [ 7]  604    ld    d,    #0          ;; DE = Aumento 'horizontal' del array
   3D32 19            [11]  605    add   hl, de
                            606 
                            607    ;; Ahora HL apunta al tile en concreto donde se va a mover el enemigo
   3D33 CB 66         [12]  608    bit 4, (hl)
                            609 
                            610    ;; COMPROBAR
                            611    ;;    |
                            612    ;;    v
                            613    ;;  0 0 0 0
                            614    ;;  0 0 0 1
                            615    ;;  0 0 1 0
                            616    ;;  0 0 1 1
                            617    ;;  0 1 0 0
                            618    ;;  0 1 0 1
                            619    ;;  0 1 1 0
                            620    ;;  0 1 1 1
                            621 
   3D35 C9            [10]  622    ret
                            623 
                            624 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                            625 ;; MIRA SI EL HEROE ESTA POR DEBAJO DE UNA CIERTA DISTANCIA EN X E Y
                            626 ;; ASIGNA, ADEMAS, LA POSICION FINAL DEL MOVIMIENTO Y LLAMA A enemy_randomGoal
                            627 ;; ¡¡ IMPORTANTE !! -> COMPRUEBA LAS DISTANCIAS EN TILES
                            628 ;; ________________________________________________________________________________
                            629 ;; ENTRADA:    IX -> Apunta a la entidad enemigo
                            630 ;; DESTRUYE:   LA DETRUCCIONE E TOTALE
                            631 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   3D36                     632 enemy_heroInRadius:
                            633    ;; Guardo la funcion update
                            634    ;; que se encuentra en HL
                            635    ;; mediante un push a la pila
   3D36 DD 66 08      [19]  636    ld h, en_up_h(ix)
   3D39 DD 6E 07      [19]  637    ld l, en_up_l(ix)
   3D3C E5            [11]  638    push hl
                            639 
                            640    ;; Consigo los datos del heroe
                            641    ;;          A = X
                            642    ;;          B = Y
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 66.
Hexadecimal [16-Bits]



   3D3D CD E4 35      [17]  643    call hero_get_position
                            644 
                            645    ;; ==============================================================================
                            646    ;; Paso las coordenadas del heroe
                            647    ;;     a coordenadas de tile
                            648    ;;          L = X
                            649    ;;          H = Y
   3D40 6F            [ 4]  650    ld    l,    a
   3D41 78            [ 4]  651    ld    a,    b
   3D42 67            [ 4]  652    ld    h,    a
   3D43 CD B2 39      [17]  653    call mapa_a_tile
                            654    ;; Ahora tengo las coordenadas
                            655    ;;     del heroe en tiles
                            656    ;;          C = X
                            657    ;;          B = Y
                            658    ;; ==============================================================================
                            659 
                            660    ;; ==============================================================================
                            661    ;; Comparo las posiciones de X
                            662    ;; y consigo la distancia en el eje X
   3D46 79            [ 4]  663    ld    a,    c
   3D47 DD 96 00      [19]  664    sub   en_x(ix)
   3D4A 30 02         [12]  665    jr nc, hIR_x_positive
   3D4C ED 44         [ 8]  666       neg
   3D4E                     667    hIR_x_positive:
                            668 
                            669    ;; Aplico el rango que se elija
                            670    ;;       RANGE = 4
   3D4E FE 05         [ 7]  671    cp    #5
   3D50 30 14         [12]  672    jr    nc, hIR_end
   3D52 18 00         [12]  673       jr hIR_check_y
                            674    ;; ==============================================================================
                            675 
   3D54                     676    hIR_check_y:
                            677    ;; ==============================================================================
                            678    ;; Comparo las posiciones de Y
                            679    ;; y consigo la distancia en el eje Y
   3D54 78            [ 4]  680    ld    a,    b
   3D55 DD 96 01      [19]  681    sub   en_y(ix)
   3D58 30 02         [12]  682    jr    nc, hIR_y_positive
   3D5A ED 44         [ 8]  683       neg
   3D5C                     684    hIR_y_positive:
                            685 
                            686    ;; Aplico el rango que se elija
                            687    ;;       RANGE = 6
   3D5C FE 07         [ 7]  688    cp    #7
   3D5E 30 06         [12]  689    jr    nc, hIR_end
   3D60 DD 36 06 FE   [19]  690       ld en_col(ix), #0xFE
   3D64 18 0C         [12]  691       jr hIR_doThings
                            692       ;; ==============================================================================
                            693 
   3D66                     694    hIR_end:
   3D66 DD 36 06 0F   [19]  695    ld en_col(ix), #0x0F
                            696 
                            697    ;; Actualizo la funcion de update
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 67.
Hexadecimal [16-Bits]



                            698    ;; y asigno la funcion por defecto
   3D6A E1            [10]  699    pop hl
   3D6B DD 74 08      [19]  700    ld en_up_h(ix), h
   3D6E DD 75 07      [19]  701    ld en_up_l(ix), l
   3D71 C9            [10]  702    ret
                            703 
   3D72                     704    hIR_doThings:
                            705 
                            706    ;; ============================================================================================
                            707    ;; V1: Sigue al personaje
                            708    ;; Consigo los datos del heroe
                            709    ;;          A = X
                            710    ;;          B = Y
   3D72 CD E4 35      [17]  711    call hero_get_position
                            712    ;; ===============================
                            713    ;; Paso las coordenadas del heroe
                            714    ;;     a coordenadas de tile
                            715    ;;          L = X
                            716    ;;          H = Y
   3D75 6F            [ 4]  717    ld    l,    a
   3D76 78            [ 4]  718    ld    a,    b
   3D77 67            [ 4]  719    ld    h,    a
   3D78 CD B2 39      [17]  720    call mapa_a_tile
                            721 
                            722    ;; Libero el registro del
                            723    ;; contenido de la pila
                            724    ;; que he almacenado al
                            725    ;; principio de la funcion
   3D7B E1            [10]  726    pop hl
                            727 
                            728    ;; Ahora se:
                            729    ;;    - d(hero,enemy) <= 4
                            730    ;;    - Posicion del heroe = (B,C) = (X,Y) = posicion final del movimiento
   3D7C 1E EE         [ 7]  731    ld    e, #0xEE          ;; Senyal a enemy_randomGoal para que no busque ningun random
   3D7E C3 E4 3A      [10]  732    jp enemy_randomGoal
                            733    ;; ============================================================================================
                            734 
                            735 ;=================================
                            736 ; Generates random number in range
                            737 ; Return: A = Random
                            738 ; Input: [B = MIN, C = MAX]
                            739 ;=================================
   3D81                     740 getRandomInRange::
   3D81 D9            [ 4]  741     exx
   3D82 CD 79 40      [17]  742     call cpct_getRandom_mxor_u8_asm
   3D85 7D            [ 4]  743     ld a, l
   3D86 D9            [ 4]  744     exx
   3D87                     745     reduce_max:
   3D87 B9            [ 4]  746     cp c
   3D88 38 03         [12]  747     jr c, ensure_min
   3D8A 91            [ 4]  748     sub c
   3D8B 18 FA         [12]  749     jr reduce_max
   3D8D                     750     ensure_min:
   3D8D 80            [ 4]  751     add b
   3D8E C9            [10]  752 ret
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 68.
Hexadecimal [16-Bits]



                            753 
   3D8F                     754 enemy_load::
   3D8F FD 21 56 3A   [14]  755    ld iy, #vector_init
   3D93 C9            [10]  756    ret
                            757 
   3D94                     758 get_enemy_size::
   3D94 3E 19         [ 7]  759    ld a, #enemy_size
   3D96 C9            [10]  760    ret
                            761 
                            762    ; kill::
                            763    ;  call hero_get_iy
                            764    ;  ld     h, e_y(iy)
                            765    ;  ld     l, e_x(iy)
                            766    ;  call mapa_a_tile
                            767    ;  ld a, e_x(ix)
                            768    ;  cp c
   3D97 FD 36 01 0F   [19]  769          ld e_y(iy),#15
   3D9B FD 36 00 0F   [19]  770          ld e_x(iy),#15
                            771    ;  jr nz, noCol
                            772    ;    ld a, e_y(ix)
                            773    ;    cp b
                            774    ;    jr nz, noCol
                            775    ;      ld e_x(iy), #30
                            776    ;      ld e_y(iy), #300
                            777    ;  noCol:
                            778    ;  ret
                            779 
   3D9F                     780    kill::
                            781 
   3D9F DD 66 01      [19]  782    ld     h, e_y(ix)
   3DA2 DD 6E 00      [19]  783    ld     l, e_x(ix)
   3DA5 CD 8D 39      [17]  784    call tile_a_mapa
   3DA8 CD EC 35      [17]  785    call hero_get_iy
                            786 
   3DAB 79            [ 4]  787    ld a, c
   3DAC C6 04         [ 7]  788    add a,#4
   3DAE 3D            [ 4]  789    dec a
   3DAF FD BE 00      [19]  790    cp a, e_x(iy)
   3DB2 DA DB 3D      [10]  791    jp c, noCol
                            792 
   3DB5 FD 7E 00      [19]  793    ld a, e_x(iy)
   3DB8 C6 04         [ 7]  794    add a,#4
   3DBA 3D            [ 4]  795    dec a
   3DBB B9            [ 4]  796    cp a,c
   3DBC DA DB 3D      [10]  797    jp c, noCol
                            798 
   3DBF 78            [ 4]  799    ld a, b
   3DC0 C6 08         [ 7]  800    add a,#8
   3DC2 3D            [ 4]  801    dec a
   3DC3 FD BE 01      [19]  802    cp a, e_y(iy)
   3DC6 DA DB 3D      [10]  803    jp c, noCol
                            804 
   3DC9 FD 7E 01      [19]  805    ld a, e_y(iy)
   3DCC C6 08         [ 7]  806    add a,#8
   3DCE 3D            [ 4]  807    dec a
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 69.
Hexadecimal [16-Bits]



   3DCF B8            [ 4]  808    cp a, b
   3DD0 DA DB 3D      [10]  809    jp c, noCol
                            810 
   3DD3 FD 36 01 50   [19]  811    ld e_y(iy),#80
   3DD7 FD 36 00 2C   [19]  812    ld e_x(iy),#300
                            813 
   3DDB                     814    noCol:
   3DDB C9            [10]  815    ret
