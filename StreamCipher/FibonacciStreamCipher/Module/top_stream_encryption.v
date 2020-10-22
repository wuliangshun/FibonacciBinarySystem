module top_stream_encryption(clk,rst,en,C,all_done,out_c);
       input clk;
		 input rst;
		 input en;
		 output wire [31:0] C;
		 output wire all_done;
		 output wire out_c;
		 
		 wire [15:0] N_count;
		 wire [15:0] M_count;
		 wire [31:0] N_fibonacci;
		 wire [31:0] M_fibonacci;
		 wire N_convert_done;
		 wire M_convert_done;
		 wire en_b_f;
		 
		 wire [15:0] mem1;
		 wire [15:0] mem2;
		 wire [9:0] cnt_1;
		 wire [9:0] cnt_2;
		 
		 stream_encryption u_stream_encryption(
		     .clk  (clk),
			  .rst  (rst),
			  .en (en),
			  .en_b_f (en_b_f),
			  .N_count (N_count),
			  .M_count (M_count),
			  .N_fibonacci (N_fibonacci),
			  .M_fibonacci (M_fibonacci),
			  .N_convert_done (N_convert_done),
			  .M_convert_done (M_convert_done),
			  .all_done (all_done),
			  .C(C),
			  .out_c (out_c)
			  );
			  
			  
		 binary_fibonacci N_convert(
		     .clk  (clk),
			  .rst  (rst),
			  .begin_b_f (en_b_f),
			  .input_binary (N_count),
			  .fibonacci_standard (N_fibonacci),
			  .convert_done  (N_convert_done),
			  .mema (mem1),
			  .cnt_a (cnt_1)
		 );
		 
		  binary_fibonacci M_convert(
		     .clk  (clk),
			  .rst  (rst),
			  .begin_b_f (en_b_f),
			  .input_binary (M_count),
			  .fibonacci_standard (M_fibonacci),
			  .convert_done  (M_convert_done),
			  .mema (mem2),
			  .cnt_a (cnt_2)
		 );
		 
		 mem_fibonacci u_mem_fibonacci(
		     .rst   (rst),
			  .mem1  (mem1),
			  .mem2  (mem2),
			  .cnt_1 (cnt_1),
			  .cnt_2 (cnt_2)
			  );
		 
		 endmodule 