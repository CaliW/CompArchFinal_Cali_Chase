# CompArchFinal_Snake_in_Assembly
Creators: Cali W. & Chase J.

## What did we do
For our final project in Computer Architecture we built and fully explained a snake game using MIPS assembly language in the MARS simulator. Due to the short timeline and a minimal starting understanding of the Assembly programming language, we borrowed heavily from Misto432 and their Assembly-Snake code: [Misto432 Assembly Snake](https://github.com/Misto423/Assembly-Snake). 

We expanded on this code by...

We expanded on the documentaion of this project by including
- definitions, background terminology, and explanations of what assembly language is and how it's used.
- instructions for setting up a MARS/MIPS environment.
- instructions on how and when to use the MARS Bitmap Display.
- instructions on how and when to use the MARS Keyboard and Display MMIO Simulator.
- explanations of hardships we encountered while learning how to make a game in a low-level programming language.
- video tutorials.
- additional resources.
- next steps.

## Why we did this project:
We chose to make a snake game using assembly because we wanted to gain a deeper understanding of how assembly works, what it is used for and gain the unique and educational experience of using low-level programming code for a somewhat large project. Learning Assembly is useful for a variety of reasons:
- Assembly language gives complete control over a system's resources, meaning it's great for improving optimizing speed, performance, and efficiency.
- It gives the programmer a great understanding processor and memory function.
- Assembly makes it possible to manipulate hardware directly, access specialized processor instructions, and address critical perfromance issues.
- Assembly language is typically used for coding device drivers, real-time systems, low-level embedded systems, boot codes, reverse engineering and more.
- Assembly language is as close to the processor as you can get as a programmer and is fascinating as a result.
- Learning Assembly will make you a better software architect.

We also chose to expand our project to incorporate a strong teaching component. As newcomers to Assembly we found there was a steep learning curve to even find what we needed to start the project, let alone make significant progress in the short time we had. Assembly language is cryptic. As a result we decided to document and share our experiences and findings here on github and make and share tutorial videos linked here in an attempt to demystify Assembly language.

## Background Infromation:
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

#### Functions:

#### Control Flow Instructions aka Jumping & Branching: 
The line of code being run is controlled by the PC (program counter). Each time a line of code is run the PC is increased by 4 and the next line of code is run. The PC in increased by 4 (and not 1 or 2 or whatever because in MIPS, registers are "words" and words are 32 bits, or 4 bytes. This isn't super important but is interesting to know. 

Jump and Branch commands can be used to jump to any line of code, not just the next line. Jumping simply changes the PC to whatever line you want to run next. Branching only does this if certain conditions have been met. Both will be explained further in the Common Commands section below.

#### How registers work:

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
  sw $t5, score  #$t5 is the source regster, the contents of $t5 is being stored in score.
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
```
bne $t1, 64, LeftLoop
```
```
beq $a0, $a1, Same
```
```
beqz $a0, main#jump back to start of program
```

- move: 

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
- more Assembly commands can be found in the cheat sheet here: [MIPS Green Sheet](https://inst.eecs.berkeley.edu/~cs61c/resources/MIPS_Green_Sheet.pdf)

## How to build environment and use software:
### Environment:
Before you can write and run Assembly code, you need to set up your software environment. We used MARS as our assembler and simulator for MIPS assembly language. To set up MARS on your computer, click the following link and follow the download instructions: [MARS/MIPS Simulator](http://courses.missouristate.edu/KenVollmar/MARS/download.htm). Further instruction explain how to run MARS using the command line.
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

Example code for drawing rectangles can be found here:

Here is how you set up the settings for the bitmap display:

For the bitmap display to work you must first click the Connect to MIPS button.

#### MMIO keybinding
The Keyboard and Display MMIO Simulator tool is used to allow users to contol graphics via keybinding.

## Understanding the code: 
- [Using Syscall](https://courses.missouristate.edu/KenVollmar/mars/Help/SyscallHelp.html)


## Hardships we encountered (and where we explain how to deal with them):

## Video Tutorials:

## Where to find more information (additional resources we found useful):
- [Bitmap Display](https://www.chegg.com/homework-help/questions-and-answers/mips-assembly-language-using-mars-drawing-bitmap-display-requires-first-item-data-section--q56523687)
- [Using Syscall](https://courses.missouristate.edu/KenVollmar/mars/Help/SyscallHelp.html)
- [MARS/MIPS tutorial](https://bytes.usc.edu/files/ee109/documents/MARS_Tutorial.pdf)

## Code next steps:
- Write code that prevents fruit from spawning inside snake.
