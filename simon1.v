module simon1 (clock, reset, in, out);
// in:
// R 00
// G 01
// B 10
// Y 11

	localparam [4]
		R = 0,
		G = 1,
		B = 2,
		Y = 3;

   	input wire [1:0] in;
	input wire clock;
	input wire reset;
	output reg [1:0] out;

		


	always @ (posedge clock, posedge reset) 
	begin
		if(reset)

	end

	always @ (in) begin
	temp = in; //attacker's in

		assign out = 2'dX;
		
				
			
		// if the input is invalid
		if (in == 2'dX || in == 2'dZ)
			assign out = 2'dX;

		else
			if(in === temp) //player's in
				assign out = 2'b10;
			else
				assign out = 2'b01;
	end			

// out:
// X 00
// 0 01
// 1 10
endmodule
