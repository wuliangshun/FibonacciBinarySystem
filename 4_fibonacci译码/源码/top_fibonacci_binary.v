module top_fibonacci_binary(clk,rst,en_convert,convert_done,input_f,f_b_out);
       input clk;
		 input rst;
		 input en_convert;
		 input [31:0] input_f;
		 output wire convert_done;
		 output wire [31:0] f_b_out;
		 wire [15:0] mema;
		 wire [9:0] cnt_a;
		 
		 mem_fibonacci RAM_fibonacci(
		    .rst (rst),
		    .mema (mema),
			 .cnt_a (cnt_a)
			 );
		fibonacci_binary u_fibonacci_binary(
		    .clk   (clk),
			 .rst   (rst),
			 .en_convert (en_convert),
			 .input_f  (input_f),
			 .convert_done (convert_done),
			 .mema  (mema),
			 .cnt_a  (cnt_a),
			 .f_b_out (f_b_out)
			 );
	endmodule 