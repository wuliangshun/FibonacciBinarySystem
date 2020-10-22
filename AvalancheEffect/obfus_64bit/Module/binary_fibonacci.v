module binary_fibonacci(input_binary, rst, begin_b_f, clk, convert_done, binary_fibonacci_out) ; 
	input  [15:0] input_binary ; 
	input  rst ; 
	input  begin_b_f ; 
	input  clk ; 
	output convert_done ; 
	output  binary_fibonacci_out;
	reg [31:0] binary_fibonacci_out;
	reg convert_done;	
//	**************************
	reg [15:0] fibo_cnt;  //数据寄存器
	reg [15:0] fibo_cnt_;
	reg [31:0] bin_fib;
	reg [15:0] input_b ;     
	
	wire [31:0]fibo_out;
	wire calculate_done;
	reg begin_fibo_en;  //计算fibonacci数使能信号
	reg [9:0] cnt; 
	
	reg done;
	reg [1:0] next_state;
	reg [1:0] current_state;  //定义转化状态。
	                                                      //parameters used to declare states
   parameter convert_init= 2'b00, convert_begin=2'b01,convert_wait=2'b10, convert_compare=2'b11;
	
/**********************************************求fibonacci进制的标准式*/	
//例化计算fibonacci数模块。
  calculate_fibonacci u_calculate_fibonacci (
        .clk              (clk),
		  .rst              (rst),
		  .begin_fibo_en    (begin_fibo_en),
		  .input_i          (cnt),
		  .fibo_out         (fibo_out),
		  .calculate_done    (calculate_done)
	);
	always @(posedge clk or negedge rst) begin
	         if(!rst)
				  current_state<=convert_init;
				else
				  current_state <= next_state;
			end 
	always @(*)begin
	         if(!rst)
				  next_state <= convert_init;
				else begin
				  case(current_state)
				     convert_init: begin
					                   if(done==1)
											   next_state = convert_begin;
											 else
											   next_state = convert_init;
										 end
						convert_begin: begin
						                  if(convert_done==1)
												  next_state = convert_init;
												else if(done==1)
												  next_state = convert_wait;
												else 
												  next_state = convert_begin;
											end 
						convert_wait : begin
						                  if(done==1)
												  next_state = convert_compare;
												else
												  next_state = convert_wait; 
												  
											end 
						convert_compare: begin
						                    if(done==1)
												     begin
													    if(bin_fib[cnt-1]==1)
												         next_state = convert_begin;
														 else
														   next_state = convert_wait;
													  end 
												  else 
													  next_state = convert_compare;
						                 end 
					  
				  endcase 
				end 
		   end 
			
	always @(posedge clk or negedge rst) begin
	         if(!rst)
				  begin
				   bin_fib<=32'b0;
		         input_b<=32'b0;
		         binary_fibonacci_out<=32'b0;
		         convert_done <=1'b0;
		         cnt <=5'b0;
		         fibo_cnt <=32'b0;
			      fibo_cnt_<=32'b0;
		         begin_fibo_en <=1'b0;
				  end
				else begin
				    done<=0;
				   case(next_state)
					  convert_init:begin
					                 convert_done<=1'b0;
							           bin_fib<=32'b0;
								        if(begin_b_f==1)
					                    begin
						                  input_b<=input_binary;
								            done<=1;
								            end
					                 else
					                   done<=0;
							         end 
						convert_begin:begin
						                cnt<=5'b0;
					                   if(input_b==0)
					                     begin
						                     convert_done<=1'b1;
								               binary_fibonacci_out<=bin_fib;
								          end
								          else
								            begin 
								              done<=1;
		                                begin_fibo_en<=1;
								            end 
						              end
						convert_wait:begin
						                begin_fibo_en<=1'b0;
		                            if(calculate_done==1)
								            begin
									           begin_fibo_en <=1'b0;
							                 fibo_cnt<=fibo_out;
									           fibo_cnt_<=fibo_cnt;
									           done<=1;
									         end
							             else
							               done<=0;
										 end 
						convert_compare: begin
						                    if(fibo_cnt>input_b)
							                    begin 
									                bin_fib[cnt-1]<=1'b1;
									                input_b <= input_b-fibo_cnt_;
									                done<=1;
								                 end	
								              else
								                 begin
									                begin_fibo_en<=1;
								                   cnt<=cnt+1'b1;
									                done<=1;
								                 end
											  end 
											  
						
							 
				   endcase
				end
			
			end 
	
	
	
endmodule