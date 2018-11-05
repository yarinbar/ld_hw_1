module ALU_tb;

reg [31:0] a, b, c;
reg [2:0] alu_control;
wire [31:0] out;

ALU u0 (a, b, alu_control, out);

initial begin
  a = 32'd1;
  b = 32'd2;
  c = 32'd3;
  alu_control = 3'd0;
  $display("Starting simulation...");
  #20;
  alu_control = 3'd1;
  #20;
  alu_control = 3'd2;
  #20;
  alu_control = 3'd3;
  #20;
  $display("Done...");
  $finish;
end

initial begin
   $monitor("At time %t, value = %0d", $time, alu_control);
   $dumpfile("ALU_test.vcd");
	 $dumpvars(0, ALU_tb);
end


endmodule // test
