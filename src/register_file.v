`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.01.2019 13:53:24
// Design Name: 
// Module Name: register_file1
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


module register_file(
                     input RegWrite,
                     input [3:0] write_register,
                     input [15:0] write_data,
                     input clk,
                     input reset,
                     input [3:0] read_register1,
                     input [3:0] read_register2,
                     output [15:0] read_data1,
                     output [15:0] read_data2     
                    // output reg [15:0] read_data1,
                    // output reg [15:0] read_data2                     
                     );


reg [15:0] rf[15:0];

assign read_data1 = rf[read_register1];
assign read_data2 = rf[read_register2];

  always @(posedge clk) begin
 //   read_data1 <= rf[read_register1];
//    read_data2 <= rf[read_register2];
    if (RegWrite == 1'b1)
      rf[write_register] <= write_data;
  end
  
  integer i;
  
  initial 
   begin
//   for(i = 0; i<16; i=i+1) begin
//     rf[i] = 16'h0000;
//   end
     
    rf[0] = 16'h0000;
    rf[1] = 16'h0001;
    rf[2] = 16'h0002;
    rf[3] = 16'h0003;
    rf[4] = 16'h0004;
    rf[5] = 16'h0005;
    rf[6] = 16'h0006;
    rf[7] = 16'h0007;
    rf[8] = 16'h0008;
    rf[9] = 16'h0009;
    rf[10] = 16'h000a;
    rf[11] = 16'h000b;
    rf[12] = 16'h000c;
    rf[13] = 16'h000d;
    rf[14] = 16'h000e;
    rf[15] = 16'h000f;   
   end

endmodule
