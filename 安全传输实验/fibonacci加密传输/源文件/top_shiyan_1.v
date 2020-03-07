module top_shiyan_1(clk,rst,input_binary,done_input,all_done,en_shiyan,out_b);
    input clk;
	 input rst;
	 input en_shiyan;
	 input [15:0] input_binary;
	 output wire done_input;
	 output wire [31:0] out_b;
	 output wire all_done;
	 
	 wire [31:0] fibonacci_random;
	 wire [63:0] F;
	 wire [63:0] S;
	 wire [31:0] f;
	 
	 wire [31:0] mem1;
	 wire [31:0] mem2;
	 wire [9:0] cnt_1;
	 wire [9:0] cnt_2;
	 
	 wire b_f_done;
	 wire convert_done;
	 wire done_jiezhi;
	 wire en_hui_fu;
	 wire en_convert;
	 
	 
	 assign en_hui_fu = done_jiezhi || convert_done;
	 
	  fibonacci_random u_fibonacci_random(
	        .clk   (clk),
			  .rst   (rst),
			  .begin_b_f (en_shiyan),
			  .input_bin (input_binary),
			  .fibonacci_random (fibonacci_random),
			  .convert_done (b_f_done),
			  .mema  (mem2),
			  .cnt_a (cnt_2)
			  );
		
	 jiezhi_chuan u_jiezhi_chuan(
	    .clk (clk),
		 .rst  (rst),
		 .input_f  (fibonacci_random),
		 .out_S   (S),
		 .out_F   (F),
		 .en      (b_f_done),
		 .done_jiezhi    (done_jiezhi),
		 .done           (done_input)
     );
	
     hui_fu 	u_hui_fu(
	    .clk  (clk),
		 .rst  (rst),
		 .en   (en_hui_fu),
		 .input_F  ( F ),
		 .input_S  ( S ),
		 .out_f    ( f ),
		 .done_hui_fu  (all_done),
		 .done (en_convert)
		 
	 );
	 
	 fibonacci_binary u_fibonacci_binary(
	     .clk (clk),
		  .rst (rst),
		  .input_f  (  f  ),
		  .en_convert (en_convert),
		  .convert_done (convert_done),
		  .f_b_out  (out_b),
		  .mema (mem1),
		  .cnt_a (cnt_1)
		  );
		  
	mem_fibonacci RAM_fibonacci(
        .rst   (rst),	
		  .mem1   (mem1),
		  .mem2   (mem2),
		  .cnt_1  (cnt_1),
		  .cnt_2  (cnt_2)
		  );
		    
	 endmodule 