module top_des_vlg_tst;

reg clk,reset,des_enable,des_mode;
reg [63:0] data_i,key_i;
wire [63:0] data_o;
wire ready_o;

integer i,k;
reg [63:0] base_i;
reg [63:0] base_o;
reg [63:0] temp;
reg [7:0] cnt;

des u_des_jia_mi(
		   .des_enable  (des_enable),
		   .des_mode	(des_mode),
			.clk (clk),
			.reset (reset),
			.data_i (data_i),
			.key_i  (key_i),
		   .data_o (data_o),
		   .ready_o (ready_o)
		);

initial clk=1'b0;
initial 
begin
	/* input: 0011101110011000110100101110111010101110101101100000000000110101 */
	$display("-----------------Encrypt--------------------*/");
   	@(posedge clk) reset=1'b0;  des_enable=1'b0; des_mode=1'b1;
    #20 reset=1'b1; des_enable=1'b1; des_mode=1'b0;
    data_i=64'b0011101110011000110100101110111010101110101101100000000000110101;
    key_i=64'h0123456789abcdef;
	wait (ready_o == 1); 
	$display("input: %h, binary: %b, output: %h, binary:%b\n", data_i, data_i, data_o, data_o);
	
	$display("-----------------Decrypt--------------------*/");
	#20
	reset=1'b0; des_enable=1'b0; des_mode=1'b1;
	#20 reset=1'b1; des_enable=1'b1; des_mode=1'b1;
	data_i=64'h6305e6ff626a4f0b;
	key_i=64'h0123456789abcdef;
	wait (ready_o == 1); 
	$display("input: %h, output: %h\n", data_i, data_o);

	$display("-----------------Test avalanche effect--------------------*/");
	base_i = 64'b0011101110011000110100101110111010101110101101100000000000110101;
	base_o = 64'b0110001100000101111001101111111101100010011010100100111100001011;
	for(i=0; i<64; i=i+1)
	begin		
		#20
		base_i = 64'b0011101110011000110100101110111010101110101101100000000000110101;
		reset=1'b0; des_enable=1'b0; des_mode=1'b1;
		base_i[i] = ~base_i[i];
		#20 reset=1'b1; des_enable=1'b1; des_mode=1'b0;
    	data_i = base_i[63:0];
   	 	key_i = 64'h0123456789abcdef;
		wait (ready_o == 1); 
		$display("input: %b, output: %b\n", data_i, data_o);
		temp = data_o^base_o;
		cnt = 8'b0;
		for(k=0; k<64; k=k+1)
		begin
			if(temp[k]!=0) cnt=cnt+1;
		end
		$display("xor:%b, cnt:%d\n", temp, cnt);
	end
	
	


	#20
	$stop;
end

always #10 clk=~clk;

endmodule

