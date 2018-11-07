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
  clock = 0;
  reset = 0;
  #5;
  in = 0;
  #10;
  $display("Starting simulation...");
  #50;
  if (out !== 2'b10) $display("fuck");
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
