module random_encoder(clk,rst,en_encode,input_binary,fibonacci_random,convert_done,cnt_a,mema);
    input clk;
	 input rst;
	 input en_encode;
	 input [15:0]input_binary;
	 input [15:0] mema;
	 output reg [63:0] fibonacci_random;
	 output reg convert_done;
	 output reg [9:0] cnt_a;
	 
	 reg done;
	 reg [63:0] bin_fib;	 
	 reg [4:0] rand_num;
	 reg [1:0] flow_cnt;
	 
	 reg [15:0] input_b;
	 reg [3:0] current_state;
	 reg [3:0] next_state;
	 parameter IDLE=3'b000;
	 parameter BEGIN=3'b001;
	 parameter CALCULATE=3'b010;
	 parameter RANDOM=3'b011;
	 parameter XI_SHU_HUA =3'b100;
	 parameter BIAN_HUAN=3'b101;
	 parameter WEI_SHU_DEAL=3'b110;
	 
	 reg [63:0] mark_sum ; //??2
	 reg [63:0] mark_sum_sum ;//??3
	 reg [5:0] count;
	 
	
	always @(posedge clk or negedge rst)begin
	       if(!rst)
			   current_state<=IDLE;
			 else 
			   current_state <=next_state;
		 end 
		 
	always @(*)begin 
	       if(!rst)
			   next_state = IDLE;
			 else begin
			    case(current_state)
				     IDLE: begin
					           if(done==1)
								     next_state= BEGIN;
								  else 
								     next_state =IDLE;
							  end 
						BEGIN: begin
						              if(convert_done==1)
										     next_state =IDLE;
						              else if(done==1)
										     next_state = CALCULATE;
										  else
										     next_state = BEGIN;
									  end 
						CALCULATE: begin
						              if(done==1)
										    next_state = RANDOM;
										  else
										    next_state = CALCULATE;
									  end 
						RANDOM: begin
						          if(convert_done==1)
									    next_state = IDLE;
									 else if((mark_sum<=3)&&(mark_sum!=0))
									    next_state = WEI_SHU_DEAL;
									 else if(mark_sum>3)
									    next_state = BIAN_HUAN;
						          else 
									    next_state = RANDOM;
						        end 
						 XI_SHU_HUA: begin
						                if(done==1)
											    next_state = BIAN_HUAN;
											 else  
											    next_state = XI_SHU_HUA;
										 end 
										 
						 BIAN_HUAN:begin
						              if((done==1)&&(count==0)&&(mark_sum>3))
										       next_state = XI_SHU_HUA;
		                          else if(mark_sum==0)
										     next_state = RANDOM;
						              else if(mark_sum<=3)
										     next_state =WEI_SHU_DEAL;
										  else
										     next_state =BIAN_HUAN;
									  end 
						 WEI_SHU_DEAL: begin
						                   if((mark_sum>3)&&(done==1))
												    next_state = BIAN_HUAN; 
						                   else if(mark_sum==0)
												    next_state = RANDOM;
												 else
												    next_state =  WEI_SHU_DEAL;
						               end 
						default: next_state = IDLE;
				 endcase 
			 end 
		 end 
		 
	always @(posedge clk or negedge rst) begin
	        if(!rst)
			     begin
				    bin_fib<=0;
					 done<=0;
					 convert_done<=0;
					 fibonacci_random<=0;
					 cnt_a<=0;
					 rand_num<=0;
					 flow_cnt<=0;
				    mark_sum<=0;
					 mark_sum_sum<=0;
					 count<=0;
				  end 
				else begin
				    done<=0;
					 case(next_state)
					    IDLE: begin
						          convert_done<=0;
									 if(en_encode==1)
									   begin
									     mark_sum<=0;
										  mark_sum_sum<=0; 
									     input_b<=input_binary;
										  done<=1;
										 end 
									 else 
									     done<=0;
								 end 
						 BEGIN: begin
						           if(input_b==0)
									    begin
										    convert_done<=1;
											 fibonacci_random<=bin_fib;
										 end
										else 
										  begin 
											done<=1;
										  end 
								  end
					  CALCULATE: begin
					                if(mema<=input_b)
										    cnt_a<=cnt_a+1;
										 else
										   done<=1;
												 
						        end                    
						RANDOM: begin                  //0-31 ??????
						               case(flow_cnt)
		                             3'd0: begin 
							                      rand_num<=cnt_a+2;
									           	    flow_cnt<=flow_cnt+1;
									              end 
	             						  3'd1: begin
											          if(input_b!=0)
														   begin  
															  rand_num[0]<= rand_num[4];
															  rand_num[1]<=rand_num[0];
					            		              rand_num[2] <= rand_num[1]^rand_num[4];
                                               rand_num[3] <= rand_num[2];
                                               rand_num[4] <= rand_num[3];
                                               cnt_a<=rand_num;
														     if((input_b>=mema)&&(cnt_a<=31))
															      begin
														         flow_cnt<=flow_cnt+1;
																	cnt_a<=cnt_a;
																	end 
														     else
														      flow_cnt<=flow_cnt;
									                    end
															else
															  begin 
															    convert_done<=1;
																 fibonacci_random<=bin_fib;
																 bin_fib<=0;
																 flow_cnt<=0;
																 cnt_a<=0;
															  end 
														end 
												3'd2: begin
												          cnt_a<=rand_num;
											          	 flow_cnt<=flow_cnt<-1;
												          input_b<=input_b-mema;
												         if(cnt_a==0)
															    bin_fib[0]<=1;
															else begin 
															  if(bin_fib[cnt_a]==1)
															     begin 
															      mark_sum[cnt_a]<=1;
																	count<=2;
																  end 
															   else
															      bin_fib[cnt_a]<=1; 
															end 
												      end 
												default :flow_cnt<=0;
								         endcase 
											end 
							XI_SHU_HUA: begin
				               if(count<=29)
									  begin
									     if((mark_sum[count]==1)&&(mark_sum[count+1]==1))   // ??22
										     begin
											     mark_sum[count]<=0;
												  mark_sum[count+1]<=0;
												  count<=count+1'b1;
												  if(mark_sum[count+2]==1)
												     begin  
													   mark_sum[count+2]<=0;
														mark_sum_sum[count+2]<=1;
													  end 
													else if(bin_fib[count+2]==1)
													   begin
														  mark_sum[count+2]<=1;
														end 
												   else 
													   bin_fib[count+2]<=1;
											   end
										  else if((mark_sum[count+1]==1)&&(mark_sum_sum[count]==1))  //??23
										      begin
												   mark_sum_sum[count]<=0;
													mark_sum[count]<=1;
													mark_sum[count+1]<=0;
													count<=count+1'b1;
													if(mark_sum[count+2]==1)
													  begin 
													  mark_sum[count+2]<=0;
													  mark_sum_sum[count+2]<=1;
													  end 
													else if(bin_fib[count+2]==1)
													  begin
													     mark_sum[count+2]<=1;
													  end
													else
													  bin_fib[count+2]<=1;	 
												 end 
										   else if((mark_sum[count]==1)&&(mark_sum_sum[count+1]==1)) //??32
										       begin
												    mark_sum[count]<=0;
													 mark_sum_sum[count+1]<=0;
													 mark_sum[count+1]<=1;
													 count<=count+1'b1;
													 if(mark_sum[count+2]==1)
													   begin 
													    mark_sum[count+2]<=0;
														 mark_sum_sum[count+2]<=1;
														end 
													 else if(bin_fib[count+2]==1)
													   begin 
														  mark_sum[count+2]<=1;
														end 
													 else
													     bin_fib[count+2]<=1;
											     end 
											 else if((mark_sum_sum[count]==1)&&(mark_sum_sum[count+1]==1))  //??33
											     begin
												     mark_sum_sum[count]<=0;
													  mark_sum_sum[count+1]<=0;
													  mark_sum[count]<=1;
													  mark_sum[count+1]<=1;
													  count<=count+1'b1;
													  if(mark_sum[count+2]==1)
												       begin  
													      mark_sum[count+2]<=0;
														   mark_sum_sum[count+2]<=1;
													    end 
													  else if(bin_fib[count+2]==1)
													    begin
														   mark_sum[count+2]<=1;
														 end 
												   else 
													   bin_fib[count+2]<=1;
												  end  
											 
											else       //?????1??
										   count<=count+1'b1;
									  end 
									else
									  begin 
									  count<=2;
									  done<=1;
									  end 
							   end
								
				BIAN_HUAN : begin
				                if(count<=30)
									    begin
										   count<=count+1'b1;
										    if(mark_sum[count]==1)  //?2????
											    begin
											       mark_sum[count]<=0;		
												    bin_fib[count]<=0;
													 if(bin_fib[count+1]==1)
													    mark_sum[count+1]<=1;
													 else
													    bin_fib[count+1]<=1;
													 if(mark_sum[count-2]==1)
													    begin 
													    mark_sum[count-2]<=0;
														 mark_sum_sum[count-2]<=1;
														 end
													 else if(bin_fib[count-2]==1)
													    mark_sum[count-2]<=1;
													 else
													    bin_fib[count-2]<=1;
													     end
											end
			                    else
									     begin
											done<=1;
											count<=0;
										  end 
			              end
						
							  
				 WEI_SHU_DEAL: begin
				                  if(mark_sum>3)
										    begin
										      count<=2;
												done<=1;
										    end
										else begin 	 
				                   if((mark_sum_sum[0]==1)||(mark_sum[0]==1)) //?0?2?3????
										  begin
										     bin_fib[0]<=0;
											  mark_sum_sum[0]<=0;
											  mark_sum[0]<=0;
										  end
									     if(mark_sum[1]==1)
										   begin
											  mark_sum[1]<=0;
											  if(bin_fib[2]==1)
											     mark_sum[2]<=1;
											  else if(bin_fib[2]==0)
											     bin_fib[2]<=1; 
											
									      end 
									    else if(mark_sum_sum[1]==1)   //?1??3??
										  begin
										     mark_sum[1]<=1;
											  mark_sum_sum[1]<=0;
											  if(bin_fib[2]==0)
											    bin_fib[2]<=1;
											  else
											    mark_sum[2]<=1;
										  end                    
										
										
									  end 	
                           end
					 endcase 
					 
				end 
		  end 
	 
	 endmodule 

