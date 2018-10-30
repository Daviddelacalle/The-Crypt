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
##                 Automatic compression utilities                        ##
##------------------------------------------------------------------------##
## This file is intended for users to automate the generation of          ##
## compressed files and their inclusion in users' projects.               ##
############################################################################

## COMPRESSION EXAMPLE (Uncomment lines to use)
##

## First 3 calls to ADD2PACK add enemy, hero and background
## graphics (previously converted to binary data) into the
## compressed group 'mygraphics'. After that, call to PACKZX7B
## compresses all the data and generates an array with the result
## that is placed in src/mygraphics.c & src/mygraphics.h, ready
## to be included and used by other modules.
##
#$(eval $(call ADD2PACK,mygraphics,gfx/enemy.bin))
#$(eval $(call ADD2PACK,mygraphics,gfx/hero.bin))
#$(eval $(call ADD2PACK,mygraphics,gfx/background.bin))
#$(eval $(call PACKZX7B,mygraphics,src/))

$(eval $(call ADD2PACK,PRESSANY,src/Sprites/PRESSANY.bin))
$(eval $(call PACKZX7B,PRESSANY,src/Compression/))

$(eval $(call ADD2PACK,Menu_1,src/Sprites/Menu_1.bin))
$(eval $(call PACKZX7B,Menu_1,src/Compression/))

$(eval $(call ADD2PACK,Menu_2,src/Sprites/Menu_2.bin))
$(eval $(call PACKZX7B,Menu_2,src/Compression/))

$(eval $(call ADD2PACK,Menu_3,src/Sprites/Menu_3.bin))
$(eval $(call PACKZX7B,Menu_3,src/Compression/))

$(eval $(call ADD2PACK,Menu_4,src/Sprites/Menu_4.bin))
$(eval $(call PACKZX7B,Menu_4,src/Compression/))

$(eval $(call ADD2PACK,Menu_5,src/Sprites/Menu_5.bin))
$(eval $(call PACKZX7B,Menu_5,src/Compression/))

$(eval $(call ADD2PACK,Menu_6,src/Sprites/Menu_6.bin))
$(eval $(call PACKZX7B,Menu_6,src/Compression/))

$(eval $(call ADD2PACK,Menu_7,src/Sprites/Menu_7.bin))
$(eval $(call PACKZX7B,Menu_7,src/Compression/))

$(eval $(call ADD2PACK,Menu_8,src/Sprites/Menu_8.bin))
$(eval $(call PACKZX7B,Menu_8,src/Compression/))

# GAMEOVER
$(eval $(call ADD2PACK,GameOver1,src/Sprites/GAMEOVER_1.bin))
$(eval $(call PACKZX7B,GameOver1,src/Compression/))

$(eval $(call ADD2PACK,GameOver2,src/Sprites/GAMEOVER_2.bin))
$(eval $(call PACKZX7B,GameOver2,src/Compression/))

$(eval $(call ADD2PACK,GameOver3,src/Sprites/GAMEOVER_3.bin))
$(eval $(call PACKZX7B,GameOver3,src/Compression/))

$(eval $(call ADD2PACK,GameOver4,src/Sprites/GAMEOVER_4.bin))
$(eval $(call PACKZX7B,GameOver4,src/Compression/))

#VICTORY
$(eval $(call ADD2PACK,Victory1,src/Sprites/VICTORY_1.bin))
$(eval $(call PACKZX7B,Victory1,src/Compression/))

$(eval $(call ADD2PACK,Victory2,src/Sprites/VICTORY_2.bin))
$(eval $(call PACKZX7B,Victory2,src/Compression/))

$(eval $(call ADD2PACK,Victory3,src/Sprites/VICTORY_3.bin))
$(eval $(call PACKZX7B,Victory3,src/Compression/))

$(eval $(call ADD2PACK,Victory4,src/Sprites/VICTORY_4.bin))
$(eval $(call PACKZX7B,Victory4,src/Compression/))

$(eval $(call ADD2PACK,Victory5,src/Sprites/VICTORY_5.bin))
$(eval $(call PACKZX7B,Victory5,src/Compression/))



