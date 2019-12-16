//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.04.2019 14:46:46
// Design Name: 
// Module Name: CPSR
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


module CPSR( //flags passed from th ALU
           input clk,
           input reset,
           input carry,
           input overflow,
           input negative,
           input zero,
           input [3:0] conditions,    //type of unconditional branch
           output reg cpsr_flag
            );
always @(*)
     begin
      case (conditions)
       4'b0000: begin             //equal
                  if (zero == 1'b1)
                     cpsr_flag  = 1'b1;
                  else
                     cpsr_flag  = 1'b0;
                end
       4'b0001: begin            //not equal
                   if (zero == 1'b0)
                      cpsr_flag  = 1'b1;
                   else
                      cpsr_flag  = 1'b0;
                 end
       4'b0010: begin           //carry set
                    if (carry == 1'b1)
                       cpsr_flag  = 1'b1;
                    else
                       cpsr_flag  = 1'b0;
                  end             
       4'b0011: begin          //carry clear
                     if (carry == 1'b0)
                        cpsr_flag  = 1'b1;
                     else
                        cpsr_flag  = 1'b0;
                   end             
       4'b0100: begin         //minus (negative)
                      if (negative == 1'b1)
                         cpsr_flag  = 1'b1;
                      else
                         cpsr_flag  = 1'b0;
                    end            
       4'b0101: begin         //plus,positive or zero
                       if (negative == 1'b0)
                          cpsr_flag  = 1'b1;
                       else
                          cpsr_flag  = 1'b0;
                     end            
       4'b0110: begin         //overflow
                        if (overflow == 1'b1)
                           cpsr_flag  = 1'b1;
                        else
                           cpsr_flag  = 1'b0;
                      end
       4'b0111: begin        //no overflow
                         if (overflow == 1'b1)
                            cpsr_flag  = 1'b1;
                         else
                            cpsr_flag  = 1'b0;
                       end 
       4'b1000: begin       //unsigned higher
                          if ((carry == 1'b1) & (zero == 1'b1))
                             cpsr_flag  = 1'b1;
                          else
                             cpsr_flag  = 1'b0;
                        end                   
       4'b1001: begin       //unsigned lower or equal
                           if ((carry == 1'b0) & (zero == 1'b1))
                              cpsr_flag  = 1'b1;
                           else
                              cpsr_flag  = 1'b0;
                         end                   
       4'b1010: begin       //signed greater than or equal
                         if (negative == overflow)
                            cpsr_flag  = 1'b1;
                         else
                            cpsr_flag  = 1'b0;
                       end                   
       4'b1011: begin       //signed less than
                           if ((~negative) == overflow)
                              cpsr_flag  = 1'b1;
                           else
                              cpsr_flag  = 1'b0;
                         end                                    
       4'b1100: begin       //signed greater than
                             if ((zero == 1'b0) & (negative == overflow))
                                cpsr_flag  = 1'b1;
                             else
                                cpsr_flag  = 1'b0;
                           end   
       4'b1101: begin       //signed less than or equal
                           if ((zero == 1'b1) | ((~negative) == overflow))
                              cpsr_flag  = 1'b1;
                           else
                              cpsr_flag  = 1'b0;
                         end                       
       4'b1110: begin       //always unconditional
                  cpsr_flag  = 1'b1;
                end
       default: cpsr_flag  = 1'b0;         
      endcase         
     end 

endmodule
//reg carry_n;
//wire carry_r;
//reg overflow_n;
//wire overflow_r;
//reg negative_n;
//wire negative_r;
//reg zero_n;
//wire zero_r;

//assign carry_r = carry;
//assign overflow_r = overflow;
//assign negative_r = negative;
//assign zero_r = zero;
          
//always @(*)
// begin
//  case (conditions)
//   4'b0000: begin             //equal
//              if (zero_n == 1'b1)
//                 cpsr_flag  = 1'b1;
//              else
//                 cpsr_flag  = 1'b0;
//            end
//   4'b0001: begin            //not equal
//               if (zero_n == 1'b0)
//                  cpsr_flag  = 1'b1;
//               else
//                  cpsr_flag  = 1'b0;
//             end
//   4'b0010: begin           //carry set
//                if (carry_n == 1'b1)
//                   cpsr_flag  = 1'b1;
//                else
//                   cpsr_flag  = 1'b0;
//              end             
//   4'b0011: begin          //carry clear
//                 if (carry_n == 1'b0)
//                    cpsr_flag  = 1'b1;
//                 else
//                    cpsr_flag  = 1'b0;
//               end             
//   4'b0100: begin         //minus (negative)
//                  if (negative_n == 1'b1)
//                     cpsr_flag  = 1'b1;
//                  else
//                     cpsr_flag  = 1'b0;
//                end            
//   4'b0101: begin         //plus,positive or zero
//                   if (negative_n == 1'b0)
//                      cpsr_flag  = 1'b1;
//                   else
//                      cpsr_flag  = 1'b0;
//                 end            
//   4'b0110: begin         //overflow
//                    if (overflow_n == 1'b1)
//                       cpsr_flag  = 1'b1;
//                    else
//                       cpsr_flag  = 1'b0;
//                  end
//   4'b0111: begin        //no overflow
//                     if (overflow_n == 1'b1)
//                        cpsr_flag  = 1'b1;
//                     else
//                        cpsr_flag  = 1'b0;
//                   end 
//   4'b1000: begin       //unsigned higher
//                      if ((carry_n == 1'b1) & (zero_n == 1'b1))
//                         cpsr_flag  = 1'b1;
//                      else
//                         cpsr_flag  = 1'b0;
//                    end                   
//   4'b1001: begin       //unsigned lower or equal
//                       if ((carry_n == 1'b0) & (zero_n == 1'b1))
//                          cpsr_flag  = 1'b1;
//                       else
//                          cpsr_flag  = 1'b0;
//                     end                   
//   4'b1010: begin       //signed greater than or equal
//                     if (negative_n == overflow_n)
//                        cpsr_flag  = 1'b1;
//                     else
//                        cpsr_flag  = 1'b0;
//                   end                   
//   4'b1011: begin       //signed less than
//                       if ((~negative_n) == overflow_n)
//                          cpsr_flag  = 1'b1;
//                       else
//                          cpsr_flag  = 1'b0;
//                     end                                    
//   4'b1100: begin       //signed greater than
//                         if ((zero_n == 1'b0) & (negative_n == overflow_n))
//                            cpsr_flag  = 1'b1;
//                         else
//                            cpsr_flag  = 1'b0;
//                       end   
//   4'b1101: begin       //signed less than or equal
//                       if ((zero_n == 1'b1) | ((~negative_n) == overflow_n))
//                          cpsr_flag  = 1'b1;
//                       else
//                          cpsr_flag  = 1'b0;
//                     end                       
//   4'b1110: begin       //always unconditional
//              cpsr_flag  = 1'b1;
//            end
//   default: cpsr_flag  = 1'b0;         
//  endcase         
// end          

//always @(posedge clk)
// begin
//  if(reset == 1'b1)
//   begin
//    carry_n = 1'b0;
//    overflow_n = 1'b0;
//    negative_n = 1'b0;
//    zero_n = 1'b0;
//   end
//  else
//   begin
//    carry_n = carry_r;
//    overflow_n = overflow_r;
//    negative_n = negative_r;
//    zero_n = zero_r;
//   end
// end            
    
//endmodule
