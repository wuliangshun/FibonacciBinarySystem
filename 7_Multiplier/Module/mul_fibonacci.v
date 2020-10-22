module mul_fibonacci(clk,rst,en_mul,input_i,input_j,out_mul,mul_done);
   input clk;
	input rst;
	input en_mul;
	input [31:0] input_i;
	input [31:0] input_j;
	output reg [31:0] out_mul;
	output reg mul_done;
	
	reg done;
	reg [9:0] n;
	reg [9:0] M;
	reg [9:0] N;
	reg [9:0] count_i;
	reg [9:0] count_j;
	reg [9:0] cnt;
	reg [31:0] mul_in;
	wire [31:0] mul_out;
	wire sum_done;
	reg [31:0] sum;
	reg en_sum;
	
	reg [2:0] current_state;
	reg [2:0] next_state;
	
	parameter IDLE=3'b000;
	parameter FEN_JIE=3'b001;
	parameter DAN_XIANG_SHI=3'b010;
	parameter SUM=3'b011;
	
	//*****例化加法器****************
	sum_fibonacci u_sum_fibonacci(
	     .clk       (clk),
		  .rst       (rst),
	     .en_sum    (en_sum),
		  .input_i   (mul_in),
		  .input_j   (sum),
		  .out_sum   (mul_out),
		  .sum_done  (sum_done)
	);
	
	//**************************
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
							  next_state = FEN_JIE;
							  else
							  next_state = IDLE; 
				        end
				  FEN_JIE: begin
				             if(mul_done==1)
								   next_state = IDLE; 
				             else if(done==1)
								   next_state = DAN_XIANG_SHI;
								 else 
								   next_state = FEN_JIE;
				           end
				  DAN_XIANG_SHI: begin
				                   if(done==1)
										   next_state = SUM;
										 else
										   next_state = DAN_XIANG_SHI; 
				                 end   
				  SUM: begin
				         if(done==1)
							   next_state = FEN_JIE;
							else
								next_state = SUM;
				       end
					default: next_state = IDLE;	 
				endcase 
	      end
       end 			
			
	always @(posedge clk or negedge rst) begin
	        if(!rst)
			    begin
				   mul_done<=0;
					done<=0;
					out_mul<=0;
					n<=0;
					M<=0;
					N<=0;
					count_i<=0;
					count_j<=0;
					cnt<=0;
					mul_in<=0;
					sum<=0;
				 end 
			  else 
			    begin
				    done<=0;
				    case(next_state)
					    IDLE: begin
						          mul_done<=0;
									 mul_in<=0;
									 count_i<=1;
									 count_j<=1;
						          if(en_mul==1)
										  done<=1;
									 else 
							           done<=0;	 
								 end
						 FEN_JIE: begin
						             if(count_i<=31)
										    begin
											    if(input_i[count_i]==1)
												    begin 
											          if(count_j<=31)
												          begin
													          if(input_j[count_j]==1)
																    done<=1;
																 else
																    count_j<=count_j+1;
													       end
														 else
														    begin 
															   count_j<=1;
																count_i<=count_i+1;
															 end 
													 end 
												 else 
											       count_i<=count_i+1; 		
											 end 
										 else
										   begin 
											  out_mul<=mul_out;
										     count_i<=1;
											  mul_done<=1;
									      end
									 end 
						 DAN_XIANG_SHI: begin
						                   if(count_i==1)
												    begin
													   en_sum<=1;
													   done<=1;
														sum[count_j]<=1;
													 end 
												 else if(count_j==1)
												    begin
													   en_sum<=1;
													   done<=1;
													   sum[count_i]<=1;	
											       end
												 else 
												    begin 
													    if(((count_i-2)/2)<=((count_j-2)/2)&&((count_i-2)/2)<=((count_i+count_j-2)/4))
														    begin 
														     n<=(count_i-2)/2;
															  M<=4*((count_i-2)/2)+2;
															  N<=2*((count_i-2)/2)+2;
															 end 
														 else if(((count_j-2)/2)<=((count_i+count_j-2)/4))
														    begin  
														     n<=(count_j-2)/2;
															  M<=4*((count_j-2)/2)+2;
															  N<=2*((count_j-2)/2)+2;
															 end 
														 else 
														    begin 
														     n<=(count_i+count_j-2)/4;
														     M<=4*((count_i+count_j-2)/4)+2;
															  N<=2*((count_i+count_j-2)/4)+2;
														    end 
														 if(M>0)
														    begin 
															    if(cnt<(n+2))
																    begin
																	    cnt<=cnt+1;
																	    if(cnt==(n+1))
																		    begin
																			   en_sum<=1;
																			   done<=1;
																			   cnt<=0;
																				if((count_i-N==0)||(count_j-N==0))
																				    sum[0]<=0;
																				else begin 
																			       if(count_i-N==1)
																				        sum[count_j-N]<=1;
																				    else if(count_j-N==1)
																				        sum[count_i-N]<=1;
																				end 
																			 end 
																		 else
																		   begin  
																	         sum[count_i+count_j-4*cnt-2]<=1;
																		   end 
																	 end 
															 end 
														 
													 end 
						                end 
									    
                   SUM: begin
						         en_sum<=0;
									if(sum_done==1)
									   begin 
										 n<=0;
										 M<=0;
										 N<=0;
										 cnt<=0;
										 sum<=0;
									    done<=1;
									    mul_in<=mul_out;
										 count_j<=count_j+1;
										end
									else
								       done<=0;	
						      end 
						endcase 
					end	
		end
endmodule 