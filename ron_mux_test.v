module mux3_tb;

  `define assert(exp, val)\
     #20\
     if (!(exp === val)) begin\
       $display("Assertion failed on line %0d of %s - expected: %0d, received: %0d",\
       `__LINE__, `__FILE__, exp, val);\
       $finish;\
     end


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
 
  // testing for a input
  #20;
  select = 2'd0;
  `assert(32'd1, out);
  a = 32'd4;
  `assert(32'd4, out);
  a = 32'd0;
  `assert(32'd0, out);

  // testing for b input
  select = 2'd1;
  `assert(32'd2, out);
  b = 32'd5;
  `assert(32'd5, out);
  b = 32'd0; 
  `assert(32'd0, out);

  // testing for c input
  select = 2'd2;
  `assert(32'd3, out);
  c = 32'd6;
  `assert(32'd6, out);
  c = 32'd0; 
  `assert(32'd0, out);

  // testing for select input
  a = 32'd1;
  b = 32'd2;
  c = 32'd3;
  select = 2'd0;
  select = 2'd1;
  `assert(32'd2, out);
  select = 2'd1;
  select = 32'd2;
  `assert(32'd3, out);

  // testing for invalid select = b11
  select = 2'd3;
  `assert({32{1'dx}}, out);

  // big numbers
  a = 32'd4294967295;
  `assert({32{1'dx}}, out); // previous out value
  select = 2'd0; // now changing select to a
  `assert(32'd4294967295, out);

  $display("All tests passed! Good job!");

  $display("Done...");
  $finish;
end

initial begin
  // $monitor("At time %t, value = %0d", $time, select);
   $dumpfile("mux3_test.vcd");
	 $dumpvars(0, mux3_tb);
end

endmodule // test

