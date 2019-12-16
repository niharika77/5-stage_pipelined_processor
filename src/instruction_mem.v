module instruction_mem(
                    input [15:0] address, 
                    input clk,
                    input [1:0] test,
                    output [15:0] instruction
                    );


reg [15:0] code_mem [127:0];

always @(*)
	begin 
	//fibonacci
	if (test == 2'b00)
	 begin
	        // MOVS R0, 0
          code_mem[0] = 16'b0010000000000000;
          // MOV R3, R0
          code_mem[1] = 16'b0100011000000011;
          // MOVS R1, 1
          code_mem[2] = 16'b0010000100000001;
          // MOV R3, R1
          code_mem[3] = 16'b0100011000001011;
          // LOOP: ADDS R2, R1, R0
          code_mem[4] = 16'b0001100000001010;
          // MOV R3, R2
          code_mem[5] = 16'b0100011000010011;
          // ADDS R0, R2, R1
          code_mem[6] = 16'b0001100001010000;
          // MOV R3, R0
          code_mem[7] = 16'b0100011000000011;
          // ADDS R1, R2, R0
          code_mem[8] = 16'b0001100000010001;
          // MOV R3, R1
          code_mem[9] = 16'b0100011000001011;
          // B LOOP
          code_mem[10] = 16'b1110011111111001;
          // NOOP
          code_mem[11] = 16'b1011111100000000;
      end
    
    if(test == 2'b01)
     begin


	//gcd
	         // MOVS R0, 6
           code_mem[0] = 16'b0010000000000110;
           // MOVS R1, 2
           code_mem[1] = 16'b0010000100000010;
           // MOVS R2, 1
           code_mem[2] = 16'b0010001000000001;
           // MOVS R3, 0
           code_mem[3] = 16'b0010001100000000;
           // WHILE: CMP R2, R3
           code_mem[4] = 16'b0100001010011010;
           // BEQ EXIT
           code_mem[5] = 16'b1101000000010010;
           // NOOP
           code_mem[6] = 16'b1011111100000000;
           // CMP R0, R1
           code_mem[7] = 16'b0100001010001000;
           // BLT LOOP1
           code_mem[8] = 16'b1101101100000111;
           // NOOP
           code_mem[9] = 16'b1011111100000000;
           // CMP R1, R3
           code_mem[10] = 16'b0100001010011001;
           // BNE LOOP2
           code_mem[11] = 16'b1101000100001001;
           // NOOP
           code_mem[12] = 16'b1011111100000000;
           // MOVS R2, 0
           code_mem[13] = 16'b0010001000000000;
           // B WHILE
           code_mem[14] = 16'b1110011111110101;
           //NOOP
           code_mem[15] = 16'b1011111100000000;
           // LOOP1: MOV R4, R0
           code_mem[16] = 16'b0100011000000100;
           // MOV R0, R1
           code_mem[17] = 16'b0100011000001000;
           // MOV R1, R4
           code_mem[18] = 16'b0100011000100001;
           // B WHILE
           code_mem[19] = 16'b1110011111110000;
           // NOOP
           code_mem[20] = 16'b1011111100000000;
           // LOOP2: SUBS R0, R0, R1
           code_mem[21] = 16'b0001101001000000;
           // B WHILE
           code_mem[22] = 16'b1110011111101101;
           // NOOP
           code_mem[23] = 16'b1011111100000000;
           // EXIT: MOV R5, R0
           code_mem[24] = 16'b0100011000000101;
           // B END
           code_mem[25] = 16'b1110000000000001;
           // NOOP
           code_mem[26] = 16'b1011111100000000;
           // END: NOOP
           code_mem[27] = 16'b1011111100000000;
       end
       
   if (test == 2'b10)
     begin    


            // MOVS R6, 9
            code_mem[0] = 16'b0010011000001001;
            // MOVS R2, 0
            code_mem[1] = 16'b0010001000000000;
            // LOOP: CMP R6, R2
            code_mem[2] = 16'b0100001010010110;
            // BLT LOOP1
            code_mem[3] = 16'b1101101100000101;
            // NOOP
            code_mem[4] = 16'b1011111100000000;
            // STR R6, [R6, 0]
            code_mem[5] = 16'b0110000000110110;
            // SUBS R6, R6, 1
            code_mem[6] = 16'b0001111001110110;
            // B LOOP
            code_mem[7] = 16'b1110011111111010;
            // NOOP
            code_mem[8] = 16'b1011111100000000;
            // LOOP1: MOVS R0, 9
            code_mem[9] = 16'b0010000000001001;
            // MOVS R1, 0
            code_mem[10] = 16'b0010000100000000;
            // MOVS R2, 0
            code_mem[11] = 16'b0010001000000000;
            // WHILE: CMP R0, R2
            code_mem[12] = 16'b0100001010010000;
            // BLT EXIT
            code_mem[13] = 16'b1101101100000111;
            // NOOP
            code_mem[14] = 16'b1011111100000000;
            // LDR R3, [R0, 0]
            code_mem[15] = 16'b0110100000000011;
            // NOOP
            code_mem[16] = 16'b1011111100000000;
            // ADDS R1, R1, R3
            code_mem[17] = 16'b0001100011001001;
            // SUBS R0, R0, 1
            code_mem[18] = 16'b0001111001000000;
            // B WHILE
            code_mem[19] = 16'b1110011111111000;
            // NOOP
            code_mem[20] = 16'b1011111100000000;
            // EXIT: NOOP
            code_mem[21] = 16'b1011111100000000;
	end
end

assign instruction = code_mem[address];


endmodule



