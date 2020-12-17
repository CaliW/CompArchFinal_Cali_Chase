######################################################################
# 			     Move Square!!!!                         #
######################################################################
#           Programmed by Chase J and Cali W using code from 	     #
#	    Shane Shafferman and Eric Deas                           #
######################################################################
#	This program requires the Keyboard and Display MMIO          #
#       and the Bitmap Display to be connected to MIPS.              #
#								     #
#       Bitmap Display Settings:                                     #
#	Unit Width: 8						     #
#	Unit Height: 8						     #
#	Display Width: 512					     #
#	Display Height: 512					     #
#	Base Address for Display: 0x10008000 ($gp)		     #
######################################################################

.data

#Game Core information

#Screen 
screenWidth: 	.word 64
screenHeight: 	.word 64

#Colors
squareColor: 	.word	0x0066cc	 # blue
backgroundColor:.word	0x000000	 # black
borderColor:    .word	0x00ff00	 # green	

#speed the square moves at, increases as game progresses
gameSpeed:	.word 200
#array to store the scores in which difficulty should increase

#end game message
lostMessage:	.asciiz "You have died"
replayMessage:	.asciiz "Would you like to replay?"

#Square Information
squareX: 	.word 31
squareY:	.word 31
direction:	.word 119 #initially moving up

# direction variable
# 119 - moving up - W
# 115 - moving down - S
# 97 - moving left - A
# 100 - moving right - D
# numbers are selected due to ASCII characters

.text

Main:
######################################################
# Fill Screen to Black, for reset
######################################################
	lw $a0, screenWidth
	lw $a1, backgroundColor
	mul $a2, $a0, $a0 #total number of pixels on screen
	mul $a2, $a2, 4 #align addresses
	add $a2, $a2, $gp #add base of gp
	add $a0, $gp, $zero #loop counter
FillLoop:
	beq $a0, $a2, Init
	sw $a1, 0($a0) #store color
	addiu $a0, $a0, 4 #increment counter
	j FillLoop

######################################################
# Initialize Variables
######################################################
Init:

	li $t0, 31
	sw $t0, squareX
	sw $t0, squareY
	li $t0, 119
	sw $t0, direction
	li $t0, 200
	sw $t0, gameSpeed
	
ClearRegisters:

	li $v0, 0
	li $a0, 0
	li $a1, 0
	li $a2, 0
	li $a3, 0
	li $t0, 0
	li $t1, 0
	li $t2, 0
	li $t3, 0
	li $t4, 0
	li $t5, 0
	li $t6, 0
	li $t7, 0
	li $t8, 0
	li $t9, 0
	li $s0, 0
	li $s1, 0
	li $s2, 0
	li $s3, 0
	li $s4, 0		

######################################################
# Draw Border
######################################################

DrawBorder:
	li $t1, 0	#load Y coordinate for the left border
	LeftLoop:
	move $a1, $t1	#move y coordinate into $a1
	li $a0, 0	# load x direction to 0, doesnt change
	jal CoordinateToAddress	#get screen coordinates
	move $a0, $v0	# move screen coordinates into $a0
	lw $a1, borderColor	#move color code into $a1
	jal DrawPixel	#draw the color at the screen location
	add $t1, $t1, 1	#increment y coordinate
	
	bne $t1, 64, LeftLoop	#loop through to draw entire left border
	
	li $t1, 0	#load Y coordinate for right border
	RightLoop:
	move $a1, $t1	#move y coordinate into $a1
	li $a0, 63	#set x coordinate to 63 (right side of screen)
	jal CoordinateToAddress	#convert to screen coordinates
	move $a0, $v0	# move coordinates into $a0
	lw $a1, borderColor	#move color data into $a1
	jal DrawPixel	#draw color at screen coordinates
	add $t1, $t1, 1	#increment y coordinate
	
	bne $t1, 64, RightLoop	#loop through to draw entire right border
	
	li $t1, 0	#load X coordinate for top border
	TopLoop:
	move $a0, $t1	# move x coordinate into $a0
	li $a1, 0	# set y coordinate to zero for top of screen
	jal CoordinateToAddress	#get screen coordinate
	move $a0, $v0	#  move screen coordinates to $a0
	lw $a1, borderColor	# store color data to $a1
	jal DrawPixel	#draw color at screen coordinates
	add $t1, $t1, 1 #increment X position
	
	bne $t1, 64, TopLoop #loop through to draw entire top border
	
	li $t1, 0	#load X coordinate for bottom border
	BottomLoop:
	move $a0, $t1	# move x coordinate to $a0
	li $a1, 63	# load Y coordinate for bottom of screen
	jal CoordinateToAddress	#get screen coordinates
	move $a0, $v0	#move screen coordinates to $a0
	lw $a1, borderColor	#put color data into $a1
	jal DrawPixel	#draw color at screen position
	add $t1, $t1, 1	#increment X coordinate
	
	bne $t1, 64, BottomLoop	# loop through to draw entire bottom border
	
