module pc_1(input [1:64] key_i,
	          output [1:28] C0,
	          output [1:28] D0);
			
assign     C0={key_i[57],key_i[49],key_i[41],key_i[33],key_i[25],key_i[17],key_i[9],

				       key_i[1],key_i[58],key_i[50],key_i[42],key_i[34],key_i[26],key_i[18],

				       key_i[10],key_i[2],key_i[59],key_i[51],key_i[43],key_i[35],key_i[27],

				       key_i[19],key_i[11],key_i[3],key_i[60],key_i[52],key_i[44],key_i[36]};

 

assign         D0={key_i[63],key_i[55],key_i[47],key_i[39],key_i[31],key_i[33],key_i[15],

				           key_i[7],key_i[62],key_i[54],key_i[46],key_i[38],key_i[30],key_i[22],

				           key_i[14],key_i[6],key_i[61],key_i[53],key_i[45],key_i[37],key_i[29],

				           key_i[21],key_i[13],key_i[5],key_i[28],key_i[20],key_i[12],key_i[4]};
					
endmodule
