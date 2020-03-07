module  des(input clk,
			    input des_enable,
			    input reset,
			    input des_mode,
		        input [1:64] data_i,
		        input [1:64] key_i,
			    output wire [1:64] data_o,
				output ready_o);
	
	
	wire [3:0] inter_num_curr;
	wire [1:32] R_i_var, L_i_var;
	wire [1:56] Key_i_var_out;
	wire [1:64] data_o_var_t;
	wire [1:32] R_i, L_i;
	wire [1:32] R_o, L_o;
	wire [1:56] Key_o;
	wire [1:28] C0, D0;

	
	IP IP1(.in(data_i), 
	       .L_i_var(L_i_var),
	       .R_i_var(R_i_var));
	IP_ni	IP_ni(.in(data_o_var_t), 
	            .out(data_o));	
	pc_1 pc_1(.key_i(key_i), 
	          .C0(C0), 
	          .D0(D0));
	//F(R,K)
	des_f  des_f1(.clk(clk), 
	              .reset(reset),
				        .des_mode(des_mode),
	              .inter_num_i(inter_num_curr),
	              .R_i(R_i), 
				        .L_i(L_i), 
				        .Key_i(Key_i_var_out), 
			       	  .R_o(R_o), .L_o(L_o), 
				        .Key_o(Key_o)); 
	//contral 16 F(R,K)
	contrl contrl1(.data_o_var_t(data_o_var_t),
				         .inter_num_curr(inter_num_curr),
		             .Key_i_var_out(Key_i_var_out),
		             .R_i(R_i),
		             .L_i(L_i),
		             .ready_o(ready_o),
		             .L_o(L_o),
		             .R_o(R_o),
		             .R_i_var(R_i_var),
		             .L_i_var(L_i_var),
			           .Key_o(Key_o),
		             .C0(C0),
		             .D0(D0),
		             .clk(clk),
		             .reset(reset),
					       .des_enable(des_enable));
		
endmodule	