######################################################
# Draw Initial Square Position
######################################################
	#draw square
	lw $a0, squareX #load x coordinate
	lw $a1, squareY #load y coordinate
	jal CoordinateToAddress #get screen coordinates
	move $a0, $v0 #copy coordinates to $a0
	lw $a1, squareColor #store color into $a1
	jal DrawPixel	#draw color at pixel
	
	
######################################################
# Check for Direction Change
######################################################

InputCheck:
	lw $a0, gameSpeed
	jal Pause

#get the coordinates for direction change if needed
	lw $a0, squareX
	lw $a1, squareY
	jal CoordinateToAddress
	add $a2, $v0, $zero

	#get the input from the keyboard
	li $t0, 0xffff0000
	lw $t1, ($t0)
	andi $t1, $t1, 0x0001
	beqz $t1, SelectDrawDirection #if no new input, draw in same direction
	lw $a1, 4($t0) #store direction based on input

DirectionCheck:
	beqz $v0, InputCheck	#if input is not valid, get new input
	sw $a1, direction	#store the new direction if valid
	lw $t7, direction	#store the direction into $t7

######################################################
# Update Square position
######################################################	
			
SelectDrawDirection:
	#check to see which direction to draw
	beq $t7, 119, DrawUpLoop
	beq  $t7, 115, DrawDownLoop
	beq  $t7, 97, DrawLeftLoop
	beq  $t7, 100, DrawRightLoop
	#jump back to get input if an unsupported key was pressed
	j InputCheck
	
DrawUpLoop:
	#check for collision before moving to next pixel
	lw $a0, squareX
	lw $a1, squareY
	lw $a2, direction
	jal CheckGameEndingCollision 
	#draw square in new position, move Y position up
	lw $t0, squareX
	lw $t1, squareY
	addiu $t1, $t1, -1
	add $a0, $t0, $zero
	add $a1, $t1, $zero
	jal CoordinateToAddress
	add $a0, $v0, $zero
	lw $a1, squareColor
	jal DrawPixel
	# delete old square
	lw $t0, squareX
	lw $t1, squareY
	add $a0, $t0, $zero
	add $a1, $t1, $zero
	jal CoordinateToAddress
	add $a0, $v0, $zero
	lw $a1, backgroundColor
	jal DrawPixel
	addiu $t1, $t1, -1
	

	sw  $t1, squareY #Update square y-coordinate
	j InputCheck
	
DrawDownLoop:
	#check for collision before moving to next pixel
	lw $a0, squareX
	lw $a1, squareY
	lw $a2, direction	
	jal CheckGameEndingCollision
	
	#draw square in new position, move Y position down
	lw $t0, squareX
	lw $t1, squareY
	addiu $t1, $t1, 1
	add $a0, $t0, $zero
	add $a1, $t1, $zero
	jal CoordinateToAddress
	add $a0, $v0, $zero
	lw $a1, squareColor
	jal DrawPixel
	# delete old square
	lw $t0, squareX
	lw $t1, squareY
	add $a0, $t0, $zero
	add $a1, $t1, $zero
	jal CoordinateToAddress
	add $a0, $v0, $zero
	lw $a1, backgroundColor
	jal DrawPixel
	addiu $t1, $t1, 1
	
	sw  $t1, squareY #Update square y-coordinate
	j InputCheck

DrawLeftLoop:
	#check for collision before moving to next pixel
	lw $a0, squareX
	lw $a1, squareY
	lw $a2, direction	
	jal CheckGameEndingCollision
	#draw square in new position, move X position left
	lw $t0, squareX
	lw $t1, squareY
	addiu $t0, $t0, -1
	add $a0, $t0, $zero
	add $a1, $t1, $zero
	jal CoordinateToAddress
	add $a0, $v0, $zero
	lw $a1, squareColor
	jal DrawPixel
	# delete old square
	lw $t0, squareX
	lw $t1, squareY
	add $a0, $t0, $zero
	add $a1, $t1, $zero
	jal CoordinateToAddress
	add $a0, $v0, $zero
	lw $a1, backgroundColor
	jal DrawPixel
	addiu $t0, $t0, -1
	
	sw  $t1, squareX #Update square y-coordinate
	j InputCheck

DrawRightLoop:
	#check for collision before moving to next pixel
	lw $a0, squareX
	lw $a1, squareY
	lw $a2, direction	
	jal CheckGameEndingCollision
	#draw square in new position, move X position right
	lw $t0, squareX
	lw $t1, squareY
	addiu $t0, $t0, 1
	add $a0, $t0, $zero
	add $a1, $t1, $zero
	jal CoordinateToAddress
	add $a0, $v0, $zero
	lw $a1, squareColor
	jal DrawPixel
	# delete old square
	lw $t0, squareX
	lw $t1, squareY
	add $a0, $t0, $zero
	add $a1, $t1, $zero
	jal CoordinateToAddress
	add $a0, $v0, $zero
	lw $a1, backgroundColor
	jal DrawPixel
	addiu $t0, $t0, 1
	
	sw  $t1, squareX #Update square y-coordinate
	j InputCheck
	

