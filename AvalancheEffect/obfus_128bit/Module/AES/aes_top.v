include "timescale.v";
module aes_top(clk, rst, kld, sel,ld, done, key, text_in, text_out );
input	clk, rst;
input	kld, ld,sel;
output	done;
input	[127:0]	key;
input	[127:0]	text_in;
output	[127:0]	text_out;

reg[31:0]	wk0, wk1, wk2, wk3;
wire	[31:0]	w0, w1, w2, w3;
reg    [31:0] w_k0,w_k1,w_k2,w_k3;
reg	[127:0]	text_in_r;
reg	[127:0]	text_out;

reg	[7:0]	sa00, sa01, sa02, sa03;
reg	[7:0]	sa10, sa11, sa12, sa13;
reg	[7:0]	sa20, sa21, sa22, sa23;
reg	[7:0]	sa30, sa31, sa32, sa33;

wire	[7:0]	sa00_next, sa01_next, sa02_next, sa03_next;
wire	[7:0]	sa10_next, sa11_next, sa12_next, sa13_next;
wire	[7:0]	sa20_next, sa21_next, sa22_next, sa23_next;
wire	[7:0]	sa30_next, sa31_next, sa32_next, sa33_next;

wire	[7:0]	sa00_sub, sa01_sub, sa02_sub, sa03_sub;
wire	[7:0]	sa10_sub, sa11_sub, sa12_sub, sa13_sub;
wire	[7:0]	sa20_sub, sa21_sub, sa22_sub, sa23_sub;
wire	[7:0]	sa30_sub, sa31_sub, sa32_sub, sa33_sub;

wire	[7:0]	sa00_sr, sa01_sr, sa02_sr, sa03_sr;
wire	[7:0]	sa10_sr, sa11_sr, sa12_sr, sa13_sr;
wire	[7:0]	sa20_sr, sa21_sr, sa22_sr, sa23_sr;
wire	[7:0]	sa30_sr, sa31_sr, sa32_sr, sa33_sr;

wire	[7:0]	sa00_ark, sa01_ark, sa02_ark, sa03_ark;
wire	[7:0]	sa10_ark, sa11_ark, sa12_ark, sa13_ark;
wire	[7:0]	sa20_ark, sa21_ark, sa22_ark, sa23_ark;
wire	[7:0]	sa30_ark, sa31_ark, sa32_ark, sa33_ark;

reg		ld_r, done;
reg	[3:0]	dcnt;
reg    go=0;
//shangsheng 'go'
always @(posedge clk)
	if(!rst)	go <= #1 1'b0;
	else
	if(sel)		go <= #1 1'b1;
	else
	if(done)	go <= #1 1'b0;


always @(posedge clk)
	if(!rst)	dcnt <= #1 4'h0;
	else
	if(done)	dcnt <= #1 4'h0;
	else
	if(ld)		dcnt <= #1 4'h1;
	else
	if(go)		dcnt <= #1 dcnt + 4'h1;
	

always @(posedge clk)	done <= #1 (dcnt==4'hb) & !ld;


always @(posedge clk)	if(ld)	text_in_r <= #1 text_in;
//read

