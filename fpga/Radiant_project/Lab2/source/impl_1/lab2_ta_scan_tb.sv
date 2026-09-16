`timescale 1 ns/1 ns
module lab2_ta_scan_tb ();
    logic [3:0] scanner;
    logic clk;
	logic reset;
	logic enable;

	
	
	    lab2_ta_scan #(.WIDTH(4), .MAX_COUNT(11)) dut (
        .clk(clk),
		.reset(reset),
		.enable(enable),
		.scanner(scanner)
	);
	
	  // generate clock
  always begin
      clk = 0; #5;
      clk = 1; #5;
  end
	
    // apply stimuli and check outputs	
initial begin

    reset = 0;
	enable=1;
    repeat (2) @(posedge clk);

	reset = 1;
	#1;
	assert ( scanner == 4'b1000)
	$display("Passed! The scanner module behaves as desired at time: %0t.", $time); 
	else 
            $error("FAILED! The scanner module behaves incorrectly at time: %0t.", $time); 
			
	repeat (3) @ (posedge clk);
	
		#1;
	assert ( scanner == 4'b0100)
	$display("Passed! The scanner module behaves as desired at time: %0t.", $time); 
	else 
            $error("FAILED! The scanner module behaves incorrectly at time: %0t.", $time); 
			
	repeat (3) @ (posedge clk);
	
		#1;
	assert ( scanner == 4'b0010)
	$display("Passed! The scanner module behaves as desired at time: %0t.", $time); 
	else 
            $error("FAILED! The scanner module behaves incorrectly at time: %0t.", $time); 
			
	repeat (3) @ (posedge clk);
		#1;
		
	assert ( scanner == 4'b0001)
	$display("Passed! The scanner module behaves as desired at time: %0t.", $time); 
	else 
            $error("FAILED! The scanner module behaves incorrectly at time: %0t.", $time); 
	reset =0;
	#1;

	assert ( scanner == 4'b1000)
	$display("Passed! The scanner module behaves as desired at time: %0t.", $time); 
	else 
            $error("FAILED! The scanner module behaves incorrectly at time: %0t.", $time); 
	reset =1;
	#1
		repeat (3) @ (posedge clk);
	
		#1;
	enable = 0;
	assert ( scanner == 4'b0100)
	$display("Passed! The scanner module behaves as desired at time: %0t.", $time); 
	else 
            $error("FAILED! The scanner module behaves incorrectly at time: %0t.", $time); 
			
	#10;
	$stop;
	end
	
	
endmodule
