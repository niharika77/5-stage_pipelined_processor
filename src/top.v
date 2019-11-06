`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.04.2019 12:41:33
// Design Name: 
// Module Name: top
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


module top(
            input clk,
            input reset,
            input [1:0] test,
            output [15:0] result
            );

wire [15:0] instruction1;
wire [15:0] instruction;

wire BrTaken;
wire [15:0] link_pc;
wire [15:0] next_address;

//control signals
wire [1:0] Reg1Loc;
wire [2:0] Reg2Loc;
wire [1:0] write_reg;
wire cmp_sel;
wire [1:0] immediate_sel;
wire RegWrite;
wire ALUsrc;
wire [1:0] shift_type;
wire [2:0] ALUop;
wire [3:0] conditions;
wire mem_read;
wire mem_write;
wire [1:0] write_back;
wire cond_branch;
wire uncond_branch;
wire link_branch;
wire reg_branch;
wire [1:0] branch_type;

//register signals
wire [3:0] read_address1;
wire [3:0] read_address2;
wire [3:0] write_address;
wire [3:0] write_address_temp;

wire [15:0] read_data1;
wire [15:0] read_data2;
wire [15:0] write_data;

//immediate values
wire [15:0] immediate1;
wire [15:0] immediate2;
wire [15:0] immediate3;
wire [15:0] immediate4;
wire [15:0] immediate_data;

//ALU unit
wire [15:0] ALU_output;
wire carry;
wire overflow;
wire negative;
wire zero;

wire alu_shift;
      
//shifter unit
wire [15:0] shift_output;

//data memory
wire [15:0] read_data_memory;
wire [15:0] data_memory_write;

//IF/ID flip flop                  
wire [15:0] link_pc_if_id;
wire [15:0] instruction_if_id;

//id_ex stage passes all these values to the next stage (execute stage)
wire RegWrite_id_ex;
wire ALUsrc_id_ex;
wire [1:0] shift_type_id_ex;
wire [2:0] ALUop_id_ex;
wire [3:0] conditions_id_ex;
wire mem_read_id_ex;
wire mem_write_id_ex;
wire [1:0] write_back_id_ex;
wire cond_branch_id_ex;
wire uncond_branch_id_ex;
wire link_branch_id_ex;
wire reg_branch_id_ex;
wire [1:0] branch_type_id_ex; 
wire [15:0] instruction_id_ex;
wire [3:0] read_address1_id_ex;
wire [3:0] read_address2_id_ex;
wire [3:0] write_address_id_ex;
wire [15:0] read_data1_id_ex;
wire [15:0] read_data2_id_ex;
wire [15:0] immediate_data_id_ex;
wire [15:0] link_pc_id_ex;
wire alu_shift_id_ex;

//ex_mem stage passes all these values to the next stage (memory stage)
wire RegWrite_ex_mem;
wire [15:0] link_pc_ex_mem;
//wire cond_branch_ex_mem;
//wire uncond_branch_ex_mem;
//wire reg_branch_ex_mem;
//wire link_branch_ex_mem;
wire mem_read_ex_mem;
wire mem_write_ex_mem;
wire [1:0] write_back_ex_mem;
//wire cpsr_flag_ex_mem;
wire [15:0] read_data2_ex_mem;
wire [15:0] ALU_output_ex_mem;
wire [15:0] shift_output_ex_mem;
wire [3:0] write_address_ex_mem;
wire [15:0] data_memory_write_ex_mem;

//mem_wb stage passess all these values to the next stage (writeback stage)
wire [1:0] write_back_mem_wb;
wire [15:0] link_pc_mem_wb;
wire [3:0] write_address_mem_wb;
wire [15:0] ALU_output_mem_wb;
wire [15:0] shift_output_mem_wb;
wire [15:0] read_data_memory_mem_wb;
wire RegWrite_mem_wb;


pc_manager pc_manager(
                      .clk(clk),
                      .reset(reset),
                      .cond_address(instruction_if_id[7:0]),
                      .uncond_address(instruction_if_id[10:0]),  
                      .link_address(instruction_if_id[5:0]),
                      .register_data_2(read_data2), //data read from the register output port 2
                      .branch_type(branch_type),  //moved branch path a stage back    
                      .BrTaken(BrTaken),
                      .reg_branch(reg_branch),  //id_ex
                      .link_pc(link_pc),
                      .pc_out(next_address)
                  );
                  

d_flip_flop #(.width(16)) dff1(
                              .write_i(link_pc),     // write data
                    //          .enable_i(1'b1),  
                              .clk_i(clk),
                              .reset_i(reset),
                              .read_o(link_pc_if_id)
                              );

//asynchronous instruction memory          
instruction_mem instruction_memory(
                                   .address(next_address), 
                                  // .clk(clk),
                                   .test(test),
                                   .instruction(instruction)
                                      ); 

//IF/ID flip flop
d_flip_flop #(.width(16)) dff2(
                              .write_i(instruction),     // write data
                       //       .enable_i(1'b1),  
                              .clk_i(clk),
                              .reset_i(reset),
                              .read_o(instruction_if_id)
                              );                                      



                                  
d_flip_flop_id_ex id_ex(
                       .clk(clk),
                       .reset(reset),
                       .RegWrite_r(RegWrite),
                       .ALUsrc_r(ALUsrc),
                       .shift_type_r(shift_type),
                       .ALUop_r(ALUop),
                       .conditions_r(conditions),
                       .mem_read_r(mem_read),
                       .mem_write_r(mem_write),
                       .write_back_r(write_back),
                       .cond_branch_r(cond_branch),
                       .uncond_branch_r(uncond_branch),
                       .link_branch_r(link_branch),
                       .reg_branch_r(reg_branch),
                       .branch_type_r(branch_type),
                       .alu_shift_r(alu_shift),
                       
                       .instruction_r(instruction_if_id),
                       .read_address1_r(read_address1),
                       .read_address2_r(read_address2),
                       .write_address_r(write_address),
                       .read_data1_r(read_data1),
                       .read_data2_r(read_data2),
                       .immediate_data_r(immediate_data),
                       .link_pc_r(link_pc_if_id),
                       //output values for id/ex stage
                       .RegWrite_n(RegWrite_id_ex),
                       .ALUsrc_n(ALUsrc_id_ex),
                       .shift_type_n(shift_type_id_ex),
                       .ALUop_n(ALUop_id_ex),
                       .conditions_n(conditions_id_ex),
                       .mem_read_n(mem_read_id_ex),
                       .mem_write_n(mem_write_id_ex),
                       .write_back_n(write_back_id_ex),
                       .cond_branch_n(cond_branch_id_ex),
                       .uncond_branch_n(uncond_branch_id_ex),
                       .link_branch_n(link_branch_id_ex),
                       .reg_branch_n(reg_branch_id_ex),
                       .branch_type_n(branch_type_id_ex),
                       
                       .instruction_n(instruction_id_ex),
                       .read_address1_n(read_address1_id_ex),
                       .read_address2_n(read_address2_id_ex),
                       .write_address_n(write_address_id_ex),
                       .read_data1_n(read_data1_id_ex),
                       .read_data2_n(read_data2_id_ex),
                       .immediate_data_n(immediate_data_id_ex),
                       .link_pc_n(link_pc_id_ex),
                       .alu_shift_n(alu_shift_id_ex)
                       );   
                       
d_flip_flop_ex_mem ex_mem(
                         .clk(clk),
                         .reset(reset),
                         .RegWrite_r(RegWrite_id_ex),
                         .link_pc_r(link_pc_id_ex),
                       //wire cond_branch_ex_mem;
                       //wire uncond_branch_ex_mem;
                       //wire reg_branch_ex_mem;
                       //wire link_branch_ex_mem;
                         .mem_read_r(mem_read_id_ex),
                         .mem_write_r(mem_write_id_ex),
                         .write_back_r(write_back_id_ex),
                       //wire cpsr_flag_ex_mem;
                         .read_data2_r(read_data2_id_ex),
                         .ALU_output_r(ALU_output),
                         .shift_output_r(shift_output),
                         .write_address_r(write_address_id_ex),
                         .data_memory_write_r(data_memory_write),
                         
                         .RegWrite_n(RegWrite_ex_mem),
                         .link_pc_n(link_pc_ex_mem),
                         //wire cond_branch_ex_mem;
                         //wire uncond_branch_ex_mem;
                         //wire reg_branch_ex_mem;
                         //wire link_branch_ex_mem;
                         .mem_read_n(mem_read_ex_mem),
                         .mem_write_n(mem_write_ex_mem),
                         .write_back_n(write_back_ex_mem),
                         //wire cpsr_flag_ex_mem;
                         .read_data2_n(read_data2_ex_mem),
                         .ALU_output_n(ALU_output_ex_mem),
                         .shift_output_n(shift_output_ex_mem),
                         .write_address_n(write_address_ex_mem),
                         .data_memory_write_n(data_memory_write_ex_mem)
                          );
                          
d_flip_flop_mem_wb mem_wb(
                         .clk(clk),
                         .reset(reset),
                         .write_back_r(write_back_ex_mem),
                         .link_pc_r(link_pc_ex_mem),
                         .write_address_r(write_address_ex_mem),
                         .ALU_output_r(ALU_output_ex_mem),
                         .shift_output_r(shift_output_ex_mem),
                         .read_data_memory_r(read_data_memory),
                         .RegWrite_r(RegWrite_ex_mem),
                        
                         .write_back_n(write_back_mem_wb),
                         .link_pc_n(link_pc_mem_wb),
                         .write_address_n(write_address_mem_wb),
                         .ALU_output_n(ALU_output_mem_wb),
                         .shift_output_n(shift_output_mem_wb),
                         .read_data_memory_n(read_data_memory_mem_wb),
                         .RegWrite_n(RegWrite_mem_wb)
                         );                          
                                              
            
control_unit control_unit(
                         .reset(reset),
                         .instruction(instruction_if_id),
                         .Reg1Loc(Reg1Loc),
                         .Reg2Loc(Reg2Loc),
                         .write_reg(write_reg),
                         .cmp_sel(cmp_sel),
                         .immediate_sel(immediate_sel),
                         .RegWrite(RegWrite),
                         .ALUsrc(ALUsrc),
                         .shift_type(shift_type),
                         .ALUop(ALUop),
                         .conditions(conditions),
                         .mem_read(mem_read),
                         .mem_write(mem_write),
                         .write_back(write_back),
                         .cond_branch(cond_branch),
                         .uncond_branch(uncond_branch),
                         .link_branch(link_branch),
                         .reg_branch(reg_branch),
                         .branch_type(branch_type),
                         .alu_shift(alu_shift)            
                         );           
 

 //to select the address for the first register           
 mux4x1 #(.width(4)) mux1(
                                      .in1({1'b0,instruction_if_id[5:3]}),
                                      .in2({1'b0,instruction_if_id[2:0]}),
                                      .in3(4'b1101),   //SP idk wat to do with this!
                                      .in4(4'b1111),    //compare register value
                                      .sel(Reg1Loc),
                                      .out(read_address1)
                                      );            
//to select the address for the second register            
 mux8x1 #(.width(4)) mux2(
                           .in1(instruction_if_id[6:3]),
                           .in2({1'b0,instruction_if_id[8:6]}),
                           .in3({1'b0,instruction_if_id[5:3]}),   
                           .in4({1'b0,instruction_if_id[2:0]}),
                           .in5(4'b1111),
                           //others have nothing
                           .sel(Reg2Loc),
                           .out(read_address2)
                           );              
//to select the address for the write register
 mux4x1 #(.width(4)) mux3(
                           .in1({1'b0,instruction_if_id[2:0]}),
                           .in2({1'b0,instruction_if_id[10:8]}),
                           .in3(4'b1110),  //link register when branch and link   
                           .in4(4'b1101),  //SP, idk what to do with this
                           .sel(write_reg),
                           .out(write_address_temp)
                           );
                                       
mux2x1 #(.width(4)) mux4(
                            .in1(write_address_temp),       
                            .in2(4'b1111),    
                            .sel(cmp_sel),                     
                            .out(write_address)          
                            );                  
            
register_file register_file(
                            .RegWrite(RegWrite_mem_wb),
                            .write_register(write_address_mem_wb),
                            .write_data(write_data),
                            .clk(clk),
                            .reset(reset),
                            .read_register1(read_address1),
                            .read_register2(read_address2),
                            .read_data1(read_data1),
                            .read_data2(read_data2)                         
                            );           
            
//immediate values calculation

//zero_extend #(.width(8)) zero_extend1(
//                                     .input_i(instruction_if_id[7:0]),
//                                     .zero_extended_address(immediate1)
//                                     );

//zero_extend #(.width(3)) zero_extend2(
//                                     .input_i(instruction_if_id[8:6]),
//                                     .zero_extended_address(immediate2)
//                                     );                               

//zero_extend #(.width(7)) zero_extend3(
//                                     .input_i(instruction_if_id[6:0]),
//                                     .zero_extended_address(immediate3)
//                                     );            

//zero_extend #(.width(5)) zero_extend4(
//                                     .input_i(instruction_if_id[10:6]),
//                                     .zero_extended_address(immediate4)
//                                     );
                                     
//to select which immediate to carry forward to ALU
 mux4x1 #(.width(16)) mux5(
                          .in1({{8{1'b0}},instruction_if_id[7:0]}),
                          .in2({{13{1'b0}},instruction_if_id[8:6]}),
                          .in3({{9{1'b0}},instruction_if_id[6:0]}),  
                          .in4({{11{1'b0}},instruction_if_id[10:6]}),  
                          .sel(immediate_sel),
                          .out(immediate_data)
                          );               
                          

//FORWARDING UNIT   (eliminate read after write situations
wire [1:0] ForwardA;
wire [1:0] ForwardB;
wire select;

forwarding_unit forward(
                       .RegWrite_ex_mem(RegWrite_ex_mem),
                       .RegWrite_mem_wb(RegWrite_mem_wb),
                       .write_address_ex_mem(write_address_ex_mem),
                       .write_address_mem_wb(write_address_mem_wb),
                       .read_address1_id_ex(read_address1_id_ex),
                       .read_address2_id_ex(read_address2_id_ex),
                       .instruction_id_ex(instruction_id_ex),
                       
                       .ForwardA(ForwardA),  //for register1
                       .ForwardB(ForwardB),   //for register2
                       .mem_write_id_ex(mem_write_id_ex),
                       .select(select)
                       );                         
                          
                                              
//select between register data2 and immediate value
wire [15:0] ALU_input2;
wire [15:0] forward_read_data1;
wire [15:0] forward_read_data2;
           
mux2x1 #(.width(16)) mux6(
                         .in1(read_data2_id_ex),       
                         .in2(immediate_data_id_ex),    
                         .sel(ALUsrc_id_ex),                     
                         .out(ALU_input2)          
                         );                                   

//forwarding muxes to select the input for the ALU and shifter
mux4x1 #(.width(16)) forward_mux1(
                                 .in1(read_data1_id_ex),
                                 .in2(ALU_output_ex_mem),
                                 .in3(write_data),
                                 .in4(),
                                 .sel(ForwardA),
                                 .out(forward_read_data1)  //output of the registers after forwarding unit evaluation
                                  );

mux4x1 #(.width(16)) forward_mux2(
                                 .in1(ALU_input2),
                                 .in2(ALU_output_ex_mem),
                                 .in3(write_data),
                                 .in4(),
                                 .sel(ForwardB),
                                 .out(forward_read_data2)  //output of the registers after forwarding unit evaluation
                                  );


//store after arithmetic will give the data value to write to data memory in the next cycle


mux2x1 #(.width(16)) store_mux(
                         .in1(read_data2_id_ex),       
                         .in2(ALU_output_ex_mem),    
                         .sel(select),                     
                         .out(data_memory_write)          
                         ); 
  
//alu flags
wire ALU_carry;
wire ALU_overflow;
wire ALU_negative;
wire ALU_zero;
                             
ALU #(.width(16)) ALU_unit(
                           .operand1(forward_read_data1),
                           .operand2(forward_read_data2),
                           .ALUop(ALUop_id_ex),
                           .result(ALU_output),
                           .carry(ALU_carry),
                           .overflow(ALU_overflow),
                           .negative(ALU_negative),
                           .zero(ALU_zero)   
                            );

//shifter flags
wire shifter_carry;
wire shifter_overflow;
wire shifter_negative;
wire shifter_zero;
                                                                         
shifter shifter(
                .value(forward_read_data1),  
                .shift_type(shift_type_id_ex),   
                .distance(forward_read_data2),     
                .result(shift_output),
                .carry_out(shifter_carry),
                .overflow(shifter_overflow),
                .negative(shifter_negative),
                .zero(shifter_zero)
                ); 
                
mux2x1 #(.width(1)) carry_mux(
                             .in1(ALU_carry),       
                             .in2(shifter_carry),    
                             .sel(alu_shift_id_ex),                     
                             .out(carry)          
                             );                
                
mux2x1 #(.width(1)) overflow_mux(
                              .in1(ALU_overflow),       
                              .in2(shifter_overflow),    
                              .sel(alu_shift_id_ex),                     
                              .out(overflow)          
                              );                 
                
mux2x1 #(.width(1)) negative_mux(
                               .in1(ALU_negative),       
                               .in2(shifter_negative),    
                               .sel(alu_shift_id_ex),                     
                               .out(negative)          
                               );  
                                                              
mux2x1 #(.width(1)) zero_mux(
                            .in1(ALU_zero),       
                            .in2(shifter_zero),    
                            .sel(alu_shift_id_ex),                     
                            .out(zero)          
                            );                                               
                
                
                
                                                    
                                     
//CPSR
wire cpsr_flag;
wire cond;
                                     
CPSR cpsr_block(
                .clk(clk),
                .reset(reset),
                .carry(carry),
                .overflow(overflow),
                .negative(negative),
                .zero(zero),
                .conditions(conditions),   //conditions_id_ex 
                .cpsr_flag(cpsr_flag)
                    );                                     

//wire cpsr_flag_id_ex;
//d_flip_flop #(.width(1)) cpsr_dff(
//                                  .write_i(cpsr_flag),     // write data
//                           //       input enable_i,  
//                                  .clk_i(clk),
//                                  .reset_i(reset),
//                                  .read_o(cpsr_flag_id_ex)
//                                  );


and and1(cond,cond_branch,cpsr_flag);                                  //everything was          
or or1(BrTaken,cond,link_branch,uncond_branch,reg_branch);              //_id_ex


data_memory data_memory(
                       .address(ALU_output_ex_mem),
                       .write_data(data_memory_write_ex_mem),
                       .mem_read(mem_read_ex_mem),
                       .mem_write(mem_write_ex_mem),
                       .clk(clk),
                       .read_data(read_data_memory)
                       );
                                     
//to select the output to write back to the register
 mux4x1 #(.width(16)) mux7(
                         .in1(read_data_memory_mem_wb),
                         .in2(ALU_output_mem_wb),
                         .in3(shift_output_mem_wb),   //SP idk wat to do with this!
                         .in4(link_pc_mem_wb),
                         .sel(write_back_mem_wb),
                         .out(write_data)
                         );    
                
 assign result = write_data;                                    
                                     
                                     
                                     
                                     
endmodule
