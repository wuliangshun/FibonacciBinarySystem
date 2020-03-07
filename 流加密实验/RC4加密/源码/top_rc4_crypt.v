module top_rc4_crypt(
               data_out,
               crypt_done,
               rc4_data_rd,
               rc4_data_wr,   
               sbox_rd,    
               sbox_wr,    
               sbox_raddr, 
               sbox_waddr, 
               sbox_din,   
               sbox_dout,  
               rc4_ini,    
               key_in,     
               data_in,    
               clk,        
               rstn       
               );
output[7:0]   data_out;
output        crypt_done;
output        rc4_data_rd;
output        rc4_data_wr;
output        sbox_rd;
output        sbox_wr;
output[7:0]   sbox_raddr;
output[7:0]   sbox_waddr;
output[7:0]   sbox_din;
input[7:0]    sbox_dout;
input         rc4_ini;
input[127:0]  key_in;
input[7:0]    data_in;
input         clk;
input         rstn;

rc4_crypt u_rc4_crypt(
               .data_out  (data_out),
               .crypt_done  (crypt_done),
               .rc4_data_rd (rc4_data_rd),
               .rc4_data_wr   (rc4_data_wr),
               .sbox_rd     (sbox_rd),
               .sbox_wr    (sbox_wr),
               .sbox_raddr (sbox_raddr),
               .sbox_waddr (sbox_waddr),
               .sbox_din   (sbox_din),
               .sbox_dout  (sbox_dout),
               .rc4_ini    (rc4_ini),
               .key_in     (key_in),
               .data_in    (data_in),
               .clk        (clk),
               .rstn    (rstn)
					);
					endmodule 