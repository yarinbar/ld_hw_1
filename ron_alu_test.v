module ALU_tb;

  `define assert(val, exp)\
     #20\
     if (!(exp === val)) begin\
       $display("Assertion failed on line %0d of %s - expected: %0d, received: %0d",\
       `__LINE__, `__FILE__, exp, val);\
       $finish;\
     end

reg [31:0] a, b;
reg [2:0] alu_control;
wire [31:0] out;

ALU u0 (a, b, alu_control, out);

initial begin
  a = 32'd2;
  b = 32'd2;
  alu_control = 3'd0;
  $display("Starting simulation...");

  // testing ADD
  `assert(out, 4);
  a = 5;
  `assert(out, 7);
  b = -4;
  `assert(out, 1);
  a = 4; // will overflow
  `assert(out, 0);

  // testing SUB
  alu_control = 1;
  `assert(out, 8);
  a = 10;
  b = 6;
  `assert(out, 4);
  b = 15;
  `assert(out, -5);
  `assert(out, 4294967291); // that's actually the same number 
  a = 30;
  `assert(out, 15);

  // testing AND
  a = 10;
  alu_control = 2;
  `assert(out, 10);
  a = 0;
  `assert(out, 0);
  a = 31;
  `assert(out, 15);
  b = 0; 
  `assert(out, 0);
  a = 53245;
  b = 71717;
  `assert(out, 2085);

  // testing OR
  alu_control = 3;
  `assert(out, 122877);
  a = 0;
  `assert(out, 71717);
  b = 0;
  `assert(out, 0);
  a = 32;
  `assert(out, 32);
  
  // testing NOR
  alu_control = 4;
  `assert(out, -33);
  a = 1;
  b = 0;
  `assert(out, -2);
  a = 0;
  `assert(out, -1);
  b = 1;
  `assert(out, -2);
  a = 32'hFFFFFFFF;
  `assert(out, 0);
  a = -1;
  `assert(out, 0);
  b = 50;
  `assert(out, 0);

  // testing XOR
  a = 10;
  b = 15;
  alu_control = 5;
  `assert(out, 5);
  a = 0;
  `assert(out, 15);
  b = 3;
  `assert(out, 3);
  b = 0;
  `assert(out, 0);
  a = 8;
  `assert(out, 8);
  b = 1;
  `assert(out, 9);
  a = 9;
  `assert(out, 8);
  b = -1;
  `assert(out, -10); 
  a = -1;
  `assert(out, 0);
  a = 50;
  b = 50;
  `assert(out, 0);
  b = 51;
  `assert(out, 1);

  // testing invalud alu_control
  alu_control = 6;
  `assert(out, {32{1'bx}});
  a = 4;
  `assert(out, {32{1'bx}});
  b = 2;
  `assert(out, {32{1'bx}});
  a = 3;
  b = 5;
  `assert(out, {32{1'bx}});
  alu_control = 7;
  `assert(out, {32{1'bx}});
  a = 4;
  `assert(out, {32{1'bx}});
  b = 2;
  `assert(out, {32{1'bx}});
  a = 3;
  b = 5;
  `assert(out, {32{1'bx}});

  $display("All tests passed! Good job!");

  $display("Done...");
  $finish;
end

initial begin
   //$monitor("At time %t, control = %0d, out = %0d", $time, alu_control, out);
   $dumpfile("ALU_test.vcd");
	 $dumpvars(0, ALU_tb);
end


endmodule // test

