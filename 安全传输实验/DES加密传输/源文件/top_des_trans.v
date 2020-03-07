module top_des_trans(clk,rst,en,out_B,input_b,done_trans,done_input,receive);
     input clk;
	  input rst;
	  input en;
	  input [15:0] input_b;
	  output wire done_trans;
	  output wire receive;
	  output wire done_input;
	  output [15:0] out_B;
	  wire [63:0]key;
	  wire en_des_jiemi;
	  wire en_des;
	  wire des_mode;
	  wire des_mode_jiemi;
	  wire [63:0] B;
	  wire spea;
	  wire [63:0] data_i;
	  wire [63:0] data_o;
	  
	  assign des_mode = ~en_des;
	  assign des_mode_jiemi = en_des_jiemi;
	  
	  comb u_comb(
	     .clk (clk),
		  .rst (rst),
		  .input_b (input_b),
		  .en   (en),
		  .done (done_input),
		  .out_S (key),
		  .out_data (data_i),
		  .done_comb (en_des)
		  
		  );
		  
		 des u_des_jia_mi(
		   .des_enable  (en_des),
		   .des_mode	(des_mode),
			.clk (clk),
			.reset (rst),
			.data_i (data_i),
			.key_i  (key),
		   .data_o (data_o),
		   .ready_o (en_des_jiemi)
		);
		
		   des u_des_jie_mi (
			.clk  (clk),
			.reset  (rst),
			.des_enable (en_des_jiemi),
			.des_mode (des_mode_jiemi),
			.data_i (data_o),
			.key_i (key),
			.data_o (B),
			.ready_o (en_spea)
			);
			
	  spea u_spea(
	   .clk (clk),
		.rst (rst),
		.en (en_spea),
		.input_B (B) ,
		.input_S (key),
		.out_b  (out_B),
		.done_spea (done_trans),
		.done (receive)
	  );
endmodule 