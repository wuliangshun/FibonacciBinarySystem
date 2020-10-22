
module top_random_encoder_vlg_tst();                                          

reg en_encode;
reg clk;
reg [15:0] input_binary;
reg rst;
// wires                                               
wire convert_done;
wire [15:0]  fibonacci_random;
integer i;
integer k;
                        
top_random_encoder i1 (
	.en_encode(en_encode),
	.clk(clk),
	.convert_done(convert_done),
	.fibonacci_random(fibonacci_random),
	.input_binary(input_binary),
	.rst(rst)
);
                                               
always
begin
	#10; 
	clk = 1'b1; 
	#10
	clk = 1'b0;
end
initial  
begin
	/* ------------- Input of 5 ------------- */
        // Reset         
	@(posedge clk) rst = 0; 
	for (k = 0; k < 2; k = k + 1) @(posedge clk);
	rst = 1;
	en_encode = 1'b0; 
	for (k = 0; k < 2; k = k + 1) @(posedge clk);
	
	// Inputs into module/ Assert begin_fibo
	input_binary = 5; 
	en_encode = 1'b1; 
	for (k = 0; k < 2; k = k + 1) @(posedge clk);
	en_encode = 1'b0; 
	
	// Wait until convert is done	
	wait (convert_done == 1); 

	// Idle cycles before next input 
	for (k = 0; k < 2; k = k + 1) @(posedge clk);

	
	$display("input: %d, output: %b\n", input_binary, fibonacci_random);


	/* ------------- Input of 9------------- */
	
	// Inputs into module/ Assert begin_fibo
	input_binary = 9; 
	en_encode = 1'b1; 
	for (k = 0; k < 2; k = k + 1) @(posedge clk);
	en_encode = 1'b0; 
	
	// Wait until calculation is done	
	wait (convert_done == 1); 

	// Idle cycles before next input 
	for (k = 0; k < 2; k = k + 1) @(posedge clk);

	
	
	$display("input: %d, output: %b\n", input_binary, fibonacci_random);
	
	
	input_binary = 17; 
	en_encode = 1'b1; 
	for (k = 0; k < 2; k = k + 1) @(posedge clk);
	en_encode = 1'b0; 
	
	// Wait until calculation is done	
	wait (convert_done == 1); 

	// Idle cycles before next input 
	for (k = 0; k < 2; k = k + 1) @(posedge clk);

	$display("input: %d, output: %b\n", input_binary, fibonacci_random);

	/*------------- Input of 70------------- */

	input_binary = 105; 
	en_encode = 1'b1; 
	for (k = 0; k < 2; k = k + 1) @(posedge clk);
	en_encode = 1'b0; 
	
	// Wait until calculation is done	
	wait (convert_done == 1); 

	// Idle cycles before next input 
	for (k = 0; k < 2; k = k + 1) @(posedge clk);

	$display("input: %d, output: %b\n", input_binary, fibonacci_random);
	
	
	


 
	/* ------------- Input of 105------------- */
  
	
	// Inputs into module/ Assert begin_fibo
	input_binary = 105; 
	en_encode = 1'b1; 
	for (k = 0; k < 2; k = k + 1) @(posedge clk);
	en_encode = 1'b0; 
	
	// Wait until calculation is done	
	wait (convert_done == 1); 

	// Idle cycles before next input 
	for (k = 0; k < 2; k = k + 1) @(posedge clk);

	
	$display("input: %d, output: %b\n", input_binary, fibonacci_random);

	$stop;
end 
  

                                    
endmodule

