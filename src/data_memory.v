`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.02.2019 12:03:44
// Design Name: 
// Module Name: data_memory
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


module data_memory(
                  input [15:0] address,
                  input [15:0] write_data,
                  input mem_read,
                  input mem_write,
                  input clk,
                  output reg [15:0] read_data
                 // output reg [63:0] read_data
                   );
                   
    reg [15:0] mem [127:0];    //change the size of the memory
    
    integer i;
    
//    initial
//     begin
//   //   read_data <=0;
//      for(i = 0; i<256; i = i+1) begin
//       mem[i] = i;
//      end
//     end
     
    always @(*)
     begin
     if (mem_read == 1'b1) 
      read_data = mem[address];
     end
     
    always @(posedge clk)
     begin
      if(mem_write)
       begin
        mem[address] <= write_data;
       end
    
     end   
     
            
                  
endmodule
