module jiezhi_chuan(clk,rst,input_f,out_S,out_F,en,done,done_jiezhi);
     input clk;
	  input rst;
	  input [31:0]input_f;
	  input en;
	  output reg [63:0]out_F;
	  output reg [63:0]out_S;
	  output reg done;
	  output reg done_jiezhi;
	  reg [6:0] cnt;
	  reg [6:0] cnt_1;
	  reg [6:0] cnt_2;
	  reg [63:0] s;
	  reg [63:0] f;
	  reg [1:0] count;
	  reg [1:0] flow_cnt;
	  
	  
	  always@(posedge clk or negedge rst)begin
	       if(!rst)
			   begin
			     flow_cnt<=0;	
				  count<=0;
			     cnt<=31;
				  cnt_1<=0;
				  cnt_2<=0;
				  out_S<=0;
				  out_F<=0;
				  done<=0;
				  done_jiezhi<=0;
				  f<=0;
				  s<=0;
			   end 
				else begin
				  case(flow_cnt)
				    2'd0:begin
					        done<=0;
					        done_jiezhi<=0;
					        if(en)
							    begin 
							      flow_cnt<=2'd1;
									count<=count+1;
								 end 
							  else
							    flow_cnt<=2'd0;
					      end
					 2'd1:begin 		
						           if(input_f!=0)
						              begin  
				                       if(input_f[cnt]==1)
							                 begin
												    cnt_2<=cnt_2+cnt+1; 
												    cnt_1<=cnt_2+cnt+1;
													 flow_cnt<=2'd2;
				                            s[cnt_2+cnt]<=1;
							                 end
							               else
						                    cnt<=cnt-1;	 
						               end
						            else
										  begin 
										   flow_cnt<=2'd3;
											end 
					          
								 end 
					 2'd2: begin
					         f[cnt_1-1]<=input_f[cnt];
								cnt<=cnt-1;
								cnt_1<=cnt_1-1;
					         if(cnt==0)
								  flow_cnt<=2'd3;
								else
								  flow_cnt<=2'd2;
					        end 
					 2'd3: begin
					          flow_cnt<=2'd0;
								 cnt<=31;
					          if(count==2)    //一次传输两个fibonacci数据
						         begin
									  count<=0;
								     cnt_1<=0;	
						           done_jiezhi<=1;
							        out_S<=s;
									  out_F<=f;
									  cnt_2<=0;
							      end
								 else begin
								     done<=1;
								  end 
					       end 
				   endcase 
				end 
	      end 
	  
endmodule 