`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.05.2019 15:25:13
// Design Name: 
// Module Name: mux8x1
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


module mux8x1 #(parameter width = 1)(
                                     input [width-1:0] in1,
                                     input [width-1:0] in2,
                                     input [width-1:0] in3,
                                     input [width-1:0] in4,
                                     input [width-1:0] in5,
                                     input [width-1:0] in6,
                                     input [width-1:0] in7,
                                     input [width-1:0] in8,
                                     input [2:0] sel,
                                     output [width-1:0] out
                                    );

assign out = sel[2]?(sel[1]?(sel[0]?(in8):(in7)):(sel[0]?(in6):(in5))):(sel[1]?(sel[0]?(in4):(in3)):(sel[0]?(in2):(in1)));


endmodule
