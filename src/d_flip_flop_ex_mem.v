//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.04.2019 10:05:09
// Design Name: 
// Module Name: d_flip_flop_ex_mem
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


module d_flip_flop_ex_mem(
                          input clk,
                          input reset,
                          input RegWrite_r,
                          input [15:0] link_pc_r,
                        //wire cond_branch_ex_mem;
                        //wire uncond_branch_ex_mem;
                        //wire reg_branch_ex_mem;
                        //wire link_branch_ex_mem;
                          input mem_read_r,
                          input mem_write_r,
                          input [1:0] write_back_r,
                        //wire cpsr_flag_ex_mem;
                          input [15:0] read_data2_r,
                          input [15:0] ALU_output_r,
                          input [15:0] shift_output_r,
                          input [3:0] write_address_r,
                          input [15:0] data_memory_write_r,
                          
                          output reg RegWrite_n,
                          output reg [15:0] link_pc_n,
                          //wire cond_branch_ex_mem;
                          //wire uncond_branch_ex_mem;
                          //wire reg_branch_ex_mem;
                          //wire link_branch_ex_mem;
                          output reg mem_read_n,
                          output reg mem_write_n,
                          output reg [1:0] write_back_n,
                          //wire cpsr_flag_ex_mem;
                          output reg [15:0] read_data2_n,
                          output reg [15:0] ALU_output_n,
                          output reg [15:0] shift_output_n,
                          output reg [3:0] write_address_n,
                          output reg [15:0] data_memory_write_n
                         );

always @(posedge clk)
 begin
  if (reset == 1'b1)
   begin
    RegWrite_n <= 1'b0;
    link_pc_n <= 16'h0000;
    mem_read_n <= 1'b0;
    mem_write_n <= 1'b0;
    write_back_n <= 2'b00;
    read_data2_n <= 16'h0000;
    ALU_output_n <= 16'h0000;
    shift_output_n <= 16'h0000;
    write_address_n <= 4'b0000;
    data_memory_write_n <= 16'h0000;
   end
  else
   begin
    RegWrite_n <= RegWrite_r;
    link_pc_n <= link_pc_r;
    mem_read_n <= mem_read_r;
    mem_write_n <= mem_write_r;
    write_back_n <= write_back_r;
    read_data2_n <= read_data2_r;
    ALU_output_n <= ALU_output_r;
    shift_output_n <= shift_output_r;
    write_address_n <= write_address_r;
    data_memory_write_n <= data_memory_write_r;
   end
 end
                          
                          
                          
                          
endmodule
