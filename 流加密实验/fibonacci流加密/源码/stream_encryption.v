module stream_encryption(clk,en,rst,N_count,M_count,en_b_f,N_convert_done,	M_convert_done,N_fibonacci,M_fibonacci,all_done,C,out_c);
   input clk;
	input rst;
	input en;
	output reg all_done;
	input [31:0] N_fibonacci;
	input [31:0] M_fibonacci;
	input M_convert_done;
	input N_convert_done;
   output reg [15:0] N_count;
	output reg [15:0] M_count;
	output reg en_b_f;
	output reg [31:0] C;
	output reg out_c;
	
	
//*********初始化参数*******	
	parameter k1_a = 8;
	parameter k1_c = 14;
	parameter k1_u = 17;
	
	parameter k2_a = 5;
	parameter k2_c = 11;
	parameter k2_u = 13;
	
	parameter N0=20;
	parameter M0=30;
	parameter L=32;
	parameter H=8;   //假设数据长度为8   
//***************************
   reg done;
	reg [9:0] count;
	reg [15:0] N_count_1;
	reg [15:0] M_count_1;
	reg [5:0] m_N;
	reg [5:0] m_M;
	reg [5:0] cnt;
	reg [5:0] U;
	reg [9:0] t;
	
	reg [5:0] cnt_1;
	reg [5:0] cnt_2;
	reg [5:0] cnt_3;
  
   reg [2:0] current_state;
   reg [2:0] next_state;
	
	parameter IDLE=3'b000;
	parameter BEGIN=3'b001;          //计算出一对N,M值
	parameter WAIT=3'b010;           //等待转换成FIBONACCI标准式
	parameter calculate_m =3'b011;   // 计算标准式中一的个数。
	parameter YI_HUO=3'b100;         //对交集部分进行异或处理，返回BEGIN进行下一循环。
   
   always @(posedge clk or negedge rst )begin
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
					 BEGIN:begin 
					         if(all_done==1)
								   next_state = IDLE;
					         else if(done==1)
								   next_state = WAIT ;
							   else
								   next_state =BEGIN;
							 end 
					 WAIT: begin
					           if(done==1)
								    next_state = calculate_m;
								  else 
								    next_state = WAIT;
							 end
					 calculate_m : begin
					                 if(done==1)
					                  next_state = YI_HUO;
										  else 
										   next_state = calculate_m;
										end 
					  YI_HUO: begin 
					             if(done==1)
									    next_state = BEGIN;
									 else 
									    next_state = YI_HUO;
					          end 
					default: next_state =IDLE;
				 endcase 
		 end 
	end 	 
	
	always @(posedge clk or negedge rst) 
	
	      if(!rst)
			  begin
			   done<=0;
				count<=1;
				m_N<=0;
				m_M<=0;
				C<=0;
				cnt<=0;
				out_c<=0;
			  end 
			else begin
			    out_c<=0;  //输出密码序列C的脉冲信号
			    done<=0;
				 case(next_state)
				    IDLE: begin
					          all_done<=0;
					          if(en==1)
								   begin 
								    N_count_1<=N0;
									 M_count_1<=M0;
									 C<=0;
								    done<=1;
									end 
								 else
								    done<=0;
							 end 
					  BEGIN: begin
					            if(count<=H)
			                      begin
					                   N_count<= (N_count_1* k1_a+k1_c)%k1_u;
	                               M_count<= (M_count_1* k2_a+k2_c)%k2_u;	
		                            done<=1;
		                            en_b_f<=1;									 
                               end 
						         else begin 
								     count<=1;	
				                 all_done<=1;	
							      end 		  
								end 
						WAIT: begin
						          N_count_1<=N_count;
									 M_count_1 <= M_count;
						          en_b_f<=0;
									 if((M_convert_done==1)&&(N_convert_done==1))
									    done<=1;
									 else if((M_convert_done==1)&&(N_convert_done==0))
									    cnt<=cnt+1;
									 else if((M_convert_done==0)&&(N_convert_done==1))
									    cnt<=cnt+1;
									 else if(cnt==2)
									   begin 
									    done<=1;
										 cnt<=0;
										 cnt_1<=8;
										 cnt_2<=16;
										 cnt_3<=24;
										end  
				            end 
						calculate_m:begin             // cnt_1和cnt,cnt_2,cnt_3   四个计数器同时进行遍历,加快遍历速度。  本次设计fibonacci标准式长度位32位，若初始参数设置很小，可以降低位数，来提高反应速度。
						               if(cnt<=7)
											  begin
											    cnt_3<=cnt_3+1;
												 cnt_2<=cnt_2+1;
												 cnt_1<=cnt_1+1;
												 cnt<=cnt+1;
											    case({N_fibonacci[cnt],N_fibonacci[cnt_1],N_fibonacci[cnt_2],N_fibonacci[cnt_3]})
												   4'b0000: m_N<=m_N;
												   4'b0001: m_N<=m_N+1;
												   4'b0010: m_N<=m_N+1;
												   4'b0011: m_N<=m_N+2;
												   4'b0100: m_N<=m_N+1;
												   4'b0101: m_N<=m_N+2;
												   4'b0110: m_N<=m_N+2;
												   4'b0111: m_N<=m_N+3;
												   4'b1000: m_N<=m_N+1;
												   4'b1001: m_N<=m_N+1;
												   4'b1010: m_N<=m_N+2;
												   4'b1011: m_N<=m_N+3;
												   4'b1100: m_N<=m_N+2;
												   4'b1101: m_N<=m_N+3;
												   4'b1110: m_N<=m_N+3;
												   4'b1111: m_N<=m_N+4;	
												 endcase 
												
												case({M_fibonacci[cnt],M_fibonacci[cnt_1],M_fibonacci[cnt_2],M_fibonacci[cnt_3]})
												   4'b0000: m_M<=m_M;
												   4'b0001: m_M<=m_M+1;
												   4'b0010: m_M<=m_M+1;
												   4'b0011: m_M<=m_M+2;
												   4'b0100: m_M<=m_M+1;
												   4'b0101: m_M<=m_M+2;
												   4'b0110: m_M<=m_M+2;
												   4'b0111: m_M<=m_M+3;
												   4'b1000: m_M<=m_M+1;
												   4'b1001: m_M<=m_M+1;
												   4'b1010: m_M<=m_M+2;
												   4'b1011: m_M<=m_M+3;
												   4'b1100: m_M<=m_M+2;
												   4'b1101: m_M<=m_M+3;
												   4'b1110: m_M<=m_M+3;
												   4'b1111: m_M<=m_M+4;	
												 endcase 
											  end
											 else
											   begin
										       C<=0;		
											    done<=1;
												 if(m_N>=m_M)
												   cnt<=m_N-1;
												 else 
												   cnt<=m_M-1;
											   end  
								      end 
						 YI_HUO: begin                                //2个时钟周期完成异或处理。
						              cnt<=cnt+16;
			                       if(cnt<=L-cnt-1)
											   C[0]=N_fibonacci[cnt]^M_fibonacci[cnt]; 
											 
											if((cnt+1)<=L-cnt-1)
											   C[1]=N_fibonacci[cnt+1]^M_fibonacci[cnt+1];
											 
											if((cnt+2)<=L-cnt-1)
											   C[2]=N_fibonacci[cnt+2]^M_fibonacci[cnt+2];
											
											if((cnt+3)<=L-cnt-1)
											   C[3]=N_fibonacci[cnt+3]^M_fibonacci[cnt+3];
											 
											if((cnt+4)<=L-cnt-1)
											   C[4]=N_fibonacci[cnt+4]^M_fibonacci[cnt+4]; 
											  
											 if((cnt+5)<=L-cnt-1)
											   C[5]=N_fibonacci[cnt+5]^M_fibonacci[cnt+5];
											 
											if((cnt+6)<=L-cnt-1)
											   C[6]=N_fibonacci[cnt+6]^M_fibonacci[cnt+6];
								
											if((cnt+7)<=L-cnt-1)
											   C[7]=N_fibonacci[cnt+7]^M_fibonacci[cnt+7];
											  
											if((cnt+8)<=L-cnt-1)
											   C[8]=N_fibonacci[cnt+8]^M_fibonacci[cnt+8];
											 
											if((cnt+9)<=L-cnt-1)
											   C[9]=N_fibonacci[cnt+9]^M_fibonacci[cnt+9];
											  
											  if((cnt+10)<=L-cnt-1)
											   C[10]=N_fibonacci[cnt+10]^M_fibonacci[cnt+10];
											 
											if((cnt+11)<=L-cnt-1)
											   C[11]=N_fibonacci[cnt+11]^M_fibonacci[cnt+11];
											  
											  if((cnt+12)<=L-cnt-1)
											   C[12]=N_fibonacci[cnt+12]^M_fibonacci[cnt+12];
											 
											if((cnt+13)<=L-cnt-1)
											   C[13]=N_fibonacci[cnt+13]^M_fibonacci[cnt+13]; 
											  
											 if((cnt+14)<=L-cnt-1)
											   C[14]=N_fibonacci[cnt+14]^M_fibonacci[cnt+14];
											 
											if((cnt+15)<=L-cnt-1)
											   C[15]=N_fibonacci[cnt+15]^M_fibonacci[cnt+15]; 
											  
											if((cnt==m_N+15)||(cnt==m_M+15))begin 
										    count<=count+1; 
										    cnt<=0;
										    done<=1;
											 out_c<=1;
											 m_N<=0;
											 m_M<=0;
											end 
					            end 				
						
				 endcase 
			end 
endmodule 
		 