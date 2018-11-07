module mux3 #(parameter WIDTH=8) (a, b, c, select, out);
  // select | out
  // 00 | a
  // 01 | b
  // 02 | c
  
	input[1:0] select;
	input [WIDTH-1:0] a,b,c;
	output [WIDTH-1:0] out;
	integer i;

	wire[1:0]  select;
	wire[WIDTH-1:0]a,b,c;
	reg [WIDTH-1:0] out;
	
	always @(select or a or b or c) begin
		case(select)
			2'd0:   out= a;
			2'd1:   out= b;
			2'd2:   out= c;
			default:  out = {WIDTH{1'bX}}; 
		endcase
	end


endmodule

