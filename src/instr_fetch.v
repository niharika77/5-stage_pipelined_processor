`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.01.2019 13:40:44
// Design Name: 
// Module Name: instr_fetch
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


module instr_fetch(
                   input clk,
                   input reset,
                   input [15:0] npc,
                   input [7:0] cond_address,    //from table1 in ISA
                   input [10:0] uncond_address,  //from table1 in ISA
                   input [5:0] link_address,    //from table1 in ISA
                   input [15:0] register_data_2,
                   input [1:0] branch_type,
               //    input uncondBr, 
                   input BrTaken,
                   input reg_branch,
               //    input [15:0] link_reg,
               //    input link_sel,
                   output [15:0] link_pc,
                   output [15:0] pc
                   );

wire[15:0] npc_if_id;    
//wire [15:0] npc_id_ex;
wire [15:0] extended_cond_address;
wire [15:0] extended_uncond_address;
wire [15:0] extended_link_address;
wire [15:0] branch_address;
//wire [15:0] shifted_address;
wire [15:0] npc1, npc2;
wire [15:0] npc_temp;
wire [15:0] npc_temp_id_ex;
//wire [15:0] npc_temp_ex_mem;
wire carry1, carry2; //carry's from the adders used below

d_flip_flop #(.width(16)) dff3(
                              .write_i(npc),     // write data
                      //        .enable_i(!reset),  
                              .clk_i(clk),
                              .reset_i(reset),
                              .read_o(npc_if_id)
                              );

//d_flip_flop #(.width(16)) dff4(
//                              .write_i(npc_if_id),     // write data
//                      //        .enable_i(!reset),  
//                              .clk_i(clk),
//                              .reset_i(reset),
//                              .read_o(npc_id_ex)
//                              );
                              
//sign_extend #(.width(8)) sign1(
//                               .input_i(cond_address),
//                               .extended_address(extended_cond_address)
//                               );

//sign_extend #(.width(11)) sign2(
//                              .input_i(uncond_address),
//                              .extended_address(extended_uncond_address)
//                                );

//sign_extend #(.width(6)) sign3(
//                              .input_i(link_address),
//                              .extended_address(extended_link_address)
//                                );                                
                                    
mux4x1 #(.width(16)) mux4x1_1
                            (
                             .in1({{8{cond_address[7]}},cond_address}),
                             .in2({{5{uncond_address[10]}},uncond_address}),
                             .in3({{10{link_address[5]}},link_address}),
                             .in4(register_data_2),
                             .sel(branch_type),
                             .out(branch_address)
                              );
     
     
//    shifter shift1(
//                   .value(branch_address),
//                   .direction(1'b0), // 0: left, 1: right
//                   .distance(5'b00010),
//                   .result(shifted_address)
//                   );
                   
adder_16bit add1(      //branched adder
                 .a(branch_address),
                 .b(npc_if_id),  //branch part moved a stage back
                 .cin(1'b0),
                 .s(npc_temp)
               //  .carry(carry1)
                 ); 

////ex/mem stage halt                 
//d_flip_flop #(.width(16)) dff6(
//                               .write_i(npc_temp),     // write data
//                               .clk_i(clk),
//                               .reset_i(reset),
//                               .read_o(npc_temp_ex_mem)
//                               );                 
                 
////id/ex stage halt                 
//d_flip_flop #(.width(16)) dff6(
//                               .write_i(npc_temp),     // write data
//                               .clk_i(clk),
//                               .reset_i(reset),
//                               .read_o(npc_temp_id_ex)
//                               );                 
                 
                                 
                 
 //selecting whether register branch or not
 //if yes, then register value will dirctly go to PC
 //i.e PC = register_data2 
 mux2x1 #(.width(16)) mux2x1_5
                              (
                                .in1(npc_temp),  //moved branch a stage back _id_ex
                                .in2(register_data_2),
                                .sel(reg_branch),
                                .out(npc1)
                               );            
 
// wire [15:0] npc2_temp;
adder_16bit add2(
                .a(16'h0001),   //PC only increments by 1 if branch not taken
                .b(npc),
                .cin(1'b0),
                .s(npc2)
               // .carry(carry2)
                ); 
                
////id/ex stage halt                 
//d_flip_flop #(.width(16)) dff8(
//                               .write_i(npc2_temp),     // write data
//                               .clk_i(clk),
//                               .reset_i(reset),
//                               .read_o(npc2)
//                               );                 
                 
                                                 
                                                 
                
           
  
assign link_pc = npc2;                   
//wire [15:0] wire_pc;

//THINK UPON IT Whether to have a one more MUX with select line as reset or not!
wire final_branch_sel;
             
mux2x1 #(.width(1)) mux2x1_2
             (
               .in1(BrTaken),
               .in2(1'b0),
               .sel(reset),
               .out(final_branch_sel)
              );            
              
mux2x1 #(.width(16)) mux2x1_1
                            (
                             .in1(npc2),       
                             .in2(npc1),    
                             .sel(final_branch_sel),                     
                             .out(pc)          
                             );

//mux2x1  mux2(
//            .cond_branch(npc2),       
//            .uncond_branch(npc1),     //unconditional branch
//            .sel(BrTaken),     //will tell whether to branch or not
//            .x(wire_pc)           //final pc value
//             );
////   assign pc = npc;
//mux2x1  mux3(
//            .cond_branch(wire_pc),       
//            .uncond_branch(link_reg),     //linked register value
//            .sel(link_sel),     //will tell whether to branch or not
//            .x(pc)           //final pc value
//             );                                         
                           

endmodule
