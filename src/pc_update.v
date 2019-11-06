`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.01.2019 11:55:54
// Design Name: 
// Module Name: pc_update
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


module pc_update(
                  input [15:0] in,  //pc
                  input clk,
                  input reset,
                  output reg [15:0] out  //npc
                 );
          
          
     always @(posedge clk)
      begin
       if(reset==1'b1)
        begin
         out <= 16'b0;
        end
        else
         begin
          out <= in;
         end
      end      
      
endmodule
