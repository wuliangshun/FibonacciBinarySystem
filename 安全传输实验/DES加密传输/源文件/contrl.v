module contrl(output [1:64] data_o_var_t,
			        output reg [3:0] inter_num_curr,
		          output reg [1:56] Key_i_var_out,
		          output reg [1:32] R_i, L_i,
		          output reg ready_o,
		          input [1:32] L_o,
		          input [1:32] R_o,
		          input [1:32] R_i_var, L_i_var,
			        input [1:56] Key_o,
		          input [1:28] C0, D0,
		          input clk, reset, des_enable);

  reg [3:0] inter_num_next;

	assign data_o_var_t = (ready_o == 1'b1)?{L_o,R_o}:64'hzzzzzzzzzzzzzzzz;
	
	always @(posedge clk or negedge reset)
		if(reset == 1'b0)
			begin  
				inter_num_curr <= 4'd0; 
			end
		else  if(des_enable)
				begin
				if(ready_o == 1'b0)
					inter_num_curr <= inter_num_next;
				end
				
	always @(posedge clk or negedge reset)
		  begin
			if(reset == 1'b0)	ready_o <= 1'b0;
			else if(inter_num_curr == 4'd15)  ready_o <= 1'b1;
				 else ready_o <= 1'b0;
		  end
			 
		always @(*)	
		   if(!reset)
			  inter_num_next =4'd0;
			else 
		    begin
				case(inter_num_curr)
				4'd0:begin
						//ready_o = 1'b0; 
						 R_i = R_i_var;
						 L_i = L_i_var;
						 Key_i_var_out = {C0, D0};
						 inter_num_next = 4'd1;
					   end
				4'd1: begin
						//ready_o = 1'b0; 
						R_i = R_o;
						L_i = L_o;
						Key_i_var_out = Key_o;
						inter_num_next = 4'd2;
						end
				4'd2: begin
						//ready_o = 1'b0; 
						R_i = R_o;
						L_i = L_o;
						Key_i_var_out = Key_o;
						inter_num_next = 4'd3;
						end
				4'd3: begin
						//ready_o = 1'b0; 
						R_i = R_o;
						L_i = L_o;
						Key_i_var_out = Key_o;
						inter_num_next = 4'd4;
						end
				4'd4: begin
						//ready_o = 1'b0; 
						R_i = R_o;
						L_i = L_o;
						Key_i_var_out = Key_o;
						inter_num_next = 4'd5;
						end
				4'd5: begin
						//ready_o = 1'b0; 
						R_i = R_o;
						L_i = L_o;
						Key_i_var_out = Key_o;
						inter_num_next = 4'd6;
						end
				4'd6: begin
						//ready_o = 1'b0; 
						R_i = R_o;
						L_i = L_o;
						Key_i_var_out = Key_o;
						inter_num_next = 4'd7;
						end						
				4'd7: begin
						//ready_o = 1'b0; 
						R_i = R_o;
						L_i = L_o;
						Key_i_var_out = Key_o;
						inter_num_next = 4'd8;
						end
				4'd8: begin
						//ready_o = 1'b0; 
						R_i = R_o;
						L_i = L_o;
						Key_i_var_out = Key_o;
						inter_num_next = 4'd9;
						end
				4'd9: begin
						//ready_o = 1'b0; 
						R_i = R_o;
						L_i = L_o;
						Key_i_var_out = Key_o;
						inter_num_next = 4'd10;
						end
				4'd10: begin
						//ready_o = 1'b0; 
						R_i = R_o;
						L_i = L_o;
						Key_i_var_out = Key_o;
						inter_num_next = 4'd11;
						end	
				4'd11: begin
						//ready_o = 1'b0; 
						R_i = R_o;
						L_i = L_o;
						Key_i_var_out = Key_o;
						inter_num_next = 4'd12;
						end
				4'd12: begin
						//ready_o = 1'b0; 
						R_i = R_o;
						L_i = L_o;
						Key_i_var_out = Key_o;
						inter_num_next = 4'd13;
						end	
				4'd13: begin
						//ready_o = 1'b0; 
						R_i = R_o;
						L_i = L_o;
						Key_i_var_out = Key_o;
						inter_num_next = 4'd14;
						end						
				4'd14: begin
						//ready_o = 1'b0; 
						R_i = R_o;
						L_i = L_o;
						Key_i_var_out = Key_o;
						inter_num_next = 4'd15;
						end
				4'd15:if(ready_o == 1'b0)
				      begin
					    R_i = R_o;  
					    L_i = L_o;
					    Key_i_var_out = Key_o;
						//ready_o = 1'b1; 
					   end
			  endcase
		end
		
endmodule
