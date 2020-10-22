module key_get(input [1:56] pre_key,
			   input des_mode,
               input [3:0] inter_num,
               output wire [1:48] new_key,
               output reg [1:56] out_key);
              
  
  reg pre_key_0, pre_key_1;
  reg [1:56] pre_key_var;
              
  always @(*)
  begin
  if(des_mode == 1'b0)
	  begin
		case(inter_num)
		 4'd0, 4'd1, 4'd8, 4'd15:
		 begin
		   pre_key_var = pre_key;
		   pre_key_0 = pre_key_var[1];
		   pre_key_var[1:28] =  pre_key_var[1:28] << 1;
		   pre_key_var[28] = pre_key_0;
		   pre_key_0 = pre_key_var[29];
		   pre_key_var[29:56] =  pre_key_var[29:56] << 1;
		   pre_key_var[56] = pre_key_0;  
		 end     
		4'd2, 4'd3, 4'd4, 4'd5, 4'd6, 4'd7, 4'd9, 4'd10, 4'd11, 4'd12, 4'd13, 4'd14:
		 begin
		   pre_key_var = pre_key;
		   {pre_key_1, pre_key_0} = pre_key_var[1:2];
		   pre_key_var[1:28] =  pre_key_var[1:28] << 2;
		   pre_key_var[27:28] = {pre_key_1, pre_key_0};
		   {pre_key_1, pre_key_0} = pre_key_var[29:30];
		   pre_key_var[29:56] =  pre_key_var[29:56] << 2;
		   pre_key_var[55:56] = {pre_key_1, pre_key_0};  
		end  
	  endcase
	  end
	else
	begin
	    case(inter_num)
			4'd0: pre_key_var = pre_key;
			4'd1, 4'd8, 4'd15:
			begin
			   pre_key_var = pre_key;
			   pre_key_0 = pre_key_var[28];
			   pre_key_var[1:28] =  pre_key_var[1:28] >> 1;
			   pre_key_var[1] = pre_key_0;
			   pre_key_0 = pre_key_var[56];
			   pre_key_var[29:56] =  pre_key_var[29:56] >> 1;
			   pre_key_var[29] = pre_key_0;  
			 end     
			default: 
			 begin   
			   pre_key_var = pre_key;
			   {pre_key_1, pre_key_0} = pre_key_var[27:28];
			   pre_key_var[1:28] =  pre_key_var[1:28] >> 2;
			   pre_key_var[1:2] = {pre_key_1, pre_key_0};
			   {pre_key_1, pre_key_0} = pre_key_var[55:56];
			   pre_key_var[29:56] =  pre_key_var[29:56] >> 2;
			   pre_key_var[29:30] = {pre_key_1, pre_key_0};  
			end  
		endcase
	end
	out_key = pre_key_var;
  end
    
	
    assign   new_key  =  {pre_key_var[14],pre_key_var[17],pre_key_var[11],pre_key_var[24],pre_key_var[1],pre_key_var[5],

						  pre_key_var[3],pre_key_var[28],pre_key_var[15],pre_key_var[6],pre_key_var[21],pre_key_var[10],

					      pre_key_var[23],pre_key_var[19],pre_key_var[12],pre_key_var[4],pre_key_var[26],pre_key_var[8],

					      pre_key_var[16],pre_key_var[7],pre_key_var[27],pre_key_var[20],pre_key_var[13],pre_key_var[2],

					      pre_key_var[41],pre_key_var[52],pre_key_var[31],pre_key_var[37],pre_key_var[47],pre_key_var[55],

				          pre_key_var[30],pre_key_var[40],pre_key_var[51],pre_key_var[45],pre_key_var[33],pre_key_var[48],

				          pre_key_var[44],pre_key_var[49],pre_key_var[39],pre_key_var[56],pre_key_var[34],pre_key_var[53],

				          pre_key_var[46],pre_key_var[42],pre_key_var[50],pre_key_var[36],pre_key_var[29],pre_key_var[32]};
   

endmodule 