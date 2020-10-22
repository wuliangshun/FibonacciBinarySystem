module binary_fibonacci(input_binary, rst, begin_b_f, clk, convert_done, fibonacci_standard,mema,cnt_a) ; 
	input  [15:0] input_binary ; 
	input  rst ; 
	input  begin_b_f ; 
	input  clk ; 
	input [15:0] mema;
	output reg [9:0] cnt_a;
	output convert_done ; 
	output  fibonacci_standard;
	reg [31:0] fibonacci_standard;
	reg convert_done;	
//	**************************
	reg [15:0] fibo_cnt;  //数据寄存器
	reg [31:0] bin_fib;
	reg [15:0] input_b ;     
	reg [1:0] convert_state;  //定义转化状态。
	

	                                                      //parameters used to declare states
   parameter convert_init= 2'b00, convert_begin=2'b01,convert_wait=2'b10, convert_compare=2'b11;
	
/**********************************************求fibonacci进制的标准式*/	

	always@(posedge clk or negedge rst)	
       if(!rst)
		   begin
			 bin_fib<=32'b0;
		    input_b <=32'b0;
		    fibonacci_standard<=32'b0;
		    convert_done <=1'b0;
		    cnt_a <=5'b0;
		    fibo_cnt <=16'b0;
			 convert_state <=convert_init;
		   end
		 else
		   begin
			  case(convert_state)
			 convert_init:begin
			              convert_done<=1'b0;
							  bin_fib<=32'b0;
			              if(begin_b_f==1)
					         begin
						       input_b<=input_binary;
						       convert_state<=convert_begin;
								 end
					         else
					          convert_state<=convert_init;
					        end
					
			 convert_begin:begin
		                    cnt_a<=5'b0;
					          if(input_b==0)
					           begin
						        convert_done<=1'b1;
								  fibonacci_standard<=bin_fib;
								  convert_state<=convert_init;
								  end
								 else
								   begin 
									    if(mema>input_b)
							             begin 
									          bin_fib[cnt_a-1]<=1'b1;
									          input_b <= input_b-fibo_cnt;
								          end	
								       else
								         begin
									       fibo_cnt<=mema;
								          cnt_a<=cnt_a+1'b1;
								          end
								    end 
                         end
             default: convert_state <= convert_init;		
				endcase
			end
			
	
	
endmodule
 