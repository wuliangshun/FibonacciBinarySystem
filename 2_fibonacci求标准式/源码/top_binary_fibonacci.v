module top_binary_fibonacci(clk,rst,input_binary,begin_b_f,convert_done,fibonacci_standard);
    input clk;
	 input rst;
	 input [15:0] input_binary;
	 input begin_b_f;
	 output convert_done;
	 output wire [31:0]  fibonacci_standard;
	 wire [15:0] mema;
	 wire [9:0] cnt_a;
	 
	 mem_fibonacci RAM_fibonacci(
	   .rst (rst),
		.mema (mema),
		.cnt_a (cnt_a)
		);
	 
	 binary_fibonacci u_binary_fibonacci_out(
	 .clk (clk),
	 .rst (rst),
	 .input_binary (input_binary),
	 .begin_b_f (begin_b_f),
	 .convert_done (convert_done),
	 .fibonacci_standard (fibonacci_standard),
	 .mema (mema),
	 .cnt_a (cnt_a)
	 );
	 
	 
	 endmodule 