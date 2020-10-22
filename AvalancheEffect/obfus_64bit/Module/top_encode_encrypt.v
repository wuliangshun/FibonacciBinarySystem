module top_encode_encrypt(clk,rst,en_encode,input_binary,des_mode,key_i,data_o,ready_o);
		
	 input clk;
	 input rst;
	 input en_encode;
	 input [15:0]input_binary;		
     input des_mode;
     input [63:0] key_i;
     output wire [63:0] data_o;
	 output wire ready_o;
     //wires
	 wire convert_done;
     wire [63:0]fibonacci_random;
     
     top_random_encoder u_top_random_encoder(
		.clk                 (clk),
		.rst                 (rst),
		.en_encode           (en_encode),
		.input_binary        (input_binary),
		.fibonacci_random    (fibonacci_random),
		.convert_done        (convert_done)
	 );
		
	 des u_des_jiami(
		.clk                 (clk),
	    .des_enable          (convert_done),
	    .reset               (rst),
	    .des_mode            (des_mode),
		.data_i              (fibonacci_random),
		.key_i               (key_i),
		.data_o              (data_o),
		.ready_o             (ready_o)
	);		

endmodule
