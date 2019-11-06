`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.02.2019 12:18:09
// Design Name: 
// Module Name: ALU
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


module ALU #(parameter width = 16)(
           input [width-1:0] operand1,
           input [width-1:0] operand2,
           input [2:0] ALUop,
           output reg [width-1:0] result,
           output reg carry,
           output reg overflow,
           output reg negative,
           output reg zero   //[carry(C),overflow(V),negative(N),zero(Z)]
           );
           
    
    reg [width:0] temp_result;
    
 //   parameter [2:0] ADD = 3'b000;
 //   parameter [2:0] SUB = 3'b001;
 //   parameter [2:0] AND = 3'b010;
 //   parameter [2:0] OR  = 3'b011;
 //   parameter [2:0] XOR = 3'b100;
 //   parameter [2:0] NOT = 3'b101;
 //   parameter [2:0] same = 3'b110;
    
    always @(*)
     begin
      carry = 1'b0;
      overflow = 1'b0;
      negative = 1'b0;
      zero = 1'b0;
      temp_result = 17'b0;
      result = 16'b0;
      
      case(ALUop)
       3'b000: begin                //addition 
              temp_result = operand1 + operand2;
              result = temp_result[width-1:0];
              carry = temp_result[width];
              if((operand1[width-1]==0 && operand2[width-1]==0 && temp_result[width-1]==1) || (operand1[width-1]==1 && operand2[width-1]==1 && temp_result[width-1]==0)) 
               begin                      //in case of 2's complement signed addition
                overflow = 1'b1;
               end
              if(temp_result[width-1]==1)
               begin
                negative = 1'b1;
               end
              if(result==0)
               begin
                zero = 1'b1;
               end
            end
            
       3'b001: begin               //subtraction
             temp_result = operand1 + (~operand2) + 1'b1;
             result = temp_result[width-1:0];
             carry = temp_result[width];
             if((operand1[width-1]==0 && operand2[width-1]==1 && temp_result[width-1]==1) || (operand1[width-1]==1 && operand2[width-1]==0 && temp_result[width-1]==0)) 
              begin                      //in case of 2's complement signed addition
               overflow = 1'b1;
              end
             if(temp_result[width-1]==1)
              begin
               negative = 1'b1;
              end
            if(result==0)
             begin
              zero = 1'b1;
             end
           end         
            
       3'b010: begin         //AND
             result = operand1 & operand2;   
             if(result==0)
              begin
               zero = 1'b1;
              end  
            end  

       3'b011: begin         //ORR
             result = operand1 | operand2;   
             if(result==0)
              begin
               zero = 1'b1;
              end                   
            end            
      
       3'b100: begin          //XOR
              result = operand1 ^ operand2;  
             if(result==0)
               begin
                zero = 1'b1;
               end                     
             end
       
       3'b101: begin         //NOT
               result = ~operand2;         
             if(result==0)
                begin
                 zero = 1'b1;
                end               
              end    

       3'b110: begin        //SAME
               result = operand2;
              if(result==0)
               begin
                zero = 1'b1;
               end
              end        
                            
      endcase
     end 
     
 // assign flags = {carry,overflow,negative,zero};
    
endmodule