always @(posedge clk)	ld_r <= #1 ld;
//ld为1时text_in与初始密钥异或，ld为0时等于saxx_next
always @(posedge clk)	sa33 <= #1 ld_r ? text_in_r[007:000] ^ w3[07:00] : sa33_next;
always @(posedge clk)	sa23 <= #1 ld_r ? text_in_r[015:008] ^ w3[15:08] : sa23_next;
always @(posedge clk)	sa13 <= #1 ld_r ? text_in_r[023:016] ^ w3[23:16] : sa13_next;
always @(posedge clk)	sa03 <= #1 ld_r ? text_in_r[031:024] ^ w3[31:24] : sa03_next;
always @(posedge clk)	sa32 <= #1 ld_r ? text_in_r[039:032] ^ w2[07:00] : sa32_next;
always @(posedge clk)	sa22 <= #1 ld_r ? text_in_r[047:040] ^ w2[15:08] : sa22_next;
always @(posedge clk)	sa12 <= #1 ld_r ? text_in_r[055:048] ^ w2[23:16] : sa12_next;
always @(posedge clk)	sa02 <= #1 ld_r ? text_in_r[063:056] ^ w2[31:24] : sa02_next;
always @(posedge clk)	sa31 <= #1 ld_r ? text_in_r[071:064] ^ w1[07:00] : sa31_next;
always @(posedge clk)	sa21 <= #1 ld_r ? text_in_r[079:072] ^ w1[15:08] : sa21_next;
always @(posedge clk)	sa11 <= #1 ld_r ? text_in_r[087:080] ^ w1[23:16] : sa11_next;
always @(posedge clk)	sa01 <= #1 ld_r ? text_in_r[095:088] ^ w1[31:24] : sa01_next;
always @(posedge clk)	sa30 <= #1 ld_r ? text_in_r[103:096] ^ w0[07:00] : sa30_next;
always @(posedge clk)	sa20 <= #1 ld_r ? text_in_r[111:104] ^ w0[15:08] : sa20_next;
always @(posedge clk)	sa10 <= #1 ld_r ? text_in_r[119:112] ^ w0[23:16] : sa10_next;
always @(posedge clk)	sa00 <= #1 ld_r ? text_in_r[127:120] ^ w0[31:24] : sa00_next;
// 's' replace and 
assign sa00_sr = sa00_sub;
 assign sa01_sr = sa01_sub;
 assign sa02_sr = sa02_sub;
 assign sa03_sr = sa03_sub;
 assign sa10_sr = !go ? sa13_sub:sa11_sub;
 assign sa11_sr = !go ? sa10_sub:sa12_sub;
 assign sa12_sr = !go ? sa11_sub:sa13_sub;
 assign sa13_sr = !go ? sa12_sub:sa10_sub;
 assign sa20_sr = !go ? sa22_sub:sa22_sub;
 assign sa21_sr = !go ? sa23_sub:sa23_sub;
 assign sa22_sr = !go ? sa20_sub:sa20_sub;
 assign sa23_sr = !go ? sa21_sub:sa21_sub;
 assign sa30_sr = !go ? sa31_sub:sa33_sub;
 assign sa31_sr = !go ? sa32_sub:sa30_sub;
 assign sa32_sr = !go ? sa33_sub:sa31_sub;
 assign sa33_sr = !go ? sa30_sub:sa32_sub;
