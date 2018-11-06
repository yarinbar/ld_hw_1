module loop;
integer i;

initial begin
	for(i=0; i <10; i++)
		$display("%d", i);
	
end

endmodule
