# CompArchFinal_Snake_in_Assembly
Creators: Cali W. & Chase J.

## What did we do
For our final project in Computer Architecture we built and fully explained a snake game using MIPS assembly language in the MARS simulator. Due to the short timeline and a minimal starting understanding of the Assembly programming language, we borrowed heavily from Misto432 and their Assembly-Snake code: [Misto432 Assembly Snake](https://github.com/Misto423/Assembly-Snake). 

We expanded on this code by creating a working moving square game based off the original snake code to help user understanding with a simpler assembly script. This file is currently named alteredOrigSnakeCode2.asm. The original snake game (+ small comment edits) is currently named SnakeGameNoOurs.asm.

We expanded on the documentation of this project by including
- definitions, background terminology, and explanations of what assembly language is and how it's used.
- instructions for setting up a MARS/MIPS environment.
- instructions on how and when to use the MARS Bitmap Display.
	- example code showing rectangle in bitDisplay.
- instructions on how and when to use the MARS Keyboard and Display MMIO Simulator.
- additional resources.
- next steps.

The expanded documentation covers everything we felt was most difficult and most useful when we first tried to understand Assembly and the snake game.

## Why we did this project:
We chose to make a snake game using assembly because we wanted to gain a deeper understanding of how assembly works, what it is used for and gain the unique and educational experience of using low-level programming code for a somewhat large project. Learning Assembly is useful for a variety of reasons:
- Assembly language gives complete control over a system's resources, meaning it's great for improving optimizing speed, performance, and efficiency.
- It gives the programmer a great understanding processor and memory function.
- Assembly makes it possible to manipulate hardware directly, access specialized processor instructions, and address critical perfromance issues.
- Assembly language is typically used for coding device drivers, real-time systems, low-level embedded systems, boot codes, reverse engineering and more.
- Assembly language is as close to the processor as you can get as a programmer and is fascinating as a result.
- Learning Assembly will make you a better software architect.

We also chose to expand our project to incorporate a strong teaching component. As newcomers to Assembly we found there was a steep learning curve to even find what we needed to start the project, let alone make significant progress in the short time we had. Assembly language is cryptic. As a result we decided to document and share our experiences and findings here on github and make and share tutorial videos linked here in an attempt to demystify Assembly language.

## Background Information:
### Languages
Programming languages can be roughly categorized into three categories, High-level programming languages, Assembly language (low-level), and Machine Languages (low-level). 

Machine languages are computer friendly because they have binary form and can be executed directly by a computer. Assembly (what we're using) is one step up from Machine code. 

High-level languages (like Python od C+) are much easier for humans to use and understand due to it's use of variables, functions, and understandable syntax, but it can't be understood by a CPU (central processing unit = the electronic circuitry within a computer that executes instructions that make up a computer program).

Assembly code is any low-level programming language in which there is a very strong correspondence between the instructions in the language and the architecture's machine code instructions (as in a 1:1 assembly statement to machine instruction pairing). It is is one step up from machine code and works directly with the CPU. It's more human readable than machine code because it's a symbolic language and it requires an assembler to convert it into machine code. For our project we used MARS (MIPS Assembler and Runtime Simulator) as our assembler. Basically it takes the names our code defines and uses, and then translates them into computer friendly 1’s and 0’s.

Because Assembly languages have a 1:1 command correspondance with Machine Languages, there are as many different Assembly languages as there are Machine Languages, for example:
- MIPS
- ARM
- DEC
- Intel 8008, 8080 and 8085
- x86
- IBM
and more

### Writing in MIPS Assembly

#### .data vs .text:
An Assembly program can be divided into three sections: .data, .bss, and .text.  
The data section is used for declaring initialized data or constants. This data does not change at runtime. You can declare various constant values, file names, or buffer size, etc. The bss section is used for declaring variables. The text section is used for keeping the actual code.

In this snake code we only use .data and .text. The text section is read-only, it's the meat of the code, and the stuff that actually runs. The text section is loaded into memory only once (no matter how many times the code is run), which reduces memory usage and launch time. The data section is not read only, it initializes, then keeps track of the important variables in the code. The data section contains informations that could be changed during application execution and as a result, this section must be copied for every instance. In this snake game, all the initialized pieces of data in .data are words (.word) or strings (.asciiz).

#### Functions/Procedures/Subroutines:
Procedures are very important in Assembly. Each has a name and does a specific task, and the majority of the Assmebly code is spent either running procedures, or jumping between them once they've completed their job. In this snake code we have procedures that initialize variables, update snake head and tail positions, draw pixels, check direction, loop through motion, exit the game, and more.
```
proc_name:
   procedure body (which can jump to other procedures and back)
   ...
   return value and/or jump to next procedure
```

#### Control Flow Instructions aka Jumping & Branching: 
The line of code being run is controlled by the PC (program counter). Each time a line of code is run the PC is increased by 4 and the next line of code is run. The PC in increased by 4 (and not 1 or 2 or whatever because in MIPS, registers are "words" and words are 32 bits, or 4 bytes. This isn't super important but is interesting to know. 

Jump and Branch commands can be used to jump to any line of code, not just the next line. Jumping simply changes the PC to whatever line you want to run next. Branching only does this if certain conditions have been met. Both will be explained further in the Common Commands section below.

#### How registers work:
The main internal hardware of a PC consists of a processor, memory, and registers. Registers are processor components that hold data and addresses. Reading and writing data into memory is slow when trying to process data(it's a long and complicated process). Registers are pieces of temporary memory built into the processor chip and while there are only a limited number of them, they can store data for processing without having to access memory, thus making everything much faster. MIPS has 32 floating point registers, their names, numbers, uses, and callsigns are listed here [MIPS Green Sheet](https://inst.eecs.berkeley.edu/~cs61c/resources/MIPS_Green_Sheet.pdf), and include registers like $a0, $ra, $t7, $zero, and  more, many of which are used in the snake game to store, use, and compare data.
```
li $a0, 79  #stores 79 into register $a0
beq $a0, $a1, Same #branches to Same procedure if the data stores in $a1 and $a0 is equivalent
addiu $a0, $a0, 1    #adds 1 to the value stored in register $a0
```

#### Commenting: 
Comment code using #

#### Common commands (aka  commands used in snake code):
- li & lw & sw: Load and Save
  - li = load integer
  ```
  li $a0, 79  #stores 79 into register $a0
  ```
  - lw = load word from memory into a register.
  ```
  lw $t5, score  #$t5 = destination register, score is stored in $t5.
  ```
  - sw = save word from a register into RAM.
  ```
  sw $t5, score  #$t5 is the source register, the contents of $t5 is being stored in score.
  ```
- j & jr & jal: Jumping
jumping commands jump to a new line in code instead of running through each line of code in the assembly file once. The jump command loads a new value into the PC (program counter) register, which stores the value of the instruction being executed. 
  - j = jump to immediate: loads an immediate value (either integer or label with associated integer) into the PC register. This immediate value is either a numeric offset or a label (and the assembler converts the label into an offset). 
  ```
  j DrawFruit  #jumps to DrawFruit function
  ```
    - jal = jump and link: Does the same thing as j, but also stores the PC of the next line in the register $ra (aka return address) such that you can return to the same place you left from after completing the instructions at the jump address.
  ```
  jal DrawPixel #jumps to DrawPixel function and saves the return address
  ```
  - jr = jump to register:
  ```
  jr $ra  # jumps to whatever line is stored in the return address registe ($ra)
  ```
- bne & beq & beqz: Branching
  - bne = branch not equal: 
```
bne $t1, 64, LeftLoop #if $t1 != 64, branch to LeftLoop procedure. Else, go to next line (PC increases by 4)
```
  - beq = branch equal:
```
beq $a0, $a1, Same #if $a0 == $a1, branch to Same procedure. Else, go to next line (PC increases by 4)
```
  - beqz = branch to address if variable == 0:
```
beqz $a0, main #jumps to main procedure if $a0 == 0. Else, go to next line (PC increases by 4)
```

- move: Copies the first argument to the first argument
```
move $a1, $t1	#sets $t1 to be the same as $a1
```

- add & addiu & mul (computational commands)
  - add adds, mul multiplies, etc.
  - add and addiu are both addition commands, but add combines two registers while addiu combines a register with an unsigned integer.
  ```
  add $s3, $a0, $zero  #$s3 = $a0 + $zero, this is typically a save command as $zero = 0 and $s3 and $a0 now store the same value.
  addiu $a0, $a0, 1    #$a0 = $a0 + 1, this command adds 1 to $a0.
  ```
- sll: shift left logical. 
  - sll shifts all digits of a binary number left by n spaces. It is a quick way to multply the number by 2^n because of how binary works. 
  - For example b'1010 = 10. If every digit were shifted left 1, the binary number would be b'10100 which equals 20 (which is 10 * 2^1. Likewise if everything were shifted right 1, b'101 = 5 (10 / 2^1).
   ```
  sll $t0, $s0, 2  #multiplies $s0 by 4 (2^2) and writes it to $t0
  ```
  - [More information](https://en.wikipedia.org/wiki/Logical_shift)
- syscall: sycall is a command that can call a number of system services, mainly for input and output purposes. Sycall can be used for many things including  making and using input text boxes, opening files, creating sound effects, outputing random integers, and more.
  - How to use SYSCALL system services
    1. Load the service number in register $v0. (The integer stored in $v0 selects the type of system service to be run)
    2. Load argument values, if any, in $a0, $a1, $a2, or $f12 as specified. (ex. li $a0, 28)
    3. Issue the SYSCALL instruction. (type syscall)
    4. Retrieve return values, if any, from result registers as specified.
  ```
  #play a sound tune to signify game over
	li $v0, 31
	li $a0, 28
	li $a1, 250
	li $a2, 32
	li $a3, 127
	syscall
  ```
  - For more help in using syscall and exploring everything it can be used for, visit this website: [Using Syscall](https://courses.missouristate.edu/KenVollmar/mars/Help/SyscallHelp.html)
- more Assembly commands can be found in the cheat sheet here: [MIPS Green Sheet](https://inst.eecs.berkeley.edu/~cs61c/resources/MIPS_Green_Sheet.pdf)

## How to build environment and use software:
### Environment:
Before you can write and run Assembly code, you need to set up your software environment. We used MARS as our assembler and simulator for MIPS assembly language. To set up MARS on your computer, click the following link and follow the download instructions: [MARS/MIPS Simulator](http://courses.missouristate.edu/KenVollmar/MARS/download.htm). 
Bascially:
- Download Java: To use MARS, you must have Java installed on your computer Instructions in link above)
- Download MARS: The download MARS button is at the top of the page,
- Name file and use command window/terminal: When downloading the MARS jar file, rename the jar file to "Mars.jar" or something similar for convenience. This allows you to run MARS via the command window using the command  java -jar Mars.jar. Or java -jar WhateverINamedMyFile.jar.

MARS is friendly to Windows and Ubuntu (we know this because one of us used Windows, and the other used Ubuntu for the entirety of this project).
No other software packages were needed to run MIPS assembly code, but there are additional packages you can use for displaying code on other devices or exploring MARS/MIPS more. (put links in additional resources section or here?)

### MARS Tools
In this snake game we used 2 of the built-in tools in MARS: the Bitmap Display tool for displaying the snake game, and the Keyboard and Display MMIO Simulator tool for controlling the snake via keybinding. Both of these tools can be accessed and opened via the Tools dropdown menu in the menu bar at the top of the MARS window. (insert image? or reference image? or video? of MARS Tools menu)

#### Bitmap Display
The Bitmap Display tool is used to display graphics using Assembly code in MARS. The bitmap display can only plot pixels that are written to the memory locations  where the display buffer is located. This means that in order to create graphics, you have to actually write the memory locations of the pixels you want to plot using the sw (save word) command.
```
sw $a1, ($a0) 	#fills the coordinate with specified color
```
sw saves a word from a register into RAM, $a1 is the source of the information that will be written in memory, $a0 is the register holding the memory address.
And if there were a number outside the parentheses of $a0: 
```
sw $a1, 5($a0)
```
that number (i.e. 5) would be the offset added to the address register. (Though we didn't need the offset in our project)

Example code for drawing rectangles can be found here: [Rectangle](./rectEx1.asm)

For any assembly code to work properly with the bitmap display, you must manually configure the width, height, and base address settings in the bitmap display window. These settings should be listed and commented in the code as shown below.

```
#       Bitmap Display Settings:                                     
#	Unit Width: 8						     
#	Unit Height: 8						     
#	Display Width: 512					     
#	Display Height: 512					     
#	Base Address for Display: 0x10008000 ($gp)	



screenWidth: 	.word 64
screenHeight: 	.word 64
snakeColor: 	.word	0x0066cc	 # blue
backgroundColor:.word	0x000000	 # black
borderColor:    .word	0x00ff00	 # green

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
```

The uncommented portion of this code, initiates the settings for anything that will appear on the bitmap display before the game begins. The fillLoop procedure stores the initial bit colors for the entire screen before the game starts.

Additionally, the register $gp is a global pointer that points into the middle of a 64K block of memory that holds your constants and global variables. The objects can be quickly accessed with a single load or store instruction.

For the bitmap display to work you must first click the Connect to MIPS button before clicking the play button in MARS.

#### MMIO keybinding
The Keyboard and Display MMIO Simulator tool is used to allow users to contol graphics via keybinding. In MIPS, some keys are already bound to a number due to it alining with ASCII characters.

Code:
```
# direction variable
# 119 - moving up - W
# 115 - moving down - S
# 97 - moving left - A
# 100 - moving right - D
# numbers are selected due to ASCII characters

InputCheck:
	lw $a0, gameSpeed
	jal Pause

#get the coordinates for direction change if needed
	lw $a0, snakeHeadX
	lw $a1, snakeHeadY
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
```
```
SelectDrawDirection:
	#check to see which direction to draw
	beq $t7, 119, DrawUpLoop
	beq  $t7, 115, DrawDownLoop
	beq  $t7, 97, DrawLeftLoop
	beq  $t7, 100, DrawRightLoop
	#jump back to get input if an unsupported key was pressed
	j InputCheck
```
Once you know what keys you want to bind, it is a matter of having the code recognize when and what keys are pressed. The integer ascii integer associated with the key pressed is loaded to the register $t0 in the line of code: li $t0, 0xffff0000. If the new direction entered is different than the previous one, the code will not branch to SelectDrawDirection (beqz $t1, SelectDrawDirection) and will continue by storing the direction value input from the keyboard into register $a1, then $t7. If the value of the direction hasn't been changed, SelectDrawDirection will run and the contents of register $t7 will be compared to the four direction integers, 119,115, 97, 100, to determine which direction, if any, the square should move.

## Understanding the code: 
This is a full archtectural diagram of the simplified moving square code to help with understanding Assembly logic:
[Code Architecture Diagram](./Code_Architecture_Diagram.jpg)

## Where to find more information (additional resources we found useful):
- [Bitmap Display](https://www.chegg.com/homework-help/questions-and-answers/mips-assembly-language-using-mars-drawing-bitmap-display-requires-first-item-data-section--q56523687)
- [Using Syscall](https://courses.missouristate.edu/KenVollmar/mars/Help/SyscallHelp.html)
- [MARS/MIPS tutorial](https://bytes.usc.edu/files/ee109/documents/MARS_Tutorial.pdf)
- [Assembly tutorial website](https://www.tutorialspoint.com/assembly_programming/index.htm)
- [MIPS Green Sheet](https://inst.eecs.berkeley.edu/~cs61c/resources/MIPS_Green_Sheet.pdf)

## Code next steps:
- Write code that prevents fruit from spawning inside snake.
- Play snake game on another device using additional software packages.
- Add a points counter.
- Fix code such that clicking a unbounded key (not w,a,s,d) does not interrupt gameplay.
