module ALU (a, b, alu_control, out);
  input [31:0] a, b;
  input [2:0] alu_control;
  output reg [31:0] out;
  // ADD 3'b000
  // SUB 3'b001
  // AND 3'b010
  // OR  3'b011
  // NOR 3'b100
  // XOR 3'b101
endmodule
