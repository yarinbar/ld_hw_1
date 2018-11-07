module simon1_tb;

  `define assert(val, exp)\
     #5\
     if (!(exp === val)) begin\
       $display("Assertion failed on line %0d of %s - expected: %0d, received: %0d",\
       `__LINE__, `__FILE__, exp, val);\
       $finish;\
     end

   `define simon_reset;\ // for resetting machine
	  clock = 0;\
	  reset = 1;\
	  clock = 1;\
	  # 1;\
	  reset = 0;\
	  clock = 0;\

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
  `simon_reset;
  $display("Starting simulation...");

  // testing correct reset
  $display("Testing: Correct reset");
  `assert(out, 0);
  reset = 1;
  `assert(out, 0);
  in = 1;
  `assert(out, 0);
  in = 2;
  `assert(out, 0);
  in = 3;
  `assert(out, 0);
  in = 0;
  `assert(out, 0);
  reset = 0;

  // test R,R to win
  $display("Testing: R->R path");
  in = 0;
  `assert(out, 0);

  clock = 1;
  `assert(out, 2);
  in = 1;
  `assert(out, 1);
  in = 2;
  `assert(out, 1);
  in = 3;
  `assert(out, 1);
  in = 0;
  `assert(out, 2);

  clock = 0;
  `assert(out, 2);
  in = 1;
  `assert(out, 1);
  in = 2;
  `assert(out, 1);
  in = 3;
  `assert(out, 1);
  in = 0;
  `assert(out, 2);

  clock = 1;
  `assert(out, 2);
  clock = 0;

  `assert(out, 2);
  clock = 1;

  `assert(out, 2);

  // test win state
  $display("Testing: Win state");
  in = 1;
  `assert(out, 2);
  clock = 1;
  `assert(out, 2);
  clock = 0;
  in = 2;
  `assert(out, 2);
  clock = 1;
  `assert(out, 2);
  clock = 0;
  in = 3;
  `assert(out, 2);
  clock = 1;
  `assert(out, 2);
  clock = 0;
  in = 0; 
  `assert(out, 2);
  clock = 1;
  `assert(out, 2);
  clock = 0;
  reset = 1;
  `assert(out, 0);

  // test G,G to win
  $display("Testing: G->G path");
  `simon_reset;
  in = 1;
  `assert(out, 0);

  clock = 1;
  `assert(out, 2);
  in = 0;
  `assert(out, 1);
  in = 2;
  `assert(out, 1);
  in = 3;
  `assert(out, 1);
  in = 1;
  `assert(out, 2);

  clock = 0;
  `assert(out, 2);
  in = 0;
  `assert(out, 1);
  in = 2;
  `assert(out, 1);
  in = 3;
  `assert(out, 1);
  in = 1;
  `assert(out, 2);

  clock = 1;
  `assert(out, 2);
  clock = 0;
  in = 0;
  `assert(out, 2);
  in = 2;
  `assert(out, 2);
  in = 3;
  `assert(out, 2);
  in = 1;
  `assert(out, 2);
  `assert(out, 2);
  clock = 1;

  `assert(out, 2);

  // test B, B to win
  $display("Testing: B->B path");
  `simon_reset;
  in = 2;
  `assert(out, 0);

  clock = 1;
  `assert(out, 2);
  in = 0;
  `assert(out, 1);
  in = 1;
  `assert(out, 1);
  in = 3;
  `assert(out, 1);
  in = 2;
  `assert(out, 2);

  clock = 0;
  `assert(out, 2);
  in = 0;
  `assert(out, 1);
  in = 1;
  `assert(out, 1);
  in = 3;
  `assert(out, 1);
  in = 2;
  `assert(out, 2);

  clock = 1;
  `assert(out, 2);
  clock = 0;
  in = 0;
  `assert(out, 2);
  in = 1;
  `assert(out, 2);
  in = 3;
  `assert(out, 2);
  in = 2;
  `assert(out, 2);
  `assert(out, 2);
  clock = 1;

  `assert(out, 2);

  // test Y, Y to win
  $display("Testing: Y->Y path");
  `simon_reset;
  `simon_reset;
  in = 3;
  `assert(out, 0);

  clock = 1;
  `assert(out, 2);
  in = 0;
  `assert(out, 1);
  in = 2;
  `assert(out, 1);
  in = 1;
  `assert(out, 1);
  in = 3;
  `assert(out, 2);

  clock = 0;
  `assert(out, 2);
  in = 0;
  `assert(out, 1);
  in = 2;
  `assert(out, 1);
  in = 1;
  `assert(out, 1);
  in = 3;
  `assert(out, 2);

  clock = 1;
  `assert(out, 2);
  clock = 0;
  in = 0;
  `assert(out, 2);
  in = 2;
  `assert(out, 2);
  in = 1;
  `assert(out, 2);
  in = 3;
  `assert(out, 2);
  `assert(out, 2);
  clock = 1;

  `assert(out, 2);

  // test R, G to lose
  $display("Testing: R->G path");
  `simon_reset;
  in = 0;
  `assert(out, 0);

  clock = 1;
  `assert(out, 2);

  clock = 0;
  in = 1;

  clock = 1;
  `assert(out, 1);
  clock = 0;

  `assert(out, 1);
  clock = 1;

  `assert(out, 1);

  // test lose state
  $display("Testing: Lose state");
  in = 1;
  `assert(out, 1);
  clock = 1;
  `assert(out, 1);
  clock = 0;
  in = 2;
  `assert(out, 1);
  clock = 1;
  `assert(out, 1);
  clock = 0;
  in = 3;
  `assert(out, 1);
  clock = 1;
  `assert(out, 1);
  clock = 0;
  in = 0; 
  `assert(out, 1);
  clock = 1;
  `assert(out, 1);
  clock = 0;
  reset = 1;
  `assert(out, 0);

  // test R, B to lose
  $display("Testing: R->B path");
  `simon_reset;
  in = 0;
  `assert(out, 0);

  clock = 1;
  `assert(out, 2);

  clock = 0;
  in = 2;
  
  clock = 1;
  `assert(out, 1);
  clock = 0;

  `assert(out, 1);
  clock = 1;

  `assert(out, 1);

  // test R, Y to lose
  $display("Testing: R->Y path");
  `simon_reset;
  in = 0;
  `assert(out, 0);

  clock = 1;
  `assert(out, 2);

  clock = 0;
  in = 3;
  
  clock = 1;
  `assert(out, 1);
  clock = 0;

  `assert(out, 1);
  clock = 1;

  `assert(out, 1);

  // test G, R to lose
  $display("Testing: G->R path");
  `simon_reset;
  in = 1;
  `assert(out, 0);

  clock = 1;
  `assert(out, 2);

  clock = 0;
  in = 0;
  
  clock = 1;
  `assert(out, 1);
  clock = 0;

  `assert(out, 1);
  clock = 1;

  `assert(out, 1);

  // test G, B to lose
  $display("Testing: G->B path");
  `simon_reset;
  in = 1;
  `assert(out, 0);

  clock = 1;
  `assert(out, 2);

  clock = 0;
  in = 2;
  
  clock = 1;
  `assert(out, 1);
  clock = 0;

  `assert(out, 1);
  clock = 1;

  `assert(out, 1);

  // test G, Y to lose
  $display("Testing: G->Y path");
  `simon_reset;
  in = 1;
  `assert(out, 0);

  clock = 1;
  `assert(out, 2);

  clock = 0;
  in = 3;
  
  clock = 1;
  `assert(out, 1);
  clock = 0;

  `assert(out, 1);
  clock = 1;

  `assert(out, 1);

  // test B, R to lose
  $display("Testing: B->R path");
  `simon_reset;
  in = 2;
  `assert(out, 0);

  clock = 1;
  `assert(out, 2);

  clock = 0;
  in = 0;
  
  clock = 1;
  `assert(out, 1);
  clock = 0;

  `assert(out, 1);
  clock = 1;

  `assert(out, 1);

  // test B, G to lose
  $display("Testing: B->G path");
  `simon_reset;
  in = 2;
  `assert(out, 0);

  clock = 1;
  `assert(out, 2);

  clock = 0;
  in = 1;
  
  clock = 1;
  `assert(out, 1);
  clock = 0;

  `assert(out, 1);
  clock = 1;

  `assert(out, 1);

  // test B, Y to lose
  $display("Testing: B->Y path");
  `simon_reset;
  in = 2;
  `assert(out, 0);

  clock = 1;
  `assert(out, 2);

  clock = 0;
  in = 3;
  
  clock = 1;
  `assert(out, 1);
  clock = 0;

  `assert(out, 1);
  clock = 1;

  `assert(out, 1);

  // test Y, R to lose
  $display("Testing: Y->R path");
  `simon_reset;
  in = 3;
  `assert(out, 0);

  clock = 1;
  `assert(out, 2);

  clock = 0;
  in = 0;
  
  clock = 1;
  `assert(out, 1);
  clock = 0;

  `assert(out, 1);
  clock = 1;

  `assert(out, 1);

  // test Y, G to lose
  $display("Testing: Y->G path");
  `simon_reset;
  in = 3;
  `assert(out, 0);

  clock = 1;
  `assert(out, 2);

  clock = 0;
  in = 1;
  
  clock = 1;
  `assert(out, 1);
  clock = 0;

  `assert(out, 1);
  clock = 1;

  `assert(out, 1);

  // test Y, B to lose
  $display("Testing: Y->B path");
  `simon_reset;
  in = 3;
  `assert(out, 0);

  clock = 1;
  `assert(out, 2);

  clock = 0;
  in = 2;
  
  clock = 1;
  `assert(out, 1);
  clock = 0;

  `assert(out, 1);
  clock = 1;

  `assert(out, 1);

  $display("All tests passed! Good job!");
  $display("Done...");
  $finish;
end

initial begin
   $dumpfile("simon1_test.vcd");
	 $dumpvars(0, simon1_tb);
end

/*always begin
   #10 clock = !clock;
end*/

endmodule

