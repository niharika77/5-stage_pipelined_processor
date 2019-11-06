`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.04.2019 16:44:51
// Design Name: 
// Module Name: d_flip_flop_id_ex
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


module d_flip_flop_id_ex(
                         input clk,
                         input reset,
                         input RegWrite_r,
                         input ALUsrc_r,
                         input [1:0] shift_type_r,
                         input [2:0] ALUop_r,
                         input [3:0] conditions_r,
                         input mem_read_r,
                         input mem_write_r,
                         input [1:0] write_back_r,
                         input cond_branch_r,
                         input uncond_branch_r,
                         input link_branch_r,
                         input reg_branch_r,
                         input [1:0] branch_type_r,
                         
                         input [15:0] instruction_r,
                         input [3:0] read_address1_r,
                         input [3:0] read_address2_r,
                         input [3:0] write_address_r,
                         input [15:0] read_data1_r,
                         input [15:0] read_data2_r,
                         input [15:0] immediate_data_r,
                         input [15:0] link_pc_r,
                         input alu_shift_r,
                         
                         output reg RegWrite_n,
                         output reg ALUsrc_n,
                         output reg [1:0] shift_type_n,
                         output reg [2:0] ALUop_n,
                         output reg [3:0] conditions_n,
                         output reg mem_read_n,
                         output reg mem_write_n,
                         output reg [1:0] write_back_n,
                         output reg cond_branch_n,
                         output reg uncond_branch_n,
                         output reg link_branch_n,
                         output reg reg_branch_n,
                         output reg [1:0] branch_type_n,
                         
                         output reg [15:0] instruction_n,
                         output reg [3:0] read_address1_n,
                         output reg [3:0] read_address2_n,
                         output reg [3:0] write_address_n,
                         output reg [15:0] read_data1_n,
                         output reg [15:0] read_data2_n,
                         output reg [15:0] immediate_data_n,
                         output reg [15:0] link_pc_n,
                         output reg alu_shift_n
                         );
                         
 always @(posedge clk)
  begin
   if(reset == 1'b1)
    begin
     RegWrite_n <= 1'b0;
     ALUsrc_n <= 1'b0;
     shift_type_n <= 2'b00;
     ALUop_n <= 3'b000;
     conditions_n <= 4'b0000;
     mem_read_n <= 1'b0;
     mem_write_n <= 1'b0;
     write_back_n <= 2'b00;
     cond_branch_n <= 1'b0;
     uncond_branch_n <= 1'b0;
     link_branch_n <= 1'b0;
     reg_branch_n <= 1'b0;
     branch_type_n <= 2'b00;
    
     instruction_n <= 16'h0000;
     read_address1_n <= 4'b0000;
     read_address2_n <= 4'b0000;
     write_address_n <= 4'b0000;
     read_data1_n <= 16'h0000;
     read_data2_n <= 16'h0000;
     immediate_data_n <= 16'h0000;
     link_pc_n <= 16'h0000; 
     alu_shift_n <= 1'b0;
    end
   else
    begin
     RegWrite_n <= RegWrite_r;
     ALUsrc_n <= ALUsrc_r;
     shift_type_n <= shift_type_r;
     ALUop_n <= ALUop_r;
     conditions_n <= conditions_r;
     mem_read_n <= mem_read_r;
     mem_write_n <= mem_write_r;
     write_back_n <= write_back_r;
     cond_branch_n <= cond_branch_r;
     uncond_branch_n <= uncond_branch_r;
     link_branch_n <= link_branch_r;
     reg_branch_n <= reg_branch_r;
     branch_type_n <= branch_type_r;
   
     instruction_n <= instruction_r;
     read_address1_n <= read_address1_r;
     read_address2_n <= read_address2_r;
     write_address_n <= write_address_r;
     read_data1_n <= read_data1_r;
     read_data2_n <= read_data2_r;
     immediate_data_n <= immediate_data_r;
     link_pc_n <= link_pc_r;
     alu_shift_n <= alu_shift_r;
    end
  end                        
                         
                         
                         
endmodule