//hun he bian huan
assign {sa00_ark, sa10_ark, sa20_ark, sa30_ark}  = go ? mix_col(sa00_sr,sa10_sr,sa20_sr,sa30_sr): inv_mix_col(sa00_sr,sa10_sr,sa20_sr,sa30_sr);
assign {sa01_ark, sa11_ark, sa21_ark, sa31_ark}  = go ? mix_col(sa01_sr,sa11_sr,sa21_sr,sa31_sr): inv_mix_col(sa01_sr,sa11_sr,sa21_sr,sa31_sr);
assign {sa02_ark, sa12_ark, sa22_ark, sa32_ark}  = go ? mix_col(sa02_sr,sa12_sr,sa22_sr,sa32_sr): inv_mix_col(sa02_sr,sa12_sr,sa22_sr,sa32_sr);
assign {sa03_ark, sa13_ark, sa23_ark, sa33_ark}  = go ? mix_col(sa03_sr,sa13_sr,sa23_sr,sa33_sr): inv_mix_col(sa03_sr,sa13_sr,sa23_sr,sa33_sr);
//next cipter
assign sa00_next = go ? sa00_ark ^ w0[31:24]:sa00_ark ^ wk0[31:24];
assign sa01_next = go ? sa01_ark ^ w1[31:24]:sa01_ark ^ wk1[31:24];
assign sa02_next = go ? sa02_ark ^ w2[31:24]:sa02_ark ^ wk2[31:24];
assign sa03_next = go ? sa03_ark ^ w3[31:24]:sa03_ark ^ wk3[31:24];
assign sa10_next = go ? sa10_ark ^ w0[23:16]:sa10_ark ^ wk0[23:16];
assign sa11_next = go ? sa11_ark ^ w1[23:16]:sa11_ark ^ wk1[23:16];
assign sa12_next = go ? sa12_ark ^ w2[23:16]:sa12_ark ^ wk2[23:16];
assign sa13_next = go ? sa13_ark ^ w3[23:16]:sa13_ark ^ wk3[23:16];
assign sa20_next = go ? sa20_ark ^ w0[15:08]:sa20_ark ^ wk0[15:08];
assign sa21_next = go ? sa21_ark ^ w1[15:08]:sa21_ark ^ wk1[15:08];
assign sa22_next = go ? sa22_ark ^ w2[15:08]:sa22_ark ^ wk2[15:08];
assign sa23_next = go ? sa23_ark ^ w3[15:08]:sa23_ark ^ wk3[15:08];
assign sa30_next = go ? sa30_ark ^ w0[07:00]:sa30_ark ^ wk0[07:00];
assign sa31_next = go ? sa31_ark ^ w1[07:00]:sa31_ark ^ wk1[07:00];
assign sa32_next = go ? sa32_ark ^ w2[07:00]:sa32_ark ^ wk2[07:00];
assign sa33_next = go ? sa33_ark ^ w3[07:00]:sa33_ark ^ wk3[07:00];
// output
always @(posedge clk) text_out[127:120] <=#1 go ?  sa00_sr ^ w0[31:24]:sa00_sr ^ wk0[31:24];
always @(posedge clk) text_out[095:088] <=#1 go ?  sa01_sr ^ w1[31:24]:sa01_sr ^ wk1[31:24];
always @(posedge clk) text_out[063:056] <=#1 go ?  sa02_sr ^ w2[31:24]:sa02_sr ^ wk2[31:24];
always @(posedge clk) text_out[031:024] <=#1 go ?  sa03_sr ^ w3[31:24]:sa03_sr ^ wk3[31:24];
always @(posedge clk) text_out[119:112] <=#1 go ?  sa10_sr ^ w0[23:16]:sa10_sr ^ wk0[23:16];
always @(posedge clk) text_out[087:080] <=#1 go ?  sa11_sr ^ w1[23:16]:sa11_sr ^ wk1[23:16];
always @(posedge clk) text_out[055:048] <=#1 go ?  sa12_sr ^ w2[23:16]:sa12_sr ^ wk2[23:16];
always @(posedge clk) text_out[023:016] <=#1 go ?  sa13_sr ^ w3[23:16]:sa13_sr ^ wk3[23:16];
always @(posedge clk) text_out[111:104] <=#1 go ?  sa20_sr ^ w0[15:08]:sa20_sr ^ wk0[15:08];
always @(posedge clk) text_out[079:072] <=#1 go ?  sa21_sr ^ w1[15:08]:sa21_sr ^ wk1[15:08];
always @(posedge clk) text_out[047:040] <=#1 go ?  sa22_sr ^ w2[15:08]:sa22_sr ^ wk2[15:08];
always @(posedge clk) text_out[015:008] <=#1 go ?  sa23_sr ^ w3[15:08]:sa23_sr ^ wk3[15:08];
always @(posedge clk) text_out[103:096] <=#1 go ?  sa30_sr ^ w0[07:00]:sa30_sr ^ wk0[07:00];
always @(posedge clk) text_out[071:064] <=#1 go ?  sa31_sr ^ w1[07:00]:sa31_sr ^ wk1[07:00];
always @(posedge clk) text_out[039:032] <=#1 go ?  sa32_sr ^ w2[07:00]:sa32_sr ^ wk2[07:00];
always @(posedge clk) text_out[007:000] <=#1 go ?  sa33_sr ^ w3[07:00]:sa33_sr ^ wk3[07:00];


reg	[127:0]	kb[10:0];
reg	[3:0]	kcnt;
reg		kdone;
reg		kb_ld;

always @(posedge clk)
	if(!rst)	kcnt <= #1 4'ha;
	else
	if(kld)		kcnt <= #1 4'ha;
	else
	if(kb_ld)	kcnt <= #1 kcnt - 4'h1;

