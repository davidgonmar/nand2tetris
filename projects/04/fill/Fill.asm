// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen
// by writing 'black' in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen by writing
// 'white' in every pixel;
// the screen should remain fully clear as long as no key is pressed.


// init all to 0 (white)
@color
M = 0
@lastcolor
M = 0

(MAINLOOP)

@KEYBOARDREAD // read kbd
0; JMP

(MAINLOOP2)

// if @color != lastcolor -> lastcolor = color, draw
@lastcolor
D = M
@color
D = M - D
@NEEDSTOREDRAW
D; JNE

// else, mainloop
@MAINLOOP
0;JMP

(NEEDSTOREDRAW)
@color
D = M
@lastcolor
M = D
@DRAW
0; JMP


(KEYBOARDREAD) // reads from keyboard, sets color to 
@KBD
D = M
@SETTOBLACK // set to 1s
D; JNE // to blacks if not 0

// else
@color
M = 0 // set color to 0s
@MAINLOOP2 // return
0;JMP

(SETTOBLACK)
@color
M = - 1 // all 1s
@MAINLOOP2 // return
0;JMP



(DRAW) // draws the screen to the contents of @color (RAM[@screen..@keyboard] = @color
// init i <- @screen
@SCREEN
D = A
@i
M = D

(DRAW_LOOP)
@color
D = M
@i // M = i
A = M // M = RAM[i]
M = D // set RAM[i] = @color (white or black)
@i
M = M + 1 // inc i
D = M // d = i (just incd)
// if ended, go to MAINLOOP (ended means i = keyboard)
@KBD // A = address of keyboard( screen + 1)
D = D - A //D = i - addrend; so if D > 0 we ended
@MAINLOOP
D;JGE

// else, continue drawing
@DRAW_LOOP
0;JMP