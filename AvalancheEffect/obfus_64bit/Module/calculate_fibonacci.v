module calculate_fibonacci(clk,rst,begin_fibo_en,input_i,fibo_out,calculate_done);
   input clk;
	input rst;
	input begin_fibo_en;
	input [9:0]input_i;
	output reg [15:0] fibo_out;
	output reg calculate_done;
	
	reg [15:0] a ; 
	reg [15:0] b ;
	reg [15:0] c ;
	reg [15:0] d ;
	reg [15:0] e ;
	reg [4:0] counter; 
	reg [2:0] flow_cnt;   //流水计数器
	
	reg [1:0] STATE;
	parameter IDLE_STATE=3'b00, CASE_ZERO=3'b01, CASE_ONE=3'b10, CALCULATE=3'b11;
   always @ (posedge clk or negedge rst) begin   //计算fibonacci数
		if (!rst)
			begin
			  fibo_out <= 0;
			  a <= 1'b0;
			  b <= 1'b1;
			  c <= 0;
			  d <= 0;
			  e <= 0;
			  flow_cnt<=0;
			  counter <= 5'd31;
			  calculate_done = 1'b0;
			  STATE <= IDLE_STATE;
			end
		 else
			begin
			case (STATE)
				IDLE_STATE: begin
				              fibo_out <= 1'b0;
			                 a <= 1'b0;
			                 b <= 1'b1;
			                 c <= 0;
			                 d <= 0;
			                 e <= 0;
			                 flow_cnt<=0;
			                 counter <= 5'd31;
				              calculate_done <= 1'b0;
								if(begin_fibo_en == 1)	
									STATE <= CASE_ZERO;
								else
									STATE <= IDLE_STATE;
								end    
					 
				CASE_ZERO: 	begin
								  if(input_i > 0)
									   STATE <= CASE_ONE;
								  else
									  begin
									   fibo_out <= 0;
									   STATE <= IDLE_STATE;
									   calculate_done<=1'b1;
									end
								end
					 
				CASE_ONE: 	begin
								if(input_i > 1)
									STATE <= CALCULATE ;
								else
									begin
									fibo_out <= 1;
									calculate_done<=1'b1;
									STATE = IDLE_STATE;
									end
								end
				CALCULATE: begin
				            case(flow_cnt)
								  3'd0: begin
								          d <= a * (b + b - a);
											 e <= a * a + b * b;
											 flow_cnt<=flow_cnt+1;
										  end
								  3'd1: begin
								           a <= d;
											  b <= e;
											  if(((input_i >> counter) & 1)!=0)
											      flow_cnt<=flow_cnt+1;
											  else
											      flow_cnt<=flow_cnt+3;
										   end 	
									3'd2: begin
									         c <= a + b;
												flow_cnt<=flow_cnt+1;
											end 
									3'd3: begin
									        a <= b;
											  b <= c;
											  flow_cnt<=flow_cnt+1;
											end 
									3'd4: begin
									        fibo_out <= a;
											  counter<=counter-1;
											  if(counter==0)
											     begin
												    calculate_done<=1;
													 STATE <= IDLE_STATE;
												  end 
											  else
											     flow_cnt<=0;
											end
											
									default: flow_cnt<=0;
										
								endcase
							 end 
			      endcase
			  end
     end
endmodule 