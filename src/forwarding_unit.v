//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.05.2019 11:28:43
// Design Name: 
// Module Name: forwarding_unit
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


module forwarding_unit(
                       input RegWrite_ex_mem,
                       input RegWrite_mem_wb,
                       input [3:0] write_address_ex_mem,
                       input [3:0] write_address_mem_wb,
                       input [3:0] read_address1_id_ex,
                       input [3:0] read_address2_id_ex,
                       input [15:0] instruction_id_ex,
                       
                       output reg [1:0] ForwardA,  //for register1
                       output reg [1:0] ForwardB,   //for register2
                       
                       //to eliminate the situation where store after arithmetic
                       input mem_write_id_ex,
                       output reg select
                       );
                       
always @(*)
 begin
   ForwardA = 2'b00;
   ForwardB = 2'b00;
  
 //data forwarding unit for register 1 values in execute stage
  if ((write_address_ex_mem == read_address1_id_ex) && (RegWrite_ex_mem == 1'b1) && (write_address_ex_mem != 4'b1111) && (instruction_id_ex[15:11] != 5'b01100))
   ForwardA = 2'b01;
  else if((write_address_mem_wb == read_address1_id_ex) && (RegWrite_mem_wb == 1'b1) && (write_address_mem_wb != 4'b1111) && (instruction_id_ex[15:11] != 5'b01100))
   ForwardA = 2'b10;
  else
   ForwardA = 2'b00;
  
 //data forwarding unit for register 2 values in execute stage 
  if ((write_address_ex_mem == read_address2_id_ex) && (RegWrite_ex_mem == 1'b1) && (write_address_ex_mem != 4'b1111) && (instruction_id_ex[15:11] != 5'b01100))
    ForwardB = 2'b01;
   else if((write_address_mem_wb == read_address2_id_ex) && (RegWrite_mem_wb == 1'b1) && (write_address_mem_wb != 4'b1111) && (instruction_id_ex[15:11] != 5'b01100))
    ForwardB = 2'b10;
   else
    ForwardB = 2'b00;  
  
 end                       
                       
                       
always @(*)
 begin
  if ((write_address_ex_mem == read_address2_id_ex) && (mem_write_id_ex == 1'b1))
   select = 1'b1;
  else
   select = 1'b0;
 end                    
                       
                       
                       
                       
endmodule
