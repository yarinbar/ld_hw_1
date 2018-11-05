module mux3_tb;

reg [31:0] a, b, c;
reg [1:0] select;
wire [31:0] out;

  mux3 #(.WIDTH(32)) U0 (
  .a (a),
  .b (b),
  .c (c),
  .select (select),
  .out (out)
  );

initial begin
  a = 32'd1;
  b = 32'd2;
  c = 32'd3;
  select = 2'd0;
  $display("Starting simulation...");
  #20;
  select = 2'd1;
  #20;
  select = 2'd2;
  #20;
  select = 2'd3;
  #20;
  $display("Done...");
  $finish;
end

initial begin
   $monitor("At time %t, value = %0d", $time, select);
   $dumpfile("mux3_test.vcd");
	 $dumpvars(0, mux3_tb);
end

endmodule // test
