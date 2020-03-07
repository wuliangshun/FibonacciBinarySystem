module fibonacci_binary(clk,rst,input_f,en_convert,convert_done,f_b_out,mema,cnt_a);
   input clk;
	input rst;
	input en_convert;
	input [31:0] input_f;
	input [15:0] mema;
	output reg convert_done;
	output reg [9:0]cnt_a; 
	output reg [31:0] f_b_out;
	
	reg [31:0] f_b;
	reg done;
	reg [1:0] current_state;
	reg [1:0] next_state;
	parameter IDLE=2'b00;
	parameter BEGIN_SUM=2'b01;
	
	
	
	always @(posedge clk or negedge rst) begin
	         if(!rst)
				  current_state<=IDLE;
				else
				  current_state<=next_state;
		  end 
	
	always @(*) begin 
	         if(!rst)
				   next_state = IDLE;
				else begin
				   case(current_state)
					   IDLE: begin
						         if(done==1)
									   next_state = BEGIN_SUM;
									else
									   next_state = IDLE;
								end 
						BEGIN_SUM: begin
						          if(convert_done==1)
									    next_state = IDLE;
									 else
									    next_state = BEGIN_SUM;
								 end 
						
						 default : next_state = IDLE;			
						endcase
				end 
		  end 
   always @(posedge clk or negedge rst) begin 
	         if(!rst)
				  begin
				    f_b_out<=0;
				    convert_done<=0;
					 done<=0;
					 cnt_a<=0;
					 f_b<=0;
				  end
				else
			      begin 
					  done<=0;
				     case(next_state)
					     IDLE: begin
						           convert_done<=0;
									  f_b<=0;
									  cnt_a<=0;
						           if(en_convert==1)
									    done<=1;
									  else 
									    done<=0;
								  end 
						  BEGIN_SUM: begin
						            if(cnt_a<=31)    //此时允许输入fibolacci进制最高为32位
										   begin 
											  if(input_f[cnt_a]==1)
											    begin 
											      done<=1;
													f_b<=f_b+mema;
													cnt_a<=cnt_a+1;
												 end 
											  else
											     cnt_a<=cnt_a+1;
											end 
										else
										   begin 
										     cnt_a<=0;
									    	  convert_done<=1;
											  f_b_out<= f_b;
											end 
									end
							endcase 
		  end 
		 end
endmodule 