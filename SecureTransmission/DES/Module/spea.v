module spea(clk,rst,en,input_B,input_S,out_b,done_spea,done);
    input clk;
	 input rst;
	 input [63:0]input_B;
	 input [63:0]input_S;
	 input en;
	 output reg [15:0]out_b;
	 output  reg done_spea;
	 output reg done;
	 reg[1:0] flow_cnt;
	 reg[1:0] count;
	 reg[6:0] cnt;
	 reg[6:0] cnt_1;
	 reg [31:0] b;
	 
	 
	 always @(posedge clk or negedge rst )begin 
	        if(!rst)
			    begin
				   out_b<=0;
					done<=0;
					done_spea<=0;
					flow_cnt<=0;
					count<=0;
					cnt<=0;
					cnt_1<=0;
					b<=0;
				 end 
				else begin
				   case(flow_cnt)
					  2'd0: begin
					          done_spea<=0;
					          if((en==1)&&(count<2))
								   flow_cnt<=2'd1;
								 else
								   flow_cnt<=2'd0;
					        end 
					  2'd1: begin
					           if(cnt<=31)
								    begin
									    cnt_1<=cnt_1+1;
					                b[cnt]<=input_B[cnt_1];
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
									  end 
					        end
						2'd2: begin
						         out_b<=b;
								   done<=1;
								   cnt<=0; 
									flow_cnt<=2'd3;
									count<=count+1;
					         end 	
					   2'd3:begin
						       done<=0;
						       if(count==2)
								  begin
								   done_spea<=1; 
								   cnt_1<=0;
									cnt<=0;
						//		   count<=0;
								   flow_cnt<=2'd0;
									end
								  else
								    flow_cnt<=2'd1;  
							   end 
					   default: flow_cnt<=2'd0;
					endcase 
				end 
					
			   end 
endmodule 
	 
	 