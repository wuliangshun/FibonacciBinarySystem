module des_f(input clk,
		     input reset,
			 input des_mode,
		     input [3:0] inter_num_i,
		     input [1:32] R_i,
			 input [1:32] L_i,
			 input [1:56] Key_i,
			 output reg [1:32] R_o,
			 output reg [1:32] L_o,
			 output reg [1:56] Key_o);
	  
	reg [1:32] next_R;
	//reg [31:0] R_i_var;
	wire [1:48] expandedR;
	reg [1:56] pre_key;
	reg [1:48] new_key_tmp;
	reg [3:0] inter_num;
	wire [1:32] p;
	reg [1:48] address_s;
	reg [1:32] Soutput;
	wire [1:32] Soutput_wire;
	wire [1:48] new_key;
	wire [1:56] out_key;
	
	key_get  key_get(.pre_key(pre_key), .des_mode(des_mode), .inter_num(inter_num), .new_key(new_key), .out_key(out_key));
	s1 sbox1(.stage1_input(address_s[1:6]), .stage1_output(Soutput_wire[1:4]));
	s2 sbox2(.stage1_input(address_s[7:12]), .stage1_output(Soutput_wire[5:8]));
	s3 sbox3(.stage1_input(address_s[13:18]), .stage1_output(Soutput_wire[9:12]));
	s4 sbox4(.stage1_input(address_s[19:24]), .stage1_output(Soutput_wire[13:16]));
	s5 sbox5(.stage1_input(address_s[25:30]), .stage1_output(Soutput_wire[17:20]));
	s6 sbox6(.stage1_input(address_s[31:36]), .stage1_output(Soutput_wire[21:24]));
	s7 sbox7(.stage1_input(address_s[37:42]),  .stage1_output(Soutput_wire[25:28]));
	s8 sbox8(.stage1_input(address_s[43:48]),   .stage1_output(Soutput_wire[29:32]));
	
	always @(posedge clk or negedge reset)
	begin
		if(reset == 1'b0)
		begin
			R_o <= 32'd0;
			L_o <= 32'd0;
			Key_o <= 56'd0;
		end
		else
		begin
			Key_o <= out_key;
			if(inter_num == 4'b1111)
			begin
			R_o <= R_i;
			L_o <= next_R;			
			end
			else
			begin
			R_o <= next_R;
			L_o <= R_i;
			end			
		end
	end
	
	assign   expandedR  ={R_i[32],R_i[1],R_i[2],R_i[3],R_i[4],R_i[5],

			              		 	R_i[4],R_i[5],R_i[6],R_i[7],R_i[8],R_i[9],

					              R_i[8],R_i[9],R_i[10],R_i[11],R_i[12],R_i[13],

					              R_i[12],R_i[13],R_i[14],R_i[15],R_i[16],R_i[17],

				              		R_i[16],R_i[17],R_i[18],R_i[19],R_i[20],R_i[21],

				               	R_i[20],R_i[21],R_i[22],R_i[23],R_i[24],R_i[25],

				              		R_i[24],R_i[25],R_i[26],R_i[27],R_i[28],R_i[29],

				              		R_i[28],R_i[29],R_i[30],R_i[31],R_i[32],R_i[1]};
	
	assign    p = {Soutput[16],Soutput[7],Soutput[20],Soutput[21],

				         Soutput[29],Soutput[12],Soutput[28],Soutput[17],

			           Soutput[1],Soutput[15],Soutput[23],Soutput[26],

				         Soutput[5],Soutput[18],Soutput[31],Soutput[10],

			           Soutput[2],Soutput[8],Soutput[24],Soutput[14],

				         Soutput[32],Soutput[27],Soutput[3],Soutput[9],

				         Soutput[19],Soutput[13],Soutput[30],Soutput[6],

				         Soutput[22],Soutput[11],Soutput[4],Soutput[25]};  
	
	always @(*)
	begin
	pre_key = Key_i;
	inter_num = inter_num_i;
	
	new_key_tmp = new_key;
	
	address_s = new_key_tmp ^ expandedR;
	Soutput = Soutput_wire;
	
	next_R = (L_i^p); 
	end

endmodule
