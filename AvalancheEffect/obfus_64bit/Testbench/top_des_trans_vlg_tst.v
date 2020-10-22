
module top_des_trans_vlg_tst();
reg clk;
reg en;
reg [15:0] input_b;
reg rst;
// wires                                               
wire done_trans;
wire [15:0]  out_B;
wire receive;

integer i;
integer k;
wire done_input;

                        
top_des_trans i1 (
// port map - connection between master ports and signals/registers   
	.clk(clk),
	.done_trans(done_trans),
	.en(en),
	.input_b(input_b),
	.out_B(out_B),
	.receive(receive),
	.done_input (done_input),
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
	
	/*------------- Input of ------------- */
        // Reset         
	@(posedge clk) rst = 0; 
	for (k = 0; k < 2; k = k + 1) @(posedge clk);
	rst = 1;
	en = 1'b0; 
	for (k = 0; k < 2; k = k + 1) @(posedge clk);
	
	input_b= 16'b0000_0000_1010_0010;
	en = 1'b1; 
	for (k = 0; k < 1; k = k + 1) @(posedge clk);
	en = 1'b0; 
	
	wait (done_input == 1); 

 
	for (k = 0; k < 2; k = k + 1) @(posedge clk);
	

    
	
	input_b=16'b0000_0000_1001_0001;	
	en = 1'b1; 
	for (k = 0; k < 1; k = k + 1) @(posedge clk);
	en = 1'b0; 
	
	wait (done_trans == 1); 

	 
	for (k = 0; k < 5; k = k + 1) @(posedge clk);

	$display("input: %b, output: %b\n", input_b, out_B);
	

	
   $stop;
end	
                                               
endmodule




