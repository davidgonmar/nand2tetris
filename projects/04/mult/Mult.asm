// acc = 0; i = R0;
// while i > 0: acc += R1; i--;
// R2 = acc;
@R0
D = M // read R0 to D
@i
M = D // initialize i to D (R0)

@acc
M = 0 // initialize accum to 0

(LOOP)
	@i
	D = M
	@LOOPEND
	D; JEQ // already done if i == 0
	
	@R1
	D = M // D = R1
	@acc
	M = M + D // acc = R1 + acc
	
	@i
	M = M - 1 // decrement M
	
	@LOOP
	0; JMP // jump incond to (LOOP)
	

(LOOPEND)
	//set R2 to acc
	@acc
	D = M // D = acc
	@R2
	M = D

// never reached
(END)
	@END
	0 ; JMP