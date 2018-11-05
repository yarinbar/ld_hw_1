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

	reg [1:0] state, next_state;

		


	always @ (posedge clock, posedge reset) 
	begin
		if(reset) begin
			// change 0 to initial state
			state <= 0;
			next_state <= 2'dX;		
		end
		
		else begin
			state <= next_state;
		end
	end



	always @ (in) begin
		
		state <= next_state;
		next_state <= in; //attacker's in
		
		assign out = 2'dX;
				
			
		// if the input is invalid
		if (in == 2'dX || in == 2'dZ)
			assign out = 2'dX;

		else
			if(in === state) //player's in
				assign out = 2'b10;
			else
				assign out = 2'b01;
	end			

// out:
// X 00
// 0 01
// 1 10
endmodule
