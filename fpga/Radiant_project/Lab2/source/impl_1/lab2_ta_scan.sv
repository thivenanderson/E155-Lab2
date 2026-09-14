//Name: Thiven Anderson
//Email: thanderson@g.hmc.edu
//Date: 9/13/2026
//Description: Scanning module using generic counter and output logic

module lab2_ta_scan #(
		parameter WIDTH = 24,
		parameter MAX_COUNT = 11_999_999)(
	input logic clk, reset, enable,
	output logic [3:0] scanner
	);
	
	
	logic [WIDTH-1:0] counter;
	//instantiate counter module
		lab2_ta_counter #(
    .WIDTH(WIDTH),
    .MAX_COUNT(MAX_COUNT) 	 	
		)count(
        .clk(clk),
		.reset(reset),
		.enable(enable),
		.counter(counter)
    );
	
	//output logic
	
	assign scanner[3] = (counter <= MAX_COUNT/4);
	assign scanner[2] = (counter > MAX_COUNT/4 && counter<= MAX_COUNT/2);
	assign scanner[1] = (counter > MAX_COUNT/2 && counter<= 3*MAX_COUNT/4);
	assign scanner[0] = (counter > 3*MAX_COUNT/4);
	
	endmodule