##################################################################
#CoordinatesToAddress Function
# $a0 -> x coordinate
# $a1 -> y coordinate
##################################################################
# returns $v0 -> the address of the coordinates for bitmap display
##################################################################
CoordinateToAddress:
	lw $v0, screenWidth 	#Store screen width into $v0
	mul $v0, $v0, $a1	#multiply by y position
	add $v0, $v0, $a0	#add the x position
	mul $v0, $v0, 4		#multiply by 4
	add $v0, $v0, $gp	#add global pointerfrom bitmap display
	jr $ra			# return $v0

##################################################################
#Draw Function
# $a0 -> Address position to draw at
# $a1 -> Color the pixel should be drawn
##################################################################
# no return value
##################################################################
DrawPixel:
	sw $a1, ($a0) 	#fill the coordinate with specified color
	jr $ra		#return
	

##################################################################
# Pause Function
# $a0 - amount to pause
##################################################################
# no return values
##################################################################
Pause:
	li $v0, 32 #syscall value for sleep
	syscall
	jr $ra
	
##################################################################
# Check Square Collision
# $a0 - squarePositionX
# $a1 - squarePositionY
# $a2 - squareDirection
##################################################################
# returns $v0:
#	0 - does not hit something
#	1 - does hit something
##################################################################	
CheckGameEndingCollision:
	#save square coordinates
	add $s3, $a0, $zero
	add $s4, $a1, $zero
	#save return address
	sw $ra, 0($sp)

	beq  $a2, 119, CheckUp
	beq  $a2, 115, CheckDown
	beq  $a2, 97,  CheckLeft
	beq  $a2, 100, CheckRight
	j BodyCollisionDone #for error?
	
CheckUp:
	#look above the current position
	addiu $a1, $a1, -1
	jal CoordinateToAddress
	#get color at screen address
	lw $t1, 0($v0)
	#add $s6, $t1, $zero
	lw $t2, squareColor
	lw $t3, borderColor
	beq $t1, $t2, Exit #If colors are equal - YOU LOST!
	beq $t1, $t3, Exit #If you hit the border - YOU LOST!
	j BodyCollisionDone # if not, leave function

CheckDown:

	#look below the current position
	addiu $a1, $a1, 1
	jal CoordinateToAddress
	#get color at screen address
	lw $t1, 0($v0)
	#add $s6, $t1, $zero
	lw $t2, squareColor
	lw $t3, borderColor
	beq $t1, $t2, Exit #If colors are equal - YOU LOST!
	beq $t1, $t3, Exit #If you hit the border - YOU LOST!
	j BodyCollisionDone # if not, leave function

CheckLeft:

	#look to the left of the current position
	addiu $a0, $a0, -1
	jal CoordinateToAddress
	#get color at screen address
	lw $t1, 0($v0)
	#add $s6, $t1, $zero
	lw $t2, squareColor
	lw $t3, borderColor
	beq $t1, $t2, Exit #If colors are equal - YOU LOST!
	beq $t1, $t3, Exit #If you hit the border - YOU LOST!
	j BodyCollisionDone # if not, leave function

CheckRight:

	#look to the right of the current position
	addiu $a0, $a0, 1
	jal CoordinateToAddress
	#get color at screen address
	lw $t1, 0($v0)
	#add $s6, $t1, $zero
	lw $t2, squareColor
	lw $t3, borderColor
	beq $t1, $t2, Exit #If colors are equal - YOU LOST!
	beq $t1, $t3, Exit #If you hit the border - YOU LOST!
	j BodyCollisionDone # if not, leave function

BodyCollisionDone:
	lw $ra, 0($sp) #restore return address
	jr $ra		
	

Exit:   
	#play a sound tune to signify game over
	li $v0, 31
	li $a0, 28
	li $a1, 250
	li $a2, 32
	li $a3, 127
	syscall
		
	li $a0, 33
	li $a1, 250
	li $a2, 32
	li $a3, 127
	syscall
	
	li $a0, 47
	li $a1, 1000
	li $a2, 32
	li $a3, 127
	syscall
	
	li $v0, 55 #syscall value for dialog
	la $a0, lostMessage #get message
	li $a1, 0 #get score###~~~### lw $a1, score	#get score
	syscall
	
	li $v0, 50 #syscall for yes/no dialog
	la $a0, replayMessage #get message
	syscall
	
	beqz $a0, Main#jump back to start of program
	#end program
	li $v0, 10
	syscall
