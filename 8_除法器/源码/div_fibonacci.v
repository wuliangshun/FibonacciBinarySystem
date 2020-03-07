module div_fibonacci(clk,rst,en_div,input_i,input_j,out_div,out_yu_shu,div_done);
   input clk;
	input rst;
	input en_div;
	input [31:0] input_i;  //被除数
	input [31:0] input_j;  //除数
	output reg [31:0] out_div;  //输出结果为十进制
	output reg [31:0] out_yu_shu;//输出结果为fibonacci进制
	output reg div_done;
	
	reg done;
	reg [31:0] div;
	wire [31:0] yu_shu;
	reg [15:0] cnt_h;
	reg [15:0] cnt_m;
	reg [15:0] cnt_l;
	reg [9:0] count_i_i;
	reg [9:0] count_i;
	reg [9:0] count_j;
	
	reg [2:0] current_state;
	reg [2:0] next_state;
	parameter IDLE=3'b000;
	parameter QIAN_YI=3'b001;
	parameter QIAN_YI_1=3'b010;
	parameter PI_PEI=3'b011;
	parameter COMPARE=3'b100;
	parameter SUB=3'b101;
	
	reg [31:0] input_f;
	reg [31:0] i;
	reg [31:0] j;
	wire [31:0] f_b_out;
	wire [31:0] b_f_out;
	wire fibonacci_binary_done;
	wire sub_done;
	reg sub_en;
	reg f_b_en;
	reg b_f_en;
	wire convert_done;
	
	
	//**** 例化fibonacci_binary模块***
	fibonacci_binary u_fibonacci_binary(
	    .clk    (clk),
		 .rst (rst),
		 .input_f (input_f),
		 .en_convert (f_b_en),
		 .convert_done    (fibonacci_binary_done),
		 .f_b_out (f_b_out)
	);
	//************************
	
	//****例化减法器模块*********
	sub_fibonacci u_sub_fibonacci(
	    .clk    (clk),
		 .rst    (rst),
		 .en     (sub_en),
		 .input_i (i),
		 .input_j (j),
		 .out_sub (yu_shu),
		 .sub_done (sub_done)
	);
	//*************************
	
	// 例化binary_fibonacci模块****** 二进制转化为标准式Fibonacci进制
	binary_fibonacci u_binary_fibonacci(
	    .clk     (clk),
		 .rst     (rst),
		 .input_binary (j*div),
		 .begin_b_f (b_f_en),
		 .convert_done (convert_done),
		 .fibonacci_standard(b_f_out)
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
							   next_state = QIAN_YI;
							 else 
							   next_state = IDLE;
						  end 
				  QIAN_YI: begin
				             if(div_done==1)
								    next_state = IDLE;
								 else if(done==1)
								    next_state = QIAN_YI_1;
								 else  
								    next_state = QIAN_YI;
								 
				            end
				  QIAN_YI_1:begin
				              if(div_done==1)
								    next_state = IDLE;
								 else if(done==1)
								    next_state = PI_PEI;
								 else  
								    next_state = QIAN_YI_1;
							  end 
							  
				  PI_PEI: begin
				             if(done==1)
								    next_state = COMPARE;
								 else
								    next_state = PI_PEI;
				          end  
				  COMPARE: begin
				              if(div_done==1)
								     next_state = IDLE;
				              else if(done==1)
								     next_state = SUB;
								  else 
								     next_state = COMPARE;
							  end 
				  SUB: begin
				          if(done==1)
							    next_state = IDLE;
							 else 
							    next_state = SUB;
						 end 
				  default: next_state = IDLE;
				  
			  endcase 
			  
        end 	
	   end
	always @(posedge clk or negedge rst) begin 
          if(!rst)
			    begin
				    sub_en<=0;
				    b_f_en<=0;
					 f_b_en<=0;
				    cnt_h<=0;
					 cnt_m<=0;
					 cnt_l<=0;
				    i<=0;
					 j<=0; 
				    count_i_i<=0;
					 out_div<=0;
					 done<=0;
					 div_done<=0;
					 div<=0;
					 out_yu_shu<=0;
					 count_i<=31;
					 count_j<=31;
				 end 
			 else begin
			       done<=0; 
			     case(next_state)
				      IDLE: begin 
						         cnt_h<=0;
									cnt_m<=0;
						         div_done<=0;
						         div<=0;
									count_i<=31;
									count_j<=31;
						         if(en_div)
						            done<=1;
							      else 
						            done<=0;			
								end 
						 QIAN_YI: begin
						             if((input_i[count_i]!=1)||(input_j[count_j]!=1))
										    begin
											   if(count_i==0)
											      count_i<=0;
												else begin 	
						                     if(input_i[count_i]==0)
										            count_i<=count_i-1;
										         else begin 
														count_i<=count_i;
													end 
										      end 
												if(count_j==0)  //除数为0,特殊处理。
												   begin 
													  div_done<=1;
													end
												else begin 
										         if(input_j[count_j]==0)
										            count_j<=count_j-1;
										         else
										            count_j<=count_j;
												end 
											 end 
										  else begin 
										      if((count_i>=count_j)&&(count_i>=2))
												   begin
													   count_i_i<=count_i;
												      done<=1;	
													   cnt_h<=input_i[count_i];
														cnt_m<=input_i[count_i-1];
														cnt_l<=input_i[count_i-2];
													end 
										  end 
									 end 
						
				       QIAN_YI_1: begin
						               if(count_i<count_j)
												   begin
													   if(count_i==0) //被除数为0
														   begin 
															  out_div<=0;
															  out_yu_shu<=0;
															  div_done<=1;
															end 
													    else if(count_i<count_j) //商为0或1
														   begin 
														     done<=1;
														     div<=1;
															end 
													end
											 else begin
											        if(count_i==1)
													     begin
														     out_div<=1;
															  out_yu_shu<=0;
															  div_done<=1;
														  end  
											        else if(count_i_i==count_j)
													     begin
														     cnt_l<=0;
														     div<=cnt_h;
															  done<=1;
														  end 
													  else if(count_i_i>count_j)
													     begin 
														     if(cnt_h>0)
															     begin
																    cnt_h<=cnt_h+cnt_m;
																	 cnt_m<=cnt_h+cnt_l;
																	 count_i_i<=count_i_i-1;
																	 if(count_i_i>=3)
																	    cnt_l<=input_i[count_i_i-3];
																	 else
																	    cnt_l<=0;
																  end 
															  
														  end 
														  
														  
										      end 	
										end 
				       PI_PEI: begin
						            case(cnt_l)
										    16'd0: begin
											           f_b_en<=1;
														  input_f<=input_i;
														  cnt_l<=cnt_l+1;
											        end
											 16'd1: begin
											           f_b_en<=0;
														  cnt_l<=cnt_l+1;
													  end  
											 16'd2: begin
											            if(fibonacci_binary_done==1)
													         begin 		
															    i<=f_b_out;
																 input_f<=input_j;
																 f_b_en<=1;
																 cnt_l<=cnt_l+1;
																end 
															else
															   cnt_l<=cnt_l;
													  end 
											 16'd3: begin
														 f_b_en<=0;
														 cnt_l<=cnt_l+1;
													  end 
											 16'd4: begin
											          if(fibonacci_binary_done==1)
														    begin 
															   j<=f_b_out;
																done<=1;
																cnt_l<=0;
															 end
														 else 
														   cnt_l<=cnt_l;  
															  
													  end 
											 default: cnt_l<=0;
													
										endcase 
						           
						         end
						 COMPARE: begin 
						            if((i<(j*div)))
										   div<=div-1;
										else if(i==j*div)
										   div<=div;
						            else if((i>(j*div))&&(i>(j*(div+1))))
							            div<=div+1;
										if(i==j*div)
										   begin
											  div_done<=1;
											  out_div<=div;
											  out_yu_shu<=0;
										   end 
									   else if((i>(j*div))&&(i<(j*(div+1))))
										   begin
                                    if(div==0)
												   begin
													  div_done<=1;
													  out_div<=0;
													  out_yu_shu<=input_i;
													end
												else if(div==1)
											      begin
													  done<=1;
													  i<= input_i;
													  j<= input_j;
													  sub_en<=1;
												   end
											   else begin 		
											   case(cnt_l)
												  16'd0: begin
												           b_f_en<=1;
															  cnt_l<=cnt_l+1;
															end 
												  16'd1: begin
												            b_f_en<=0;
																cnt_l<=cnt_l+1;
															end
												  16'd2: begin
												           if(convert_done==1)
															    begin
																   i<=input_i;
																   done<=1;
																	cnt_l<=0;
																	j<=b_f_out;
																	sub_en<=1;
																 end  
														   end 	
											      default: cnt_l<=0;		
												endcase 
												end 
											end
										else if((i<(j*div)))
										   div<=div-1;
									   end 
						         
						 SUB: begin
						         sub_en<=0;
									if(sub_done==1)
									  begin
                               i<=0;
										 j<=0; 
									    done<=1;
									    out_div<=div;
									    out_yu_shu<=yu_shu;
										 div_done<=1;
									  end 
									else
									  done<=0;
					         end 	 
				  endcase 
			 end 
			 
      end 	
endmodule