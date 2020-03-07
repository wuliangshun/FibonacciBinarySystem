module hui_fu(clk,rst,en,input_F,input_S,out_f,done_hui_fu,done);
    input clk;
	 input rst;
	 input [63:0]input_F;
	 input [63:0]input_S;
	 input en;
	 output reg [31:0]out_f;
	 output  reg done_hui_fu;
	 output reg done;
	 
	 reg[1:0] flow_cnt;
	 reg[1:0] count;
	 reg[6:0] cnt;
	 reg[6:0] cnt_1;
	 reg [31:0] f;
	 
	 
	 always @(posedge clk or negedge rst )begin 
	        if(!rst)
			    begin
				   out_f<=0;
					done<=0;
					done_hui_fu<=0;
					flow_cnt<=0;
					count<=0;
					cnt<=0;
					cnt_1<=0;
					f<=0;
				 end 
				else begin
				   case(flow_cnt)
					  2'd0: begin
					          done_hui_fu<=0;
					          if(en)
								   flow_cnt<=2'd1;
								 else
								   flow_cnt<=2'd0;
					        end 
					  2'd1: begin
					           if(cnt<=31)
								    begin
									    cnt_1<=cnt_1+1;
					                f[cnt]<=input_F[cnt_1];
								     if(input_S[cnt_1]==1)
											flow_cnt<=2'd2;
										else begin 
									     cnt<=cnt+1;
										  flow_cnt<=2'd1;
									   end  
								    end 
									else
								     begin 	
									  flow_cnt<=2'd2;
									  done<=1;
									  end 
					        end
						2'd2: begin
						         out_f<=f;
								   done<=1;
								   cnt<=0; 
									flow_cnt<=2'd3;
					         end 	
					   2'd3:begin
						       f<=0;
						       done<=0;
						       if(count==2)
								  begin
								   done_hui_fu<=1; 
								   cnt_1<=0;
									cnt<=0;
								   count<=0;
								   flow_cnt<=2'd0;
									end 
								 else if(en==1)
								   begin 
								   flow_cnt<=2'd1;
									count<=count+1;
									cnt<=0;
							      end
								  else
								    flow_cnt<=2'd3;  
							   end 
					   default: flow_cnt<=2'd0;
					endcase 
				end 
					
			   end 
endmodule 
	 
	 