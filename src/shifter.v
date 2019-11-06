//`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////////
//// Company: 
//// Engineer: 
//// 
//// Create Date: 21.01.2019 12:55:32
//// Design Name: 
//// Module Name: shifter
//// Project Name: 
//// Target Devices: 
//// Tool Versions: 
//// Description: 
//// 
//// Dependencies: 
//// 
//// Revision:
//// Revision 0.01 - File Created
//// Additional Comments:
//// 
////////////////////////////////////////////////////////////////////////////////////

module shifter (
	input wire [15:0]	value,   //read_data1
  input wire [1:0] shift_type,   //comes from the controller
	input wire [15:0] distance,     //read_data2
	output reg [15:0] result,
	output reg carry_out,
	output wire overflow,
	output wire negative,
	output wire zero
	);
	
	wire [31:0] double_value;
	wire [3:0] dist_mod;
	wire signed [15:0] value_rotate;
	
	assign value_rotate = value;
	assign dist_mod = distance % 16;
	assign double_value = {value, value};
	assign negative = result[15];
	assign zero = (result == 0);
	assign overflow = 1'b0;
	
	always @(*) begin
		carry_out = 1'b0;
		result = value;
		case(shift_type)
			2'b00 : begin  
						{carry_out, result} = value << distance;
					end
					
			 2'b01 : begin
							if (distance > 0) begin 
								{result, carry_out} = value >> distance - 1;
							end
						end
			 
			 2'b10 : begin
							if (distance > 0) begin
								{result, carry_out} = value_rotate >>> distance - 1;
							end
						end
						
			 2'b11 : begin
							if (dist_mod > 0) begin
								{result, carry_out} = double_value >> dist_mod - 1;
							end
						end
	  endcase
	end

endmodule
////type of shift : logical, arithmetic or rotation
//module shifter (
//	input [15:0]	value,   //read_data1
////	input direction, // 0: left, 1: right
//    input [1:0] shift_type,   //comes from the controller
//	input [15:0] distance,     //read_data2
//	output reg [15:0] result
//	);
	
//reg [15:0] LSL;
//reg [15:0] LSR;
//reg [31:0] ASR;
//reg [31:0] RSR;
//wire [31:0] value_temp1;
//wire [31:0] value_temp2;

//assign value_temp1 = {value,value};
//assign value_temp2 = {{16{value[15]}},value};

//always@(*) begin
//   LSL = value << distance;
//   LSR = value >> distance;
//   ASR = value_temp2 >>> distance;
//   RSR = value_temp1 >> distance;
////    if (direction == 0)
////        result = value << distance;
////    else
////        result = value >> distance;
//end

//always @(*) begin
//   case(shift_type)
//    2'b00: result = LSL;
//    2'b01: result = LSR;
//    2'b10: result = ASR[15:0];
//    2'b11: result = RSR[15:0];
//    default: result = LSL;
//   endcase
//end
//endmodule
