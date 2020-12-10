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
- video tutorials
- additional resources
- next steps

## Why we did this project:
We chose to make a snake game using assembly because we wanted to gain a deeper understanding of how assembly works, what it is used for and gain the unique and educational experience of using low-level programming code for a somewhat large project. Learning Assembly is useful for a variety of reasons:
- Assembly language gives complete control over a system's resources, meaning it's great for improving optimizing speed, performance, and efficiency.
- It gives the programmer a great understanding processor and memory function.
- Assembly makes it possible to manipulate hardware directly, access specialized processor instructions, and address critical perfromance issues.
- Assembly language is typically used for coding device drivers, real-time systems, low-level embedded systems, boot codes, reverse engineering and more.
- Assembly language is as close to the processor as you can get as a programmer and is fascinating as a result.

We also chose to expand our project to incorporate a strong teaching component. As newcomers to assembly we found there was a steep learning curve to even find what we needed to start the project, let alone make significant progress in the short time we had. Assembly language is cryptic. As a result we decided to document and share our experiences and findings here on github and with links to tutorial videos posted to youtube in an attempt to demystify Assembly language.

## Background Terminology:
Assembly code is any low-level programming language in which there is a very strong correspondence between the instructions in the language and the architecture's machine code instructions (as in a 1:1 assembly statement to machine instruction pairing). A low-level programming language is one step up from machine code and works directly with the CPU. Unlike a high-level programming language like Python, Assembly does not have variables or functions, and is far less human friendly. 

Assembly code is translated into executable (usable/runnable) machine code using an assembler. For our project we used MARS (MIPS Assembler and Runtime Simulator) as our assembler. Basically it takes the names our code uses and translates them into computer friendly 1’s and 0’s. 

## How to build environment and use software:
-MARS/MIPS simulator: [MARS/MIPS Simulator](http://courses.missouristate.edu/KenVollmar/MARS/download.htm)
-bitMap display
-MMIO keybinding

## Understanding the code: 
- [Using Syscall](https://courses.missouristate.edu/KenVollmar/mars/Help/SyscallHelp.html)

## Hardships we encountered (and where we explain how to deal with them):

## Video Tutorials:

## Where to find more information (additional resources):

## Code next steps:
