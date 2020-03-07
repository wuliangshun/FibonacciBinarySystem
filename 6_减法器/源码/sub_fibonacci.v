module sub_fibonacci(clk,rst,en,input_i,input_j,out_sub,sub_done);
  input clk;
  input rst;
  input en;
  input [31:0] input_i; //被减数  被减数>减数。
  input [31:0] input_j; // 减数   
  output reg [31:0] out_sub;
  output sub_done;
 
//******* 处理做差后最左侧为-1
  reg [31:0] mark_1;//标记做差后的1
  reg [9:0] cnt;
 ///***************** 
 
  reg sub_done;
  reg done;
  reg [9:0] count;
  reg [31:0] mark_fu;  //标记-1
  reg [31:0] mark_fu_fu;  //标记 -2
  reg [31:0] mark_sub;  // 标记2
  reg [31:0] mark_sub_sub; //标记3；
  reg [31:0] sub;
  
  reg [2:0] current_state;
  reg [2:0] next_state;
  
  parameter IDLE=3'b000;
  parameter SUB=3'b001;
  parameter QU_FU_SHU=3'b010;
  parameter XI_SHU_HUA=3'b011;
  parameter BIAN_HUAN=3'b100;
  parameter WEI_SHU_DEAL=3'b101;
  
  always @(posedge clk or negedge rst) begin
      if(!rst)
		 current_state<=IDLE;
		else
		 current_state<=next_state;
		 end
		 
  always @(*) begin
      if(!rst)
	      next_state = IDLE;
		else
	     begin
	       case(current_state)
			   IDLE: begin
				        if(en)
						    next_state =SUB;
						  else
						    next_state = IDLE;
						end
				SUB: begin
				       if(done==1)
						   next_state = QU_FU_SHU;
						 else
						   next_state = SUB;
						end
				QU_FU_SHU : begin
                           if(done==1)
							         next_state = BIAN_HUAN;
								   else
							         next_state = QU_FU_SHU;
								  end 
				XI_SHU_HUA: begin
				               if(done==1)
									   next_state = BIAN_HUAN;
									else
									   next_state = XI_SHU_HUA;
								 end
								 
				BIAN_HUAN: begin
				              if((done==1)&&(count==0)&&(mark_sub>3))
								     next_state = XI_SHU_HUA;
								  else if((done==1)&&(count==2)&&(mark_sub<=3)&&((mark_fu!=0)||(mark_fu_fu!=0)))
									  next_state= QU_FU_SHU;
								  else if((done==1)&&(count==2)&&(mark_sub<=3)&&((mark_fu==0)||(mark_fu_fu==0)))
								     next_state =WEI_SHU_DEAL;
								  else
								     next_state = BIAN_HUAN;
								end
				
				WEI_SHU_DEAL: begin
                            if(sub_done==1)
						             next_state= IDLE;
							       else if (mark_sub>3)
							          next_state=XI_SHU_HUA;
									 else
									    next_state=WEI_SHU_DEAL;
						        end
				 default : next_state =IDLE; 
	          endcase
         end				 
		end
		
	always @(posedge clk or negedge rst) begin
           if(!rst)
			     begin
				    cnt<=31;
				    mark_1<=0;
				    count<=0;
					 mark_fu<=0;
					// re_mark_fu<=0;
					 mark_fu_fu<=0;
					 mark_sub<=0; 
					 mark_sub_sub<=0;
				    done<=0; 
					 sub_done<=0;
					 out_sub<=0;
					 sub<=0;
				  end
				 else 
				  begin
				    done <=0;
				    case(next_state)
					 IDLE : begin
					         mark_1<=0;
								cnt<=31;
				        	   sub_done<=0;
								count<=1;
								sub<=0;
					         if(en)
								 done<=1;
								else
								 done<=0;
					        end
					 SUB : begin
					         if(count<=31)
								   begin
									  if(input_i[count]<input_j[count])
									     begin
										    sub[count]<=1;
											 mark_fu[count]<=1;
											 count<=count+1'b1;
										  end
									  else
									    begin 
									     sub[count]<= input_i[count]-input_j[count];
								        count<=count+1'b1;
										  if(input_i[count]>input_j[count])
										     mark_1[count]<= 1;
										  else 
										     mark_1[count]<= 0;
										 end 
									end 
								else
					            begin
								     done<=1;
									  cnt<=31;
									  count<=1; 
								   end 	  
									end 
						QU_FU_SHU: begin
						             if(mark_fu>mark_1)
										    begin
										     if((mark_fu[cnt]==1)&&(mark_sub[cnt-1]==1))
											     begin
												     count<=2;
													  done<=1;
												  end
											  else if((mark_fu[cnt]==1)&&(mark_sub[cnt-1]!=1)) 
											     begin
												    sub[cnt-1]<=0;
												    sub[cnt]<=0;
												    cnt<=cnt-1;
												    mark_fu[cnt]<=0;
													 mark_fu[cnt-1]<=0;  //做差后最高位为-1，则次高位必为1
													 mark_1[cnt-1]<=0;
													 if(mark_1[cnt-2]==1) //做差后，最高位为-1，次次高位为0或1 
													   begin 
													     mark_1[cnt-2]<=0;
														  sub[cnt-2]<=0;
														end 
													 else
													   begin  
														 mark_fu[cnt-2]<=1;
														 sub[cnt-2]<=1;
														end 
												  end 
											  else
											    cnt<=cnt-1;
										    end 
										 else begin 
			             			  if(count<=29)
										    begin
											   if(mark_sub>3)
												  begin
												    done<=1;
													 count<=2;
												  end
												else begin  
											     if(mark_fu[count]==1)    //处理-1
												   begin
													  count<=count+1'b1;
													  sub[count]<=0;
													  mark_fu[count]<=0;
													                          //向左1位
													  if(mark_fu[count+1]==1) //-1
													    begin 
														 mark_fu[count+1]<=0;
													    sub[count+1]<=0;     
														 end 
													  else if(sub[count+1]==1) //1
													    mark_sub[count+1]<=1;
													  else                     //0
													    sub[count+1]<=1; 
														                       //向左2位
													  if(mark_fu[count+2]==1) //-1
													    begin 
													    mark_fu_fu[count+2]<=1;
														 mark_fu[count+2]<=0;
														 end 
													  else if(sub[count+2]==1) //1
													    sub[count+2]<=0;
													  else begin               //0
													    sub[count+2]<=1;
														 mark_fu[count+2]<=1;
													  end 
													end 
												  else if(mark_fu_fu[count]==1)   //处理-2
									             begin
											          mark_fu_fu[count]<=0;
														 mark_fu[count]<=1;
														 count<=count+1'b1;
														                          //向左1位
														 if(mark_fu[count+1]==1)  //-1
														   begin 
															 sub[count+1]<=0;
															 mark_fu[count+1]<=0; 
															end 
														 else if(sub[count+1]==1) //1
														    mark_sub[count+1]<=1;
														 else                      //0
														    sub[count+1]<=1;
															                       //向左2位
														 if(mark_fu[count+2]==1)   //-1
														    begin 
																mark_fu_fu[count+2]<=1;
															   mark_fu[count+2]<=0;
														    end 	
														 else if(sub[count+2]==1) //1
														      sub[count+2]<=0;
													    else                     //0
														    begin 
														     sub[count+2]<=1;
															  mark_fu[count+2]<=1;
															 end 
														end
												  else
												    count<=count+1'b1;
											   end 
											  end 
											else
											  begin 
											count<=2;
											done<=1;
											 end 
										  end
									  end 
				XI_SHU_HUA:begin
                         if(count<=29)
									  begin
									     if((mark_sub[count]==1)&&(mark_sub[count+1]==1))   // 连续22
										     begin
											     mark_sub[count]<=0;
												  mark_sub[count+1]<=0;
												  count<=count+1'b1;
												  if(mark_sub[count+2]==1)
												     begin  
													   mark_sub[count+2]<=0;
														mark_sub_sub[count+2]<=1;
													  end 
													else if(sub[count+2]==1)
													   begin
														  mark_sub[count+2]<=1;
														end 
												   else 
													   sub[count+2]<=1;
											   end
										  else if((mark_sub[count+1]==1)&&(mark_sub_sub[count]==1))  //连续23
										      begin
												   mark_sub_sub[count]<=0;
													mark_sub[count]<=1;
													mark_sub[count+1]<=0;
													count<=count+1'b1;
													if(mark_sub[count+2]==1)
													  begin 
													  mark_sub[count+2]<=0;
													  mark_sub_sub[count+2]<=1;
													  end 
													else if(sub[count+2]==1)
													  begin
													     mark_sub[count+2]<=1;
													  end
													else
													  sub[count+2]<=1;	 
												 end 
										   else if((mark_sub[count]==1)&&(mark_sub_sub[count+1]==1)) //连续32
										       begin
												    mark_sub[count]<=0;
													 mark_sub_sub[count+1]<=0;
													 mark_sub[count+1]<=1;
													 count<=count+1'b1;
													 if(mark_sub[count+2]==1)
													   begin 
													    mark_sub[count+2]<=0;
														 mark_sub_sub[count+2]<=1;
														end 
													 else if(sub[count+2]==1)
													   begin 
														  mark_sub[count+2]<=1;
														end 
													 else
													     sub[count+2]<=1;
											     end 
											 else if((mark_sub_sub[count]==1)&&(mark_sub_sub[count+1]==1))  //连续33
											     begin
												     mark_sub_sub[count]<=0;
													  mark_sub_sub[count+1]<=0;
													  mark_sub[count]<=1;
													  mark_sub[count+1]<=1;
													  count<=count+1'b1;
													  if(mark_sub[count+2]==1)
												       begin  
													      mark_sub[count+2]<=0;
														   mark_sub_sub[count+2]<=1;
													    end 
													  else if(sub[count+2]==1)
													    begin
														   mark_sub[count+2]<=1;
														 end 
												   else 
													   sub[count+2]<=1;
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
				BIAN_HUAN: begin
				             if(count<=30)
									    begin
										    if(((mark_sub[1]==1)||(mark_sub_sub[1]==1))&&((mark_sub[2]==1)||(mark_sub_sub[2]==1)))
											    begin
												   done<=1;
													count<=0;
												 end
											else begin  
										    if(mark_sub[count]==1)  //对2进行处理
											    begin
												   if((mark_sub[count+1]==1)||(mark_sub_sub[count+1]==1))
													   begin
													     done<=1;
														  count<=0;
														end
												   else begin
											       mark_sub[count]<=0;		
												    sub[count]<=0;
													 count<=count+1'b1;
													                             //向左一位
													 if(mark_fu_fu[count+1]==1)  // -2
													    begin
														   mark_fu_fu[count+1]<=0;
															mark_fu[count+1]<=1;
														 end 
													 else if(mark_fu[count+1]==1) //-1
													    begin
														  mark_fu[count+1]<=0;
														  sub[count+1]<=0;
														 end 
													 else if(sub[count+1]==1)      //1
													    mark_sub[count+1]<=1;
													 else                          // 0
													    sub[count+1]<=1;
														                           //向右2位
													 if(mark_sub[count-2]==1)     //2
													    begin 
													    mark_sub[count-2]<=0;
														 mark_sub_sub[count-2]<=1;
														 end
													 else if(mark_fu_fu[count-2]==1) //-2
													    begin
														    mark_fu[count-2]<=1;
															 mark_fu_fu[count-2]<=0;
														 end 
													 else if(mark_fu[count-2]==1)   //-1
													    begin
														    mark_fu[count-2]<=0;
															 sub[count-2]<=0;
														 end 
													 else if(sub[count-2]==1)  //1 
													    mark_sub[count-2]<=1;
													 else                      //0
													    sub[count-2]<=1;
													     end
											          end
											 else if(mark_sub_sub[count]==1)   //对3进行处理
											       begin
													    if((mark_sub[count+1]==1)||(mark_sub_sub[count+1]==1))
														   begin
														     done<=1;
															  count<=0;
															end 
														 else begin 
													      mark_sub_sub[count]<=0;
													      count<=count+1'b1;
															                            //向左一位
															if(mark_fu_fu[count+1]==1)  //-2
															   begin
																  mark_fu_fu[count+1]<=0;
																  mark_fu[count+1]<=1;
																end 
															else if(mark_fu[count+1]==1) //-1
															   begin
																  mark_fu[count+1]<=0;
																  sub[count+1]<=0;
																end 
													      else if(sub[count+1]==1)   //1  
															     mark_sub[count+1]<=1;
															else                        //0
													           sub[count+1]<=1;
																  
																                        //向右2位									
															if(mark_sub[count-2]==1)   //2
															  begin 
													        mark_sub[count-2]<=0;
															  mark_sub_sub[count-2]<=1;
															  end 
															else if(mark_fu_fu[count-2]==1)//-2
															  begin
															   mark_fu_fu[count-2]<=0; 
															   mark_fu[count-2]<=1;
															  end 
															else if(mark_fu[count-2]==1) //-1
															  begin
															    mark_fu[count-2]<=0;
																 sub[count-2]<=0;
															  end 
															else if(sub[count-2]==1)   //1
															   mark_sub[count-2]<=1;
															else                       //0
													         sub[count-2]<=1;		
														       end 
												    end
											 else          //对1，0进行处理	 
											   count<=count+1'b1;
										    end 
											 end 
			                    else
									     begin
										   done<=1;
											count<=2;
										  end 
				
				           end 
				WEI_SHU_DEAL: begin
				                  if((mark_sub_sub[0]==1)||(mark_sub[0]==1)) //对0位2或3进行处理
										  begin
										     sub[0]<=0;
											  mark_sub_sub[0]<=0;
											  mark_sub[0]<=0;
										  end
									   if(mark_sub_sub[1]==1)   //对1位是3处理
										  begin
										     mark_sub[1]<=1;
											  mark_sub_sub[1]<=0;
											  if(sub[2]==0)
											    sub[2]<=1;
											  else
											    mark_sub[2]<=1;
										  end 
										 if(mark_sub[1]==1) //对1位是2处理
										     begin
												 mark_sub[1]<=0;
												 if(sub[2]==0)
												    sub[2]<=1;
												 else
												   mark_sub[2]<=1; 
											  end 
										 if(mark_sub==0)
										   begin
											out_sub<=sub;
											sub_done<=1;
											end 
                           end
								
 					endcase	
					end
				   				
					end 
					 
						 
endmodule 						 
		
  