# El jud
$(eval $(call ADD2PACK,hud,src/Mapas/hud.bin))
$(eval $(call PACKZX7B,hud,src/Compression/))

# Mundo 1 - Nivel 1
$(eval $(call ADD2PACK,level1,src/Mapas/Level1.bin))
$(eval $(call ADD2PACK,level1,assets/World1/Level1/Enemies.bin))
$(eval $(call ADD2PACK,level1,assets/World1/Level1/Spawns.bin))
$(eval $(call ADD2PACK,level1,assets/World1/Level1/Teleporter.bin))
$(eval $(call ADD2PACK,level1,assets/World1/Level1/HeroSpawn.bin))
$(eval $(call PACKZX7B,level1,src/Compression/))

# Mundo 1 - Nivel 2
$(eval $(call ADD2PACK,level2,src/Mapas/Level2.bin))
$(eval $(call ADD2PACK,level2,assets/World1/Level2/Enemies.bin))
$(eval $(call ADD2PACK,level2,assets/World1/Level2/Spawns.bin))
$(eval $(call ADD2PACK,level2,assets/World1/Level2/Teleporter.bin))
$(eval $(call ADD2PACK,level2,assets/World1/Level2/HeroSpawn.bin))
$(eval $(call PACKZX7B,level2,src/Compression/))

# Mundo 1 - Nivel 3
$(eval $(call ADD2PACK,level3,src/Mapas/Level3.bin))
$(eval $(call ADD2PACK,level3,assets/World1/Level3/Enemies.bin))
$(eval $(call ADD2PACK,level3,assets/World1/Level3/Spawns.bin))
$(eval $(call ADD2PACK,level3,assets/World1/Level3/Teleporter.bin))
$(eval $(call ADD2PACK,level3,assets/World1/Level3/HeroSpawn.bin))
$(eval $(call PACKZX7B,level3,src/Compression/))

# Mundo 1 - Nivel 4
$(eval $(call ADD2PACK,level4,src/Mapas/Level4.bin))
$(eval $(call ADD2PACK,level4,assets/World1/Level4/Enemies.bin))
$(eval $(call ADD2PACK,level4,assets/World1/Level4/Spawns.bin))
$(eval $(call ADD2PACK,level4,assets/World1/Level4/Teleporter.bin))
$(eval $(call ADD2PACK,level4,assets/World1/Level4/HeroSpawn.bin))
$(eval $(call PACKZX7B,level4,src/Compression/))

# Mundo 1 - Nivel 5
$(eval $(call ADD2PACK,level5,src/Mapas/Level5.bin))
$(eval $(call ADD2PACK,level5,assets/World1/Level5/Enemies.bin))
$(eval $(call ADD2PACK,level5,assets/World1/Level5/Spawns.bin))
$(eval $(call ADD2PACK,level5,assets/World1/Level5/Teleporter.bin))
$(eval $(call ADD2PACK,level5,assets/World1/Level5/HeroSpawn.bin))
$(eval $(call PACKZX7B,level5,src/Compression/))

# Mundo 1 - Nivel 6
$(eval $(call ADD2PACK,level6,src/Mapas/Level6.bin))
$(eval $(call ADD2PACK,level6,assets/World1/Level6/Enemies.bin))
$(eval $(call ADD2PACK,level6,assets/World1/Level6/Spawns.bin))
$(eval $(call ADD2PACK,level6,assets/World1/Level6/Teleporter.bin))
$(eval $(call ADD2PACK,level6,assets/World1/Level6/HeroSpawn.bin))
$(eval $(call PACKZX7B,level6,src/Compression/))

# Mundo 1 - Nivel 7
$(eval $(call ADD2PACK,level7,src/Mapas/Level7.bin))
$(eval $(call ADD2PACK,level7,assets/World1/Level7/Enemies.bin))
$(eval $(call ADD2PACK,level7,assets/World1/Level7/Spawns.bin))
$(eval $(call ADD2PACK,level7,assets/World1/Level7/Teleporter.bin))
$(eval $(call ADD2PACK,level7,assets/World1/Level7/HeroSpawn.bin))
$(eval $(call PACKZX7B,level7,src/Compression/))

