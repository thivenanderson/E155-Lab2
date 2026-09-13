//Name: Thiven Anderson
//Email: thanderson@g.hmc.edu
//Date: 9/12/2026
//Description: Top level module for lab 2 of E155
module lab2_ta (
    input  logic [3:0] s1, s2,
	input logic reset, enable,
   // output logic [3:0] led,
	output logic [1:0] anode,
    output logic [6:0] seg
);

    logic int_osc, dig_s;
	logic [3:0] s;
	localparam int MAX_COUNT = 200_000;
	localparam int WIDTH = 18;
	logic [WIDTH-1:0] counter;

    // Internal oscillator
    HSOSC #(.CLKHF_DIV(2'b01))
        hf_osc (
            .CLKHFPU(1'b1),
            .CLKHFEN(1'b1),
            .CLKHF(int_osc)
        );
	//Dual display mux logic
	lab2_ta_counter #(
    .WIDTH(WIDTH),
    .MAX_COUNT(MAX_COUNT) 	 	
		)count(
        .clk(int_osc),
		.reset(reset),
		.enable(enable),
		.counter(counter)
    );
	assign dig_s = (counter >= MAX_COUNT/2);
	assign s = dig_s ? s2 : s1;
	assign anode = dig_s ? 2'b01 : 2'b10;
    // 7-segment decoder
    lab1_ta_hex_seg_decoder decoder (
        .s(s),
        .seg(seg)
    );	
	
	endmodule