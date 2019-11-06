`timescale 1ns / 1ps

module adder_16bit (a,b,cin,s);		//ripple carry adder usng full adder-> basic gates
//}} End of automatically maintained section
input [15:0]a;
input [15:0]b;
input cin;
output [15:0]s;
wire carry;
wire [14:0]c;

adder z0(.a(a[0]),.b(b[0]),.c(cin),.sum(s[0]),.cout(c[0]));
adder z1(.a(a[1]),.b(b[1]),.c(c[0]),.sum(s[1]),.cout(c[1]));
adder z2(.a(a[2]),.b(b[2]),.c(c[1]),.sum(s[2]),.cout(c[2]));
adder z3(.a(a[3]),.b(b[3]),.c(c[2]),.sum(s[3]),.cout(c[3]));
adder z4(.a(a[4]),.b(b[4]),.c(c[3]),.sum(s[4]),.cout(c[4]));
adder z5(.a(a[5]),.b(b[5]),.c(c[4]),.sum(s[5]),.cout(c[5]));
adder z6(.a(a[6]),.b(b[6]),.c(c[5]),.sum(s[6]),.cout(c[6]));
adder z7(.a(a[7]),.b(b[7]),.c(c[6]),.sum(s[7]),.cout(c[7]));
adder z8(.a(a[8]),.b(b[8]),.c(c[7]),.sum(s[8]),.cout(c[8]));
adder z9(.a(a[9]),.b(b[9]),.c(c[8]),.sum(s[9]),.cout(c[9]));
adder z10(.a(a[10]),.b(b[10]),.c(c[9]),.sum(s[10]),.cout(c[10]));

adder z11(.a(a[11]),.b(b[11]),.c(c[10]),.sum(s[11]),.cout(c[11]));
adder z12(.a(a[12]),.b(b[12]),.c(c[11]),.sum(s[12]),.cout(c[12]));
adder z13(.a(a[13]),.b(b[13]),.c(c[12]),.sum(s[13]),.cout(c[13]));
adder z14(.a(a[14]),.b(b[14]),.c(c[13]),.sum(s[14]),.cout(c[14]));
adder z15(.a(a[15]),.b(b[15]),.c(c[14]),.sum(s[15]),.cout(carry));

endmodule
