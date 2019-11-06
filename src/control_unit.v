`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.04.2019 17:33:35
// Design Name: 
// Module Name: control_unit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module control_unit(
                   input reset,
                   input [15:0] instruction,
                   output reg [1:0] Reg1Loc,
                   output reg [2:0] Reg2Loc,
                   output reg [1:0] write_reg,
                   output reg cmp_sel,
                   output reg [1:0] immediate_sel,
                   output reg RegWrite,
                   output reg ALUsrc,
                   output reg [1:0] shift_type,
                   output reg [2:0] ALUop,
                   output reg [3:0] conditions,
                   output reg mem_read,
                   output reg mem_write,
                   output reg [1:0] write_back,
                   output reg cond_branch,
                   output reg uncond_branch,
                   output reg link_branch,
                   output reg reg_branch,
                   output reg [1:0] branch_type,
                   output reg alu_shift              
                   );
                   
//Reg1Loc block
always @(*)
 begin
 if (reset == 1'b1)
  begin
   Reg1Loc = 2'b00;
  end
 else
  begin
     if (instruction == 16'b1011111100000000)
      Reg1Loc = 2'bxx;
     else
      begin
          casez(instruction[15:11])
           5'b00011: Reg1Loc = 2'b00;   //00 = instr[5:3]
           5'b01100: Reg1Loc = 2'b00;
           5'b01101: Reg1Loc = 2'b00;
           5'b01000: Reg1Loc = 2'b01;   //01 = instr[2:0]
           5'b10110: Reg1Loc = 2'b10;   //10 = SP
           default:  Reg1Loc = 2'b11;   
          endcase
       end
   end
 end                   

//Reg2Loc block
always @(*)
 begin
  if (reset == 1'b1)
   begin
    Reg2Loc = 3'b000;
   end
  else
   begin
      if (instruction == 16'b1011111100000000)
       Reg2Loc = 3'bxxx;
      else
       begin
          if(instruction[15:10] == 6'b010001)
           Reg2Loc = 3'b000;   //00 = instr[6:3]
          else if(instruction[15:10] == 6'b000110)
           Reg2Loc = 3'b001;   //01 = instr[8:6]
          else if(instruction[15:10] == 6'b010000)
           Reg2Loc = 3'b010;   //10 = instr[5:3]
          else if(instruction[15:12] == 4'b0110)
           Reg2Loc = 3'b011;
          else
           Reg2Loc = 3'b100;
       end
   end
 end     
 
//write_reg block 
always @(*)
 begin
  if (reset == 1'b1)
   begin
    write_reg = 2'b00;
   end
  else
   begin
      if (instruction == 16'b1011111100000000)
       write_reg = 2'bxx;
      else
       begin
          casez(instruction[15:11])
           5'b01000: begin
                      if(instruction[10:9] == 2'b10)
                       write_reg = 2'b10;  //10 = link_register [R14]
                      else
                       write_reg = 2'b00;  //00 = instr[2:0]
                     end  
           5'b00011: write_reg = 2'b00;
           5'b01101: write_reg = 2'b00;
           5'b01100: write_reg = 2'b00;
           5'b00100: write_reg = 2'b01;    //01 = instr[10:8]
           5'b10110: write_reg = 2'b11;    //11 = SP
           default:  write_reg = 2'b00;
          endcase
       end
   end
  end

//cmp_sel block
always @(*)
 begin
  if (reset == 1'b1)
   begin
    cmp_sel = 1'b0;
   end
  else 
  begin
      if (instruction == 16'b1011111100000000)
       cmp_sel = 1'bx;
      else
       begin
        if(instruction[15:6] == 10'b0100001010)
         cmp_sel = 1'b1;
        else
         cmp_sel = 1'b0;
       end
  end
 end
 
//RegWrite block
always @(*)
 begin
  if (reset == 1'b1)
   begin
    RegWrite = 1'b0;
   end
  else
   begin
     if (instruction == 16'b1011111100000000)
      RegWrite = 1'bx;
     else
      begin
       if ((instruction[15:11] == 5'b01100) | (instruction[15:12] == 4'b1101) | (instruction[15:12] == 4'b1110) | (instruction[15:7] == 9'b010001110))
        RegWrite = 1'b0;         //store, cond_branch, uncond_branch or register branch: no writing to register file is taking place
       else
        RegWrite = 1'b1;
      end
  end
 end
 
//immediate_sel block
always @(*)
 begin
  if (reset == 1'b1)
   begin
    immediate_sel = 2'b00;
   end
  else
   begin
      if (instruction == 16'b1011111100000000)
       immediate_sel = 2'bxx;
      else
       begin 
        case(instruction[15:12])
         4'b0010: immediate_sel = 2'b00;    //00 = instr[7:0]
         4'b0001: immediate_sel = 2'b01;    //01 = instr[8:6]
         4'b1011: immediate_sel = 2'b10;    //10 = instr[6:0]
         4'b0110: immediate_sel = 2'b11;    //11 = instr[10:6]
         default: immediate_sel = 2'b00;
        endcase
       end
    end
 end

//ALUsrc block
always @(*)
 begin
  if (reset == 1'b1)
   begin
    ALUsrc = 1'b0;
   end
  else
   begin
     if (instruction == 16'b1011111100000000)
      ALUsrc = 1'bx;
     else
      begin
        if ((instruction[15:12] == 4'b0010) | (instruction[15:10] == 6'b000111) | (instruction[15:12] == 4'b1011) | (instruction[15:12] == 4'b0110))
         begin
          ALUsrc = 1'b1;    //anytime if its an immediate that needs to go ahead in ALU
         end
        else
         begin
          ALUsrc = 1'b0;    //when value in the register Rm needs to go to the ALU
         end
      end 
   end
 end

//ALUop block
always @(*)
 begin
  if (reset == 1'b1)
   begin
    ALUop = 3'b000;
   end
  else
   begin
      if(instruction == 16'b1011111100000000)
       ALUop = 3'bxxx;
      else
       begin
        if ((instruction[15:9] == 7'b0001110) | (instruction[15:9] == 7'b0001100) | (instruction[15:7] == 9'b101100000) | (instruction[15:11] == 5'b01100) | (instruction[15:11] == 5'b01101)) 
         ALUop = 3'b000;   //ADD
        else if((instruction[15:9] == 7'b0001101) | (instruction[15:9] == 7'b0001111) | (instruction[15:7] == 9'b101100001) | (instruction[15:7] == 9'b010000101))
         ALUop = 3'b001;    //SUB
        else if(instruction[15:6] == 10'b0100000000)
         ALUop = 3'b010;   //AND
        else if(instruction[15:6] == 10'b0100001100)
         ALUop = 3'b011;   //OR
        else if(instruction[15:6] == 10'b0100000001)
         ALUop = 3'b100;   //XOR
        else if(instruction[15:6] == 10'b0100001111)
         ALUop = 3'b101;   //NOT
        else 
         ALUop = 3'b110;   //SAME
       end
   end
 end 

//shift_type block
always @(*)
 begin
  if (reset == 1'b1)
   begin
    shift_type = 2'b00;
   end
  else
   begin
      if(instruction == 16'b1011111100000000)
       shift_type = 2'bxx;
      else
       begin
        case(instruction[15:6])
         10'b0100000010: shift_type = 2'b00;  //00 = LSL
         10'b0100000011: shift_type = 2'b01;  //01 = LSR
         10'b0100000100: shift_type = 2'b10;  //10 = ASR
         10'b0100000111: shift_type = 2'b11;  //11 = ROR
         default:        shift_type = 2'b00;
        endcase
       end
   end
 end                  

//mem_read block
always @(*)
 begin
  if (reset == 1'b1)
   begin
    mem_read = 1'b0;
   end
  else
   begin
      if(instruction == 16'b1011111100000000)
       mem_read = 1'bx;
      else
       begin
        if(instruction[15:11] == 5'b01101)
         mem_read = 1'b1;
        else
         mem_read = 1'b0;          
       end     
   end  
 end

//mem_write block
always @(*)
 begin
  if (reset == 1'b1)
   begin
    mem_write = 1'b0;
   end
  else
   begin
      if(instruction == 16'b1011111100000000)
       mem_write = 1'bx;
      else
       begin
        if(instruction[15:11] == 5'b01100)
         mem_write = 1'b1;
        else
         mem_write = 1'b0;          
       end 
   end      
 end                  

//write_back block
always @(*)
 begin
  if (reset == 1'b1)
   begin
    write_back = 2'b00;
   end
  else
   begin
      if(instruction == 16'b1011111100000000)
       write_back = 2'bxx;
      else
        begin
          if(instruction[15:11] == 5'b01101)    //data from memory
           write_back = 2'b00;
          else if(instruction[15:6] == 10'b0100010100)
           write_back = 2'b11;                    //from link register
          else if((instruction[15:6] == 10'b0100000010) | (instruction[15:6] == 10'b0100000011) | (instruction[15:6] == 10'b0100000100) | (instruction[15:6] == 10'b0100000111))
           write_back = 2'b10;                //from shifter
          else
           write_back = 2'b01;              //from ALU
        end
   end
 end                  


//cond_branch block
always @(*)
 begin
  if (reset == 1'b1)
   begin
    cond_branch = 1'b0;
   end
  else
   begin
      if(instruction == 16'b1011111100000000)
       cond_branch = 1'b0;
      else
       begin
        if(instruction[15:12] == 4'b1101)
         cond_branch = 1'b1;
        else
         cond_branch = 1'b0;
       end
   end
 end
 
//uncond_branch block
 always @(*)
  begin
   if (reset == 1'b1)
    begin
     uncond_branch = 1'b0;
    end
   else
    begin
       if(instruction == 16'b1011111100000000)
        uncond_branch = 1'b0;
       else
        begin
         if(instruction[15:12] == 4'b1110)
          uncond_branch = 1'b1;
         else
          uncond_branch = 1'b0;
        end
    end
  end
 
//link_branch block
always @(*)
 begin
  if (reset == 1'b1)
   begin
    link_branch = 1'b0;
   end
  else
   begin
      if(instruction == 16'b1011111100000000)
       link_branch = 1'b0;
      else
       begin
        if(instruction[15:6] == 10'b0100010100)
         link_branch = 1'b1;
        else
         link_branch = 1'b0;
       end
    end
 end 

//reg_branch block
always @(*)
 begin
  if (reset == 1'b1)
   begin
    reg_branch = 1'b0;
   end
  else
   begin
      if(instruction == 16'b1011111100000000)
       reg_branch = 1'b0;
      else
       begin
        if(instruction[15:7] == 9'b010001110)
         reg_branch = 1'b1;
        else
         reg_branch = 1'b0;
       end
    end
 end 
 
//branch_type block
//cond_branch block
always @(*)
 begin
  if (reset == 1'b1)
   begin
    branch_type = 2'b00;
   end
  else
   begin
      if(instruction == 16'b1011111100000000)
       branch_type = 2'b00;    //i am confused between x and 0
      else
       begin
        if(instruction[15:12] == 4'b1101)
         branch_type = 2'b00;
        else if(instruction[15:12] == 4'b1110)
         branch_type = 2'b01;
        else if(instruction[15:6] == 10'b0100010100)
         branch_type =  2'b10;
        else if(instruction[15:7] == 9'b010001110)
         branch_type = 2'b11;
        else 
         branch_type = 2'b00;
       end
   end
 end
 
//conditions block
always @(*)
 begin
  if (reset == 1'b1)
   begin
    conditions = 4'b0000;
   end
  else
   begin
      if(instruction == 16'b1011111100000000)
       conditions = 4'b1111;    //i am confused between xxxx and 0000
      else
       begin
        if(instruction[15:12] == 4'b1101)
         conditions = instruction[11:8];
        else
         conditions = 4'b1111;    //will go to default case
       end
   end
 end
 
 always @(*)
  begin
   if(instruction == 16'b1011111100000000)
    alu_shift = 1'b0;
   else 
    begin
     if((instruction[15:6] == 10'b0100000010) && (instruction[15:6] == 10'b0100000011) && (instruction[15:6] == 10'b0100000100) && (instruction[15:6] == 10'b0100000111))
      alu_shift = 1'b1;
     else
      alu_shift = 1'b0;
    end
   end
 
 endmodule