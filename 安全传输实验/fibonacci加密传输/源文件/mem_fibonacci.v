module mem_fibonacci(rst,cnt_1,mem1,cnt_2,mem2);
input rst;
input [9:0] cnt_1;
input [9:0] cnt_2;
output reg [15:0] mem1;
output reg [15:0] mem2;
 reg [22:0] mem[32:0];
  always@(negedge rst) begin 
      mem[0]=0;
      mem[1]=1;
		mem[2]=1;
		mem[3]=2;
		mem[4]=3;
		mem[5]=5;
		mem[6]=8;
		mem[7]=13;
		mem[8]=21;
		mem[9]=34;
		mem[10]=55;
		mem[11]=89;
		mem[12]=144;
		mem[13]=233;
		mem[14]=377;
		mem[15]=610;
		mem[16]=987;
		mem[17]=1597;
		mem[18]=2584;
		mem[19]=4181;
		mem[20]=6765;
		mem[21]=10946;
		mem[22]=17711;
		mem[23]=28657;
		mem[24]=46368;
		mem[25]=75025;
		mem[26]=121393;
		mem[27]=196418;
		mem[28]=317811;
		mem[29]=514229;
		mem[30]=832040;
		mem[31]=1346269;
		mem[32]=2178309;
    end 
	 always@(cnt_1)begin
	     mem1=mem[cnt_1];
	 end 
	 
	 always@(cnt_2)begin
	     mem2=mem[cnt_2];
	 end 
endmodule  