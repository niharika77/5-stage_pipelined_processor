`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.04.2019 12:03:51
// Design Name: 
// Module Name: mux4x1
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


module mux4x1 #(parameter width = 16)
            (
             input [width-1:0] in1,
             input [width-1:0] in2,
             input [width-1:0] in3,
             input [width-1:0] in4,
             input [1:0] sel,
             output reg [width-1:0] out
              );
 
 always @(*)
  begin
   if (sel == 2'b00)
    out = in1;
   else if (sel == 2'b01)
    out = in2;
   else if (sel == 2'b10)
    out = in3;
   else
    out = in4;
  end             
              
endmodule