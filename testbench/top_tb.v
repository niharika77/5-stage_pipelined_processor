`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.04.2019 15:17:38
// Design Name: 
// Module Name: top_tb
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


module top_tb();
reg clk;
reg reset;
reg [1:0] test;
wire [15:0] result;
 
top top(
        .clk(clk),
        .reset(reset),
        .test(test),
        .result(result)
        );
 
initial 
 begin
  clk = 1'b1;
 end       
 
always #5 clk = ~clk;

initial 
 begin
  test = 2'b10;
  reset = 1'b1;
  #10
  reset = 1'b0;
  
 end       

        
endmodule
