module top_encrypt_obfuscate_vlg_tst();

reg en_encode;
reg clk;
reg [15:0] input_binary;
reg rst;
// wires 
wire done_trans;
wire receive;
wire done_input;
wire [15:0]out_B;                                              

integer i;
integer k;

top_encrypt_obfuscate il (
	.en_encode(en_encode),
	.clk(clk),
	.rst(rst),
	.input_binary(input_binary),
	.done_trans(done_trans),
	.receive(receive),
	.done_input(done_input),
	.out_B(out_B)
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
	input_binary = 11; 
	en_encode = 1'b1; 
	for (k = 0; k < 4; k = k + 1) @(posedge clk);
	en_encode = 1'b0; 
	
	// Wait until done	
	wait (done_trans == 1); 

	// Idle cycles before next input  
	for (k = 0; k < 5; k = k + 1) @(posedge clk);


	
	$display("input: %d, output: %b\n", input_binary, out_B);


end


endmodule
