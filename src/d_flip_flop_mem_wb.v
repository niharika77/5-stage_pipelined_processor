`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.04.2019 10:23:44
// Design Name: 
// Module Name: d_flip_flop_mem_wb
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


module d_flip_flop_mem_wb(
                          input clk,
                          input reset,
                          input [1:0] write_back_r,
                          input [15:0] link_pc_r,
                          input [3:0] write_address_r,
                          input [15:0] ALU_output_r,
                          input [15:0] shift_output_r,
                          input [15:0] read_data_memory_r,
                          input RegWrite_r,
                          
                          output reg [1:0] write_back_n,
                          output reg [15:0] link_pc_n,
                          output reg [3:0] write_address_n,
                          output reg [15:0] ALU_output_n,
                          output reg [15:0] shift_output_n,
                          output reg [15:0] read_data_memory_n,
                          output reg RegWrite_n
                          );
                          
always @(posedge clk)
 begin
  if (reset == 1'b1)
   begin
    write_back_n <= 2'b00;
    link_pc_n <= 16'h0000;
    write_address_n <= 4'b0000;
    ALU_output_n <= 16'h0000;
    shift_output_n <= 16'h0000;
    read_data_memory_n <= 16'h0000;
    RegWrite_n <= 1'b0;
   end
  else 
   begin
    write_back_n <= write_back_r;
    link_pc_n <= link_pc_r;
    write_address_n <= write_address_r; 
    ALU_output_n <= ALU_output_r;
    shift_output_n <= shift_output_r; 
    read_data_memory_n <= read_data_memory_r;
    RegWrite_n <= RegWrite_r;  
   end
 end                         
                          
                          
                          
                          
                          
                          
                          
                          
endmodule
