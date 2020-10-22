module top_fibonacci_random(clk,rst,begin_b_f,input_bin,fibonacci_random,convert_done);
    input clk;
	 input rst;
	 input begin_b_f;
	 input [15:0]input_bin;
	 output wire [31:0] fibonacci_random;
	 output wire convert_done;
	 wire [9:0] cnt_a;
	 wire [15:0] mema;
	 
	 mem_fibonacci u_RAM(
	     .rst    (rst), 
	     .cnt_a  (cnt_a),
		  .mema   (mema)
		  );  
	 fibonacci_random u_fibonacci_random(
	     .clk   (clk),
		  .rst   (rst),
		  .begin_b_f (begin_b_f),
		  .input_bin (input_bin),
		  .cnt_a            (cnt_a),
		  .mema             (mema),
		  .convert_done (convert_done),
		  .fibonacci_random (fibonacci_random)
		  );
		  
endmodule 