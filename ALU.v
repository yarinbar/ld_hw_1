module ALU (a, b, alu_control, out);
	
	input [31:0] a, b;
   	input [2:0] alu_control;
  	output reg [31:0] out;
  
  	integer i;
  
	always @(alu_control  or a or b) begin
		  
		case (alu_control)
	
			3'd0: begin
				out = a + b;
			end
      	
			3'd1: begin
				out = a - b;
			end
	
			3'd2: begin
				out = a & b;
			end
	
			3'd3: begin
				out = a | b;
			end
	
			3'd4: begin
				out = a ~| b;
			end
	
			3'd5: begin
				out = a ^ b;
			end

		default : out=32'bX;
		endcase
	end
 
endmodule

