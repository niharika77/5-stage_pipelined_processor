`timescale 1ns / 1ps

module adder (a,b,c,sum,cout);
//}} End of automatically maintained section
    input a;
    input b;
    input c;
  	output sum;
  	output cout;
	
	wire w1, w2, w3;
	
	xor x1(w1,a,b);
	xor x2(sum,w1,c);
	
	and a1(w2,a,b);
	and a2(w3,w1,c);
	or o1(cout,w2,w3);
	
// -- Enter your statements here -- //

endmodule

