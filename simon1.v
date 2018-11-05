module simon1 (clock, reset, in, out);
// in:
// R 00
// G 01
// B 10
// Y 11

   	input [1:0] in;
	input clock;
	input [1:0] reset;
	output [1:0] out;

	wire [1:0] in;
	wire [1:0] reset;	
	wire clock;
	wire [1:0] out;

	always @ (posedge clock)
	begin
		assign out = 2'b00;
		if(in === reset)
			assign out = 2'b10;
		else
			assign out = 2'b01;
	end			

// out:
// X 00
// 0 01
// 1 10
endmodule