# Mundo 1 - Nivel 8
$(eval $(call ADD2PACK,level8,src/Mapas/Level8.bin))
$(eval $(call ADD2PACK,level8,assets/World1/Level8/Enemies.bin))
$(eval $(call ADD2PACK,level8,assets/World1/Level8/Spawns.bin))
$(eval $(call ADD2PACK,level8,assets/World1/Level8/Teleporter.bin))
$(eval $(call ADD2PACK,level8,assets/World1/Level8/HeroSpawn.bin))
$(eval $(call PACKZX7B,level8,src/Compression/))

# Mundo 1 - Nivel 9
$(eval $(call ADD2PACK,level9,src/Mapas/Level9.bin))
$(eval $(call ADD2PACK,level9,assets/World1/Level9/Enemies.bin))
$(eval $(call ADD2PACK,level9,assets/World1/Level9/Spawns.bin))
$(eval $(call ADD2PACK,level9,assets/World1/Level9/Teleporter.bin))
$(eval $(call ADD2PACK,level9,assets/World1/Level9/HeroSpawn.bin))
$(eval $(call PACKZX7B,level9,src/Compression/))

# Mundo 1 - Nivel 10
$(eval $(call ADD2PACK,level10,src/Mapas/Level10.bin))
$(eval $(call ADD2PACK,level10,assets/World1/Level10/Enemies.bin))
$(eval $(call ADD2PACK,level10,assets/World1/Level10/Spawns.bin))
$(eval $(call ADD2PACK,level10,assets/World1/Level10/Teleporter.bin))
$(eval $(call ADD2PACK,level10,assets/World1/Level10/HeroSpawn.bin))
$(eval $(call PACKZX7B,level10,src/Compression/))


############################################################################
##              DETAILED INSTRUCTIONS AND PARAMETERS                      ##
##------------------------------------------------------------------------##
##                                                                        ##
## Macros used for compression are ADD2PACK and PACKZX7B:                 ##
##                                                                        ##
##	ADD2PACK: Adds files to packed (compressed) groups. Each call to this ##
##  		  macro will add a file to a named compressed group.          ##
##  PACKZX7B: Compresses all files in a group into a single binary and    ##
##            generates a C-array and a header to comfortably use it from ##
##            inside your code.                                           ##
##                                                                        ##
##------------------------------------------------------------------------##
##                                                                        ##
##  $(eval $(call ADD2PACK,<packname>,<file>))                            ##
##                                                                        ##
##		Sequentially adds <file> to compressed group <packname>. Each     ##
## call to this macro adds a new <file> after the latest one added.       ##
## packname could be any valid C identifier.                              ##
##                                                                        ##
##  Parameters:                                                           ##
##  (packname): Name of the compressed group where the file will be added ##
##  (file)    : File to be added at the end of the compressed group       ##
##                                                                        ##
##------------------------------------------------------------------------##
##                                                                        ##
##  $(eval $(call PACKZX7B,<packname>,<dest_path>))                       ##
##                                                                        ##
##		Compresses all files in the <packname> group using ZX7B algorithm ##
## and generates 2 files: <packname>.c and <packname>.h that contain a    ##
## C-array with the compressed data and a header file for declarations.   ##
## Generated files are moved to the folder <dest_path>.                   ##
##                                                                        ##
##  Parameters:                                                           ##
##  (packname) : Name of the compressed group to use for packing          ##
##  (dest_path): Destination path for generated output files              ##
##                                                                        ##
############################################################################
##                                                                        ##
## Important:                                                             ##
##  * Do NOT separate macro parameters with spaces, blanks or other chars.##
##    ANY character you put into a macro parameter will be passed to the  ##
##    macro. Therefore ...,src/sprites,... will represent "src/sprites"   ##
##    folder, whereas ...,  src/sprites,... means "  src/sprites" folder. ##
##  * You can omit parameters by leaving them empty.                      ##
##  * Parameters (4) and (5) are optional and generally not required.     ##
############################################################################
