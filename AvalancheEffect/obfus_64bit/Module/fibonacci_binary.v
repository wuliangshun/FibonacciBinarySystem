module fibonacci_binary(clk,rst,input_f,en_convert,convert_done,f_b_out);
   input clk;
	input rst;
	input en_convert;
	input [31:0] input_f;
	output reg convert_done;
	output reg [31:0] f_b_out;
	
	reg [31:0] f_b;
	reg [9:0] cnt;   //位计数器
	reg done;
	reg [1:0] current_state;
	reg [1:0] next_state;
	parameter IDLE=2'b00;
	parameter BEGIN=2'b01;
	parameter CALCULATE_SUM=2'b10;
	
	reg en_calculate;
	wire [15:0] fibo_out;
	wire calculate_done; 
	
	calculate_fibonacci u_calculate_fibonacci(
	      .clk     (clk),
			.rst     (rst),
			.input_i (cnt),
			.begin_fibo_en (en_calculate),
			.calculate_done     (calculate_done),
			.fibo_out  (fibo_out)
	
	);
	
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
									   next_state = BEGIN;
									else
									   next_state = IDLE;
								end 
						BEGIN: begin
						          if(convert_done==1)
									    next_state = IDLE;
						          else if(done==1)
									    next_state = CALCULATE_SUM;
									 else
									    next_state = BEGIN;
								 end 
						CALCULATE_SUM: begin
						             if(done==1)
										    next_state = BEGIN;
										 else
										    next_state = CALCULATE_SUM;
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
					 en_calculate<=0;
					 done<=0;
					 cnt<=0;
					 f_b<=0;
				  end
				else
			      begin 
					  done<=0;
				     case(next_state)
					     IDLE: begin
						           convert_done<=0;
									  f_b<=0;
									  cnt<=0;
						           if(en_convert==1)
									    done<=1;
									  else 
									    done<=0;
								  end 
						  BEGIN: begin
						            if(cnt<=31)    //此时允许输入fibolacci进制最高为32位
										   begin 
											  if(input_f[cnt]==1)
											    begin 
											      done<=1;
													en_calculate<=1;
												 end  
											  else
											     cnt<=cnt+1;
											end 
										else
										   begin 
										     cnt<=0;
									    	  convert_done<=1;
											  f_b_out<= f_b;
											end 
									end
						  CALCULATE_SUM: begin
						               en_calculate<=0;
											if(calculate_done==1)
											   begin 
												    f_b<=f_b+fibo_out;
												    done<=1;
												    cnt<=cnt+1;	 
												end 
						                 end 
							endcase 
		  end 
		 end
endmodule 