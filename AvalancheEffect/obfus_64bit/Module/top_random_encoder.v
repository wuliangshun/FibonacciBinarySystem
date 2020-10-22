module top_random_encoder(clk,rst,en_encode,input_binary,fibonacci_random,convert_done);
    input clk;
	 input rst;
	 input en_encode;
	 input [15:0]input_binary;
	 output wire [63:0] fibonacci_random;
	 output wire convert_done;
	 wire [9:0] cnt_a;
	 wire [15:0] mema;
	 
	 RAM_fibonacci u_RAM(
	     .rst    (rst), 
	     .cnt_a  (cnt_a),
		 .mema   (mema)
		  );  
	 random_encoder u_fibonacci_random(
	     .clk   (clk),
		  .rst   (rst),
		  .en_encode (en_encode),
		  .input_binary (input_binary),
		  .cnt_a            (cnt_a),
		  .mema             (mema),
		  .convert_done (convert_done),
		  .fibonacci_random (fibonacci_random)
		  );
		  
endmodule 
