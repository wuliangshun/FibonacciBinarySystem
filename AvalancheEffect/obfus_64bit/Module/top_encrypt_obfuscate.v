module top_encrypt_obfuscate(clk,rst,en_encode,input_binary,done_trans,receive,done_input,out_B);

	 input clk;
	 input rst;
	 input en_encode;
	 input [15:0]input_binary;
     
     wire convert_done;
     wire [15:0]fibonacci_random;
     
     output wire done_trans;
	 output wire receive;
	 output wire done_input;
	 output wire [15:0]out_B;

	 top_random_encoder u_top_random_encoder(
		.clk                 (clk),
		.rst                 (rst),
		.en_encode           (en_encode),
		.input_binary        (input_binary),
		.fibonacci_random    (fibonacci_random),
		.convert_done        (convert_done)
	 );

	 top_des_trans u_top_des_trans(
		.clk                 (clk),
		.rst                 (rst),
		.en                  (convert_done),
        .input_b             (fibonacci_random),
		.out_B               (out_B),
		.done_trans          (done_trans),
		.done_input          (done_input),
		.receive             (receive)
     );




endmodule
