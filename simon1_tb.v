module simon1_tb;

reg clock, reset;
reg [1:0] in;
wire [1:0] out;

  simon1 U0 (
  .clock (clock),
  .reset (reset),
  .in    (in),
  .out  (out)
  );


initial begin
  // clock =
  // reset =
  // in =
  $display("Starting simulation...");
  #50;
  // if (out !== xxxx) $display("xxxxx");
  #50;
  $display("Done...");
  $finish;
end

initial begin
   $dumpfile("simon1_test.vcd");
	 $dumpvars(0, simon1_tb);
end

always begin
   #10 clock = !clock;
end

endmodule
