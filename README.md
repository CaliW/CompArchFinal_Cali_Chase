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

We also chose to expand our project to incorporate a strong teaching component. As newcomers to Assembly we found there was a steep learning curve to even find what we needed to start the project, let alone make significant progress in the short time we had. Assembly language is cryptic. As a result we decided to document and share our experiences and findings here on github and make and share tutorial videos linked here in an attempt to demystify Assembly language.

## Background Terminology:
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

### More Background
Like what? Some other information needed to understand our project better.

## How to build environment and use software:
Before you can write and run Assembly code, you need to set up your software environment. We used MARS as our assembler and simulator for MIPS assembly language. To do that, click the following link and follow the download instructions: [MARS/MIPS Simulator](http://courses.missouristate.edu/KenVollmar/MARS/download.htm). No other software packages were needed to run MIPS assembly code, but there are other packages that exist 
-bitMap display
-MMIO keybinding

## Understanding the code: 
- [Using Syscall](https://courses.missouristate.edu/KenVollmar/mars/Help/SyscallHelp.html)


## Hardships we encountered (and where we explain how to deal with them):

## Video Tutorials:

## Where to find more information (additional resources):

## Code next steps:
