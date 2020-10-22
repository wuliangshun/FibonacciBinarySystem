module  IP(input [1:64] in,
		   output [1:32] L_i_var,
		   output [1:32] R_i_var);	
		   
assign  {L_i_var, R_i_var} = {in[58],in[50],in[42],in[34],in[26],in[18],in[10],in[2],

						              		  in[60],in[52],in[44],in[36],in[28],in[20],in[12],in[4],

					               			  in[62],in[54],in[46],in[38],in[30],in[22],in[14],in[6],

							                in[64],in[56],in[48],in[40],in[32],in[24],in[16],in[8],

								              in[57],in[49],in[41],in[33],in[25],in[17],in[9],in[1],

								              in[59],in[51],in[43],in[35],in[27],in[19],in[11],in[3],

								              in[61],in[53],in[45],in[37],in[29],in[21],in[13],in[5],

								              in[63],in[55],in[47],in[39],in[31],in[23],in[15],in[7]};
								 
endmodule 