always @(posedge clk)
	if(!rst)	kb_ld <= #1 1'b0;
	else
	if(kld)		kb_ld <= #1 1'b1;
	else
	if(kcnt==4'h0)	kb_ld <= #1 1'b0;

always @(posedge clk)	kdone <= #1 (kcnt==4'h0) & !kld;
always @(posedge clk)	if(kb_ld) kb[kcnt] <= #1 inv_mix_col(w3, w2, w1, w0);
always @(posedge clk)	{w_k3,w_k2,w_k1,w_k0} <= #1 kb[dcnt];
always @(posedge clk)   {wk3[31:24],wk2[31:24],wk1[31:24],wk0[31:24]}<=inv_mix_col(w_k3[31:24],w_k2[31:24],w_k1[31:24],w_k0[31:24]);
always @(posedge clk)   {wk3[23:16],wk2[23:16],wk1[23:16],wk0[23:16]}<=inv_mix_col(w_k3[23:16],w_k2[23:16],w_k1[23:16],w_k0[23:16]);
always @(posedge clk)   {wk3[15:8],wk2[15:8],wk1[15:8],wk0[15:8]}<=inv_mix_col(w_k3[15:8],w_k2[15:8],w_k1[15:8],w_k0[15:8]);
always @(posedge clk)   {wk3[7:0],wk2[7:0],wk1[7:0],wk0[7:0]}<=inv_mix_col(w_k3[7:0],w_k2[7:0],w_k1[7:0],w_k0[7:0]);
aes_key_expand_128 u0(
	.clk(		clk	),
	.kld(		kld	),
	.key(		key	),
	.wo_0(		w0	),
	.wo_1(		w1	),
	.wo_2(		w2	),
	.wo_3(		w3	));
	
//逆s盒代替
sbox us00(  .s(go),	.a(	sa00	),	.d(	sa00_sub	));
sbox us01(  .s(go),	.a(	sa01	),	.d(	sa01_sub	));
sbox us02(	.s(go), .a(	sa02	),	.d(	sa02_sub	));
sbox us03(	.s(go), .a(	sa03	),	.d(	sa03_sub	));
sbox us10(	.s(go), .a(	sa10	),	.d(	sa10_sub	));
sbox us11(	.s(go), .a(	sa11	),	.d(	sa11_sub	));
sbox us12(	.s(go), .a(	sa12	),	.d(	sa12_sub	));
sbox us13(	.s(go), .a(	sa13	),	.d(	sa13_sub	));
sbox us20(	.s(go), .a(	sa20	),	.d(	sa20_sub	));
sbox us21(	.s(go), .a(	sa21	),	.d(	sa21_sub	));
sbox us22(	.s(go), .a(	sa22	),	.d(	sa22_sub	));
sbox us23(	.s(go), .a(	sa23	),	.d(	sa23_sub	));
sbox us30(	.s(go), .a(	sa30	),	.d(	sa30_sub	));
sbox us31(	.s(go), .a(	sa31	),	.d(	sa31_sub	));
sbox us32(	.s(go), .a(	sa32	),	.d(	sa32_sub	));
sbox us33(	.s(go), .a(	sa33	),	.d(	sa33_sub	));
//hun he bian huan han shu 
function [31:0] mix_col;
input	[7:0]	s0,s1,s2,s3;
reg	[7:0]	s0_o,s1_o,s2_o,s3_o;
begin
mix_col[31:24]=xtime(s0)^xtime(s1)^s1^s2^s3;
mix_col[23:16]=s0^xtime(s1)^xtime(s2)^s2^s3;
mix_col[15:08]=s0^s1^xtime(s2)^xtime(s3)^s3;
mix_col[07:00]=xtime(s0)^s0^s1^s2^xtime(s3);
end
endfunction

function [7:0] xtime;
input [7:0] b; xtime={b[6:0],1'b0}^(8'h1b&{8{b[7]}});
endfunction
//逆列混合变换函数
function [31:0] inv_mix_col;
input	[7:0]	s0,s1,s2,s3;
begin
inv_mix_col[31:24]=pmul_e(s0)^pmul_b(s1)^pmul_d(s2)^pmul_9(s3);
inv_mix_col[23:16]=pmul_9(s0)^pmul_e(s1)^pmul_b(s2)^pmul_d(s3);
inv_mix_col[15:08]=pmul_d(s0)^pmul_9(s1)^pmul_e(s2)^pmul_b(s3);
inv_mix_col[07:00]=pmul_b(s0)^pmul_d(s1)^pmul_9(s2)^pmul_e(s3);
end
endfunction

function [7:0] pmul_e;
input [7:0] b;
reg [7:0] two,four,eight;
begin
two=xtime(b);four=xtime(two);eight=xtime(four);pmul_e=eight^four^two;
end
endfunction

function [7:0] pmul_9;
input [7:0] b;
reg [7:0] two,four,eight;
begin
two=xtime(b);four=xtime(two);eight=xtime(four);pmul_9=eight^b;
end
endfunction

function [7:0] pmul_d;
input [7:0] b;
reg [7:0] two,four,eight;
begin
two=xtime(b);four=xtime(two);eight=xtime(four);pmul_d=eight^four^b;
end
endfunction

function [7:0] pmul_b;
input [7:0] b;
reg [7:0] two,four,eight;
begin
two=xtime(b);four=xtime(two);eight=xtime(four);pmul_b=eight^two^b;
end
endfunction
endmodule
