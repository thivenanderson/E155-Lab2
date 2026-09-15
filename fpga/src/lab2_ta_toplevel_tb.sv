`timescale 1 ns/1 ns

module lab1_ta_toplevel_tb ();

       logic [3:0] s1;
       logic [3:0] s2;
       logic reset;
       logic enable;
       logic [3:0] col;
	   logic [1:0] anode;
       logic [6:0] seg;
	   logic [3:0] led;
	   logic [3:0] scanner;



    lab2_ta #(.WIDTH(3), .MAX_COUNT(5)) dut (
            .s1(s1),  .s2(s2),
            .reset(reset), .enable(enable),
            .col(col),  
			.anode(anode),
			.seg(seg),
			.led(led), .scanner(scanner)

);



    // apply stimuli and check outputs



initial begin

	s1 = 4'b0001;
	s2 = 4'b1000;
	col = 4'b1110;


    reset = 0;
	enable=1;
    repeat (2) @(posedge dut.int_osc);

	reset = 1;



	//Test scanning module connection and column assert logic

	#1;

	assert ( scanner == 4'b1000)
		$display("Passed! The top level module successfully connected to the scanner at time: %0t.", $time); 
	else 
		$error("FAILED! The scanner module behaves incorrectly at time: %0t.", $time); 
				
	assert ( led == 4'b0001)
		$display("Passed! The top level module successfully blinked the correct leds at time: %0.t", $time); 
	else 
		$error("FAILED! The top level module blinked the incorrect leds at time: %0t.", $time); 

	//Test dual seg display

	assert (dut.dig_s == 1'b0)

		$display("PASSED! The top level module successfully assigned the correct digit select signal: %0t.", $time);

	else 

		$error("FAILED! The top level module failed to assign the correct digit select: %0t.", $time); 



	#1

	assert (dut.s == 4'b0001)

		$display("PASSED! The top level module successfully selected the correct digit input: %0t.", $time);

	else 

		$error("FAILED! The top level module failed to select the correct digit input: %0t.", $time);

	assert (anode == 2'b10)

		$display("PASSED! The top level module successfully turned on the correct digit: %0t.", $time);

	else 

		$error("FAILED! The top level module failed to turn on the correct digit: %0t.", $time); 



	repeat(3) @ (posedge dut.int_osc);

	  #1;



	assert (dut.dig_s == 1'b1)

		$display("PASSED! The top level module successfully assigned the correct digit select signal: %0t.", $time);

	else 

		$error("FAILED! The top level module failed to assign the correct digit select: %0t.", $time); 



	#1

	assert (dut.s == 4'b1000)

		$display("PASSED! The top level module successfully selected the correct digit input: %0t.", $time);

	else 

		$error("FAILED! The top level module failed to select the correct digit input: %0t.", $time);

	assert (anode == 2'b01)

		$display("PASSED! The top level module successfully turned on the correct digit: %0t.", $time);

	else 

		$error("FAILED! The top level module failed to turn on the correct digit: %0t.", $time); 
	#10;
	$stop;
	end
endmodule

