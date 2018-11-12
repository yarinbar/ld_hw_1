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
	
	
	initial begin
		state <= init;
	end


	always @ (posedge clock, posedge reset)	begin
		
		if(reset)
			// change to initial state
			state <= init;

		else
			state <= next_state;
	
	end


	always @ (in, state) begin
		
		case (state)
			init: begin
				next_state <= in;
				out = 2'b00;
			end
			
			R: begin
				if (in == state) begin
					next_state <= win;
					out = 2'b10;
				end
				else begin 
					next_state <= lose;
					out = 2'b01;
				end
			end		

			G: begin
				if (in == state) begin
					next_state <= win;
					out = 2'b10;
				end
				else begin
					next_state <= lose;
					out = 2'b01;
				end
			end

			B: begin
				if (in == state) begin
					next_state <= win;
					out = 2'b10;
				end
				else  begin
					next_state <= lose;
					out = 2'b01;
				end
			end	
			
			Y: begin
				if (in == state) begin
					next_state <= win;
					out = 2'b10;
				end
				else begin 
					next_state <= lose;
					out = 2'b01;
				end
			end
			
			win: begin
			end		

			lose: begin
			end
		endcase

	end

// out:
// X 00
// 0 01
// 1 10
endmodule
