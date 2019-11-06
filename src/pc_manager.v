`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.01.2019 12:39:47
// Design Name: 
// Module Name: pc_manager
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


module pc_manager(
                  input clk,
                  input reset,
                  input [7:0] cond_address,
                  input [10:0] uncond_address,  
                  input [5:0] link_address,
                  input [15:0] register_data_2,
                  input [1:0] branch_type,  
                  input BrTaken,
                  input reg_branch,
                  output [15:0] link_pc,
                  output [15:0] pc_out
                  );


   wire [15:0] pc, npc;
   assign pc_out = npc;

   pc_update p1(
                .in(pc),  //pc
                .clk(clk),
                .reset(reset),
                .out(npc)  //npc
                 );
                 
   instr_fetch f1(
                  .clk(clk),
                  .reset(reset),
                  .npc(npc),
                  .cond_address(cond_address),
                  .uncond_address(uncond_address),
                  .link_address(link_address),
                  .register_data_2(register_data_2),
                  .branch_type(branch_type), 
                  .BrTaken(BrTaken),
                  .reg_branch(reg_branch),
                  .link_pc(link_pc),
                  .pc(pc)
                  );              
                 
                 
endmodule
