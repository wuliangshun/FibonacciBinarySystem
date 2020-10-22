module sum_fibonacci(clk,rst,en_sum,input_i,input_j,out_sum,sum_done);
  input clk;
  input rst;
  input [31:0] input_i;
  input [31:0] input_j;
  input en_sum;         //使能脉冲信号；
  output reg [31:0] out_sum;
  output sum_done;
  reg [31:0] sum;
  reg [31:0] mark_sum; //标记2寄存器
  //reg [31:0] re_mark_sum; //定位寄存器 
  reg [31:0] mark_sum_sum; // 标记3寄存器
 // reg [31:0] re_mark_sum_sum; //重定位寄存器
  
  reg done ;
  reg sum_done;
  reg [6:0] count ;
  
  reg [2:0] current_state;  //状态定义
  reg [2:0] next_state;
  
  parameter IDLE = 3'b000;
  parameter SUM = 3'b001;
  parameter XI_SHU_HUA = 3'b010;
  parameter BIAN_HUAN = 3'b011;
  parameter WEI_SHU_DEAL = 3'b100;
  
  always @(posedge clk or negedge rst) begin
      if(!rst)
		current_state <=IDLE;
		else
		current_state <= next_state;
	end 
	
	always @(*) begin 
	   if(!rst)
		   next_state = IDLE;
	   else
		  begin
		  case(current_state)
			 IDLE: begin
			       if(done==1)
					  next_state = SUM;
					 else
					  next_state = IDLE;
					 end
			 SUM  : begin
			         if(done==1)
					     next_state =XI_SHU_HUA;
						else
					     next_state = SUM;	
						end
			 XI_SHU_HUA: begin
			             if(done==1)
							 next_state = BIAN_HUAN;
							 else
							 next_state = XI_SHU_HUA;
							 end
			 BIAN_HUAN: begin
			              if((done==1)&&(mark_sum<=3))
							  next_state = WEI_SHU_DEAL;
							  else if((done==1)&&(mark_sum>3))
							  next_state<= XI_SHU_HUA;
							  else 
							  next_state = BIAN_HUAN;
							end 
          WEI_SHU_DEAL: begin
			                 if(mark_sum>3)
								     next_state = BIAN_HUAN;
                          else if(sum_done==1)
				                next_state = IDLE;
							     else
							       next_state = WEI_SHU_DEAL;
							   end
			 default : next_state = IDLE;
			endcase
		end 
		end
				          				
	always @ (posedge clk or negedge rst) begin
	    if(!rst)
		   begin
			 out_sum<=0;
			 sum <=0;
			 mark_sum<=0;
			 done<=0;
			 sum_done <=0;
			 count<=0;
			 mark_sum_sum<=0;
			 
	      end
		else
		  begin
		    done<=0;
		    case(next_state)
			   IDLE: begin
				         count<=1;
				         sum_done<=0;
							sum<=0;
							mark_sum<=0;
							mark_sum_sum<=0;
			         	if(en_sum)
				            done<=1;
						   else
							   done<=0;
						 end
				SUM : begin
				        if(count<=31)
						      begin
								  if((input_i[count]==1)&&(input_j[count]==1))
								     begin
									    sum[count]<=1'b1;
										 mark_sum[count]<=1'b1;
										 count<=count+1'b1;
									  end 
								  else
								     begin
								       sum[count]<=input_i[count]+input_j[count];
										 count<=count+1'b1;
									  end
								end
						  else
						    begin 
						    count <= 0;
							 done <=1'b1;
							 end 
		            end 		
				XI_SHU_HUA: begin
				               if(count<=29)
									  begin
									     if((mark_sum[count]==1)&&(mark_sum[count+1]==1))   // 连续22
										     begin
											     mark_sum[count]<=0;
												  mark_sum[count+1]<=0;
												  count<=count+1'b1;
												  if(mark_sum[count+2]==1)
												     begin  
													   mark_sum[count+2]<=0;
														mark_sum_sum[count+2]<=1;
													  end 
													else if(sum[count+2]==1)
													   begin
														  mark_sum[count+2]<=1;
														end 
												   else 
													   sum[count+2]<=1;
											   end
										  else if((mark_sum[count+1]==1)&&(mark_sum_sum[count]==1))  //连续23
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
													else if(sum[count+2]==1)
													  begin
													     mark_sum[count+2]<=1;
													  end
													else
													  sum[count+2]<=1;	 
												 end 
										   else if((mark_sum[count]==1)&&(mark_sum_sum[count+1]==1)) //连续32
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
													 else if(sum[count+2]==1)
													   begin 
														  mark_sum[count+2]<=1;
														end 
													 else
													     sum[count+2]<=1;
											     end 
											 else if((mark_sum_sum[count]==1)&&(mark_sum_sum[count+1]==1))  //连续33
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
													  else if(sum[count+2]==1)
													    begin
														   mark_sum[count+2]<=1;
														 end 
												   else 
													   sum[count+2]<=1;
												  end  
											 
											else       //无连续大于1的数
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
										    if(((mark_sum[1]==1)||(mark_sum_sum[1]==1))&&((mark_sum[2]==1)||(mark_sum_sum[2]==1)))
											    begin
												   done<=1;
													count<=0;
												 end
											else begin  
										    if(mark_sum[count]==1)  //对2进行处理
											    begin
												   if((mark_sum[count+1]==1)||(mark_sum_sum[count+1]==1))
													   begin
													     done<=1;
														 end
												   else begin
											       mark_sum[count]<=0;		
												    sum[count]<=0;
													 count<=count+1'b1;
													 if(sum[count+1]==1)
													    mark_sum[count+1]<=1;
													 else
													    sum[count+1]<=1;
													 if(mark_sum[count-2]==1)
													    begin 
													    mark_sum[count-2]<=0;
														 mark_sum_sum[count-2]<=1;
														 end
													 else if(sum[count-2]==1)
													    mark_sum[count-2]<=1;
													 else
													    sum[count-2]<=1;
													     end
											          end
											 else if(mark_sum_sum[count]==1)   //对3进行处理
											       begin
													    if((mark_sum[count+1]==1)||(mark_sum_sum[count+1]==1))
														   begin
														     done<=1;
															end 
														 else begin 
													      mark_sum_sum[count]<=0;
													      count<=count+1'b1;
													      if(sum[count+1]==1)
															  mark_sum[count+1]<=1;
															else 
													        sum[count+1]<=1;
															if(mark_sum[count-2]==1)
															  begin 
													        mark_sum[count-2]<=0;
															  mark_sum_sum[count-2]<=1;
															  end 
															else if(sum[count-2]==1)
															   mark_sum[count-2]<=1;
															else 
													         sum[count-2]<=1;		
														       end 
												    end
											 else          //对1，0进行处理	 
											   count<=count+1'b1;
										    end 
											 end 
			                    else
									     begin
											done<=1;
											count<=0;
										  end 
			              end
							  
				 WEI_SHU_DEAL: begin
				                  if((mark_sum_sum[0]==1)||(mark_sum[0]==1)) //对0位2或3进行处理
										  begin
										     sum[0]<=0;
											  mark_sum_sum[0]<=0;
											  mark_sum[0]<=0;
										  end
									   if(mark_sum_sum[1]==1)   //对1位是3处理
										  begin
										     mark_sum[1]<=1;
											  mark_sum_sum[1]<=0;
											  if(sum[2]==0)
											    sum[2]<=1;
											  else
											    mark_sum[2]<=1;
										  end 
										 if(mark_sum[1]==1) //对1位是2处理
										     begin
												 mark_sum[1]<=0;
												 if(sum[2]==0)
												    sum[2]<=1;
												 else
												   mark_sum[2]<=1; 
											  end 
										 if(mark_sum==0)
										   begin
											out_sum<=sum;
											sum_done<=1;
											end 
                           end
 					endcase	
		  end 
			
	end 
    	
endmodule 