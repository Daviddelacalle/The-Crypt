##-----------------------------LICENSE NOTICE------------------------------------
##  This file is part of CPCtelera: An Amstrad CPC Game Engine
##  Copyright (C) 2018 ronaldo / Fremos / Cheesetea / ByteRealms (@FranGallegoBR)
##
##  This program is free software: you can redistribute it and/or modify
##  it under the terms of the GNU Lesser General Public License as published by
##  the Free Software Foundation, either version 3 of the License, or
##  (at your option) any later version.
##
##  This program is distributed in the hope that it will be useful,
##  but WITHOUT ANY WARRANTY; without even the implied warranty of
##  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
##  GNU Lesser General Public License for more details.
##
##  You should have received a copy of the GNU Lesser General Public License
##  along with this program.  If not, see <http://www.gnu.org/licenses/>.
##------------------------------------------------------------------------------
############################################################################
##                        CPCTELERA ENGINE                                ##
##                 Automatic image conversion file                        ##
##------------------------------------------------------------------------##
## This file is intended for users to automate tilemap conversion from    ##
## original files (like Tiled .tmx) into C-arrays.                        ##
############################################################################

##
## NEW MACROS
##

# Default values
#$(eval $(call TMX2DATA, SET_ASMVARPREFIX, yes       ))   { yes, no      }
#$(eval $(call TMX2DATA, SET_USEMACROS   , yes       ))   { yes, no      }
#$(eval $(call TMX2DATA, SET_OUTPUTS     , h c       ))   { bin hs h s c }
#$(eval $(call TMX2DATA, SET_BASE        , dec       ))   { dec hex bin }
#$(eval $(call TMX2DATA, SET_BITSPERITEM , 8         ))   { 1, 2, 4, 6, 8 }
#$(eval $(call TMX2DATA, SET_FOLDER      , src/      ))
#$(eval $(call TMX2DATA, SET_EXTRAPAR    ,           ))
# Conversion
#$(eval $(call TMX2DATA, CONVERT, tmxfile, array ))


#$(eval $(call TMX2DATA, SET_BITSPERITEM , 4         ))
$(eval $(call TMX2DATA, SET_FOLDER      , src/Mapas ))
$(eval $(call TMX2DATA, SET_OUTPUTS     , hs bin    ))
$(eval $(call TMX2DATA, CONVERT, assets/World1/Level1/Level1.tmx, level1	))
$(eval $(call TMX2DATA, CONVERT, assets/World1/Level2/Level2.tmx, level2	))
$(eval $(call TMX2DATA, CONVERT, assets/World1/Level3/Level3.tmx, level3	))
$(eval $(call TMX2DATA, CONVERT, assets/World1/Level4/Level4.tmx, level4	))
$(eval $(call TMX2DATA, CONVERT, assets/World1/Level5/Level5.tmx, level5	))
$(eval $(call TMX2DATA, CONVERT, assets/World1/Level6/Level6.tmx, level6	))
$(eval $(call TMX2DATA, CONVERT, assets/World1/Level7/Level7.tmx, level7	))
$(eval $(call TMX2DATA, CONVERT, assets/World1/Level8/Level8.tmx, level8	))
$(eval $(call TMX2DATA, CONVERT, assets/World1/Level9/Level9.tmx, level9	))
$(eval $(call TMX2DATA, CONVERT, assets/World1/Level10/Level10.tmx, level10	))

$(eval $(call TMX2DATA, CONVERT, assets/World1/Level12/Level12.tmx, level12	))
$(eval $(call TMX2DATA, CONVERT, assets/World1/Level15/Level15.tmx, level15	))
$(eval $(call TMX2DATA, CONVERT, assets/World1/Level18/Level18.tmx, level18	))
$(eval $(call TMX2DATA, CONVERT, assets/World1/Level11/Level11.tmx, level11	))
$(eval $(call TMX2DATA, CONVERT, assets/World1/Level13/Level13.tmx, level13	))
$(eval $(call TMX2DATA, CONVERT, assets/World1/Level14/Level14.tmx, level14	))
$(eval $(call TMX2DATA, CONVERT, assets/World1/Level16/Level16.tmx, level16	))
$(eval $(call TMX2DATA, CONVERT, assets/World1/Level17/Level17.tmx, level17	))
$(eval $(call TMX2DATA, CONVERT, assets/World1/Level20/Level20.tmx, level20	))
$(eval $(call TMX2DATA, CONVERT, assets/World1/Level21/Level21.tmx, level21	))
$(eval $(call TMX2DATA, CONVERT, assets/Hud/hud.tmx, hud	))

##
## OLD MACROS (For compatibility)
##

## TILEMAP CONVERSION EXAMPLES (Uncomment EVAL lines to use)
##

## Convert img/tilemap.tmx to src/tilemap.c and src/tilemap.h
##		This file contains a tilemap created with Tiled that uses tiles
## in img/tiles.png. This macro will convert the tilemap into a C-array
## named g_tilemap, containing all the IDs of the tiles that are located
## at each given location of the C-array.
##

#$(eval $(call TMX2C,img/tilemap.tmx,g_tilemap,src/,4))

## Convert img/level0b.tmx to src/levels/level0b.c and src/levels/level0b.h
##		This file contains another tilemap created with Tiled. This macro
## will convert the tilemap into a C bitarray of 4-bits per item. The array
## will be named g_level0_4bit. For each tile ID included into the final
## bitarray, only 4 bits will be used. Therefore, each byte of the array
## will contain 2 tile IDs.
##

#$(eval $(call TMX2C,img/level0b.tmx,g_level0_4bit,src/levels/,4))




############################################################################
##              DETAILED INSTRUCTIONS AND PARAMETERS                      ##
##------------------------------------------------------------------------##
##                                                                        ##
## Macro used for conversion is TMX2C, which has up to 4 parameters:      ##
##  (1): TMX file to be converted to C array                              ##
##  (2): C identifier for the generated C array                           ##
##  (3): Output folder for C and H files generated (Default same folder)  ##
##  (4): Bits per item (1,2,4 or 6 to codify tilemap into a bitarray).    ##
##       Blanck for normal integer tilemap array (8 bits per item)        ##
##  (5): Aditional options (aditional modifiers for cpct_tmx2csv)         ##
##                                                                        ##
## Macro is used in this way (one line for each image to be converted):   ##
##  $(eval $(call TMX2C,(1),(2),(3),(4),(5)))                             ##
##                                                                        ##
## Important:                                                             ##
##  * Do NOT separate macro parameters with spaces, blanks or other chars.##
##    ANY character you put into a macro parameter will be passed to the  ##
##    macro. Therefore ...,src/sprites,... will represent "src/sprites"   ##
##    folder, whereas ...,  src/sprites,... means "  src/sprites" folder. ##
##  * You can omit parameters by leaving them empty.                      ##
##  * Parameters (4) and (5) are optional and generally not required.     ##
############################################################################
