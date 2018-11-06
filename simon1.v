module simon1 (clock, reset, in, out);
// in:
// R 00
// G 01
// B 10
// Y 11


   	input wire [1:0] in;
	input wire clock;
	input wire reset;
	output reg [1:0] out;
	
	reg [2:0] state, next_state;
	
	localparam [2:0]
		R = 3'b000,
		G = 3'b001,
		B = 3'b010,
		Y = 3'b011,
		init = 3'b100,
		lose = 3'b101,
		win  = 3'b110;

	always @ (posedge clock, posedge reset)	begin
		
		if(reset)
			// change to initial state
			state <= init;
			assign out = 2'dX;
	
	end


	always @ (in, state) begin
		
		// if input is invaid we change output to "dont care"		
		if(in == 2'dX || in == 2'dZ)
			// out = X
			assign out = 2'dX;


		if(state == init)
			state <= in;
	
	
		else 	
			if(state == in)
			   	// out = 1
				assign out = 2'b10;
				state <= win;

			else begin
				// out = 0
				assign out = 2'b01;
				state <= lose;
			end
	end

// out:
// X 00
// 0 01
// 1 10
endmodule
