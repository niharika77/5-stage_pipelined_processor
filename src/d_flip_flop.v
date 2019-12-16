//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.01.2019 12:46:09
// Design Name: 
// Module Name: d_flip_flop
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


module d_flip_flop #(parameter width = 1)(
                  input [width-1:0] write_i,     // write data
           //       input enable_i,  
                  input clk_i,
                  input reset_i,
                  output reg [width-1:0] read_o
                  );
                  
         always@(posedge clk_i)   
          begin 
            if(reset_i)
             begin
              read_o <= 'b0;
             end
            else 
             begin
     //         if(enable_i==1)
       //        begin
                read_o <= write_i;
               end
         //     else
           //    begin
             //   read_o <= 'b0;
               //end
            // end
          end
                  
 
endmodule
