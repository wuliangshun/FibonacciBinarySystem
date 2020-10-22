//------------------------------------------------------------------------
// verilog source code 
//------------------------------------------------------------------------
// FILE NAME :rc4_crypt
// TYPE :  module
// AUTHOR :  
// AUTHOR¡¯S EMAIL : 
//------------------------------------------------------------------------
// Release history
// VERSION      Date           AUTHOR       DESCRIPTION
//   1.0      18/04/07      derek       create
//------------------------------------------------------------------------
// PURPOSE : rc4 algorithm module
//------------------------------------------------------------------------
// PARAMETERS
// PARAM NAME RANGE : DESCRIPTION : DEFAULT : VA UNITS
//
//------------------------------------------------------------------------
// REUSE ISSUES
// Reset Strategy :
// Clock Domains :
// Critical Timing :
// Test Features :
// Asynchronous I/F :
// Scan Methodology :
// Instantiations :
// Other :
//------------------------------------------------------------------------
`define data_len 8
//`define data_len 3
module rc4_crypt(
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
parameter    UDLY = 1;
parameter    IDLE = 3'b0;
parameter    PHASE1 = 3'b001;
parameter    PHASE2 = 3'b010;
parameter    PHASE3 = 3'b011;
parameter    PHASE4 = 3'b100;
parameter    PHASE5 = 3'b101;
//===========================
//ports declaration
//===========================
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
//===========================
//signals declaration
//===========================
wire              setup_done;
reg               crypt_done;
wire              rc4_data_rd;
reg               rc4_data_wr;
reg[7:0]          setup_cnt;
reg[`data_len-1:0] crypt_cnt;
reg[7:0]          sbox_cnt;
reg[3:0]          key_cnt;
reg[7:0]          key_byte;
wire[9:0]         tmp_j;
reg[2:0]          cur_st;
reg[2:0]          nxt_st;
reg[7:0]          i_data;
reg[7:0]          value_j;
reg[7:0]          j_data;
reg[7:0]          x_data;
reg[7:0]          value_y;
reg[7:0]          y_data;
reg[7:0]          xor_data;
reg               sbox_rd;
reg[7:0]          sbox_raddr;
reg               sbox_wr;
reg[7:0]          sbox_waddr;
reg[7:0]          sbox_din;
//===========================
//main code
//===========================
//---------------------------
//control signals
//---------------------------
assign   setup_done = setup_cnt == 8'hff;

always @ (posedge clk or negedge rstn)
   begin
      if(!rstn)
        crypt_done <= 1'b0;
      else 
        crypt_done <= #UDLY crypt_cnt == {`data_len{1'b1}};
   end	

assign   rc4_data_rd = cur_st == PHASE5;

always @ (posedge clk or negedge rstn)
   begin
      if(!rstn)
        rc4_data_wr <= 1'b0;
      else 
        rc4_data_wr <= #UDLY rc4_data_rd;
   end  
//----------------------------
// counter
//----------------------------   
always @ (posedge clk or negedge rstn)
   begin
      if(!rstn)
        setup_cnt <= 8'b0;
      else if(cur_st == PHASE2)      
        setup_cnt <= #UDLY setup_cnt + 1'b1;
      else if (cur_st == IDLE)    
        setup_cnt <= #UDLY 8'b0;
   end	
   
always @ (posedge clk or negedge rstn)
   begin
      if(!rstn)
        crypt_cnt <= {`data_len{1'b0}};
      else if(cur_st == PHASE5)      
        crypt_cnt <= #UDLY crypt_cnt + 1'b1;
      else if (cur_st == IDLE)    
        crypt_cnt <= #UDLY {`data_len{1'b0}};
   end

always @ (posedge clk or negedge rstn)
   begin
      if(!rstn)
        sbox_cnt <= 8'b0;
      else if(cur_st == PHASE5)      
        sbox_cnt <= #UDLY sbox_cnt + 1'b1;
      else if (cur_st == IDLE)    
        sbox_cnt <= #UDLY 8'b0;
   end

always @ (posedge clk or negedge rstn)
   begin
      if(!rstn)
        key_cnt <= 4'b0;
      else if(cur_st == PHASE2)      
        key_cnt <= #UDLY key_cnt + 1'b1;
      else if (cur_st == IDLE)    
        key_cnt <= #UDLY 4'b0;
   end

always @(key_cnt or key_in)
   begin
      case(key_cnt)
        4'b0000:
           key_byte = key_in[7:0];
        4'b0001:
           key_byte = key_in[15:8];
        4'b0010:
           key_byte = key_in[23:16];
        4'b0011:
           key_byte = key_in[31:24];
        4'b0100:
           key_byte = key_in[39:32];
        4'b0101:
           key_byte = key_in[47:40];
        4'b0110:
           key_byte = key_in[55:48];
        4'b0111:
           key_byte = key_in[63:56];
        4'b1000:
           key_byte = key_in[71:64];
        4'b1001:
           key_byte = key_in[79:72];
         4'b1010:
           key_byte = key_in[87:80];
        4'b1011:
           key_byte = key_in[95:88];
        4'b1100:
           key_byte = key_in[103:96];
        4'b1101:
           key_byte = key_in[111:104];
        4'b1110:
           key_byte = key_in[119:112];
        4'b1111:
           key_byte = key_in[127:120];
        default:
           key_byte = key_in[7:0]; 
       endcase                                                  
   end 
        	   
assign tmp_j[9:0] = value_j + i_data + key_byte;    
//--------------------------
// algorithm state machine
//--------------------------  
always @(cur_st or rc4_ini or setup_done or crypt_done)
   begin
       case(cur_st)
         IDLE:
            if(rc4_ini)
              nxt_st = PHASE1;
            else
              nxt_st = IDLE;  
         PHASE1:
              nxt_st = PHASE2; 
         PHASE2:
            if(setup_done)
              nxt_st = PHASE3;
            else
              nxt_st = PHASE1;   
         PHASE3:
              nxt_st = PHASE4;   
         PHASE4:
              nxt_st = PHASE5;   
         PHASE5:
            if(crypt_done)
              nxt_st = IDLE;
            else 
              nxt_st = PHASE3;   
         default:
              nxt_st = IDLE;
       endcase           
   end 
   
always @ (posedge clk or negedge rstn)
   begin
   	if(!rstn)
   	   cur_st <= 3'b0;
   	else
   	   cur_st <= #UDLY nxt_st;   
   end   
//-----------------------------
//generate sbox related signals
//-----------------------------
always @ (cur_st or setup_cnt or j_data or tmp_j or i_data or crypt_cnt or value_y or x_data or y_data or sbox_cnt)
   begin 
      case(cur_st)      
         PHASE1:
            begin
              sbox_rd = 1'b1;
              sbox_raddr = setup_cnt;
              sbox_wr = setup_cnt != 8'b0;            
              sbox_waddr = setup_cnt -1'b1;
              sbox_din = j_data;
            end      
         PHASE2:
            begin
              sbox_rd = 1'b1;
              sbox_raddr = tmp_j[7:0];
              sbox_wr = 1'b1;            
              sbox_waddr = tmp_j[7:0];
              sbox_din = i_data;
            end 
         PHASE3:
            begin
              sbox_rd = 1'b1;
              sbox_raddr = crypt_cnt + 1'b1;
              sbox_wr =  sbox_cnt == 8'b0;            
              sbox_waddr = 8'hff;
              sbox_din = j_data;
            end 
         PHASE4:
            begin
              sbox_rd = 1'b1;
              sbox_raddr = value_y;
              sbox_wr =  1'b1;           
              sbox_waddr = value_y;
              sbox_din = x_data;
            end 
         PHASE5:
            begin
              sbox_rd = 1'b1;
              sbox_raddr = x_data + y_data;
              sbox_wr = 1'b1;            
              sbox_waddr = sbox_cnt;
              sbox_din = y_data;
            end 
      default:
            begin
              sbox_rd = 1'b0;
              sbox_raddr = 8'b0;
              sbox_wr = 1'b0;            
              sbox_waddr = 8'b0;
              sbox_din = 8'b0;
            end
     endcase                   
   end	
   
always @ (posedge clk or negedge rstn)
   begin
   	if(!rstn)
   	   i_data <= 8'b0;
   	else if(cur_st == PHASE1)
   	   i_data <= #UDLY sbox_dout;
   	else if(cur_st == IDLE)
   	   i_data <= #UDLY 8'b0;     
   end

always @ (posedge clk or negedge rstn)
   begin
   	if(!rstn)
   	   value_j <= 8'b0;
   	else if(cur_st == PHASE2)
   	   value_j <= #UDLY tmp_j[7:0];
   	else if(cur_st == IDLE)
   	   value_j <= #UDLY 8'b0;     
   end

always @ (posedge clk or negedge rstn)
   begin
   	if(!rstn)
   	   j_data <= 8'b0;
   	else if(cur_st == PHASE2)
   	   j_data <= #UDLY sbox_dout;
   	else if(cur_st == IDLE)
   	   j_data <= #UDLY 8'b0;     
   end   

always @ (posedge clk or negedge rstn)
   begin
   	if(!rstn)
   	   x_data <= 8'b0;
   	else if(cur_st == PHASE3)
   	   x_data <= #UDLY sbox_dout;
   	else if(cur_st == IDLE)
   	   x_data <= #UDLY 8'b0;     
   end   

always @ (posedge clk or negedge rstn)
   begin
   	if(!rstn)
   	   value_y <= 8'b0;
   	else if(cur_st == PHASE3)
   	   value_y <= #UDLY value_y + sbox_dout;
   	else if(cur_st == IDLE)
   	   value_y <= #UDLY 8'b0;     
   end 

always @ (posedge clk or negedge rstn)
   begin
   	if(!rstn)
   	   y_data <= 8'b0;
   	else if(cur_st == PHASE4)
   	   y_data <= #UDLY sbox_dout;
   	else if(cur_st == IDLE)
   	   y_data <= #UDLY 8'b0;     
   end   

always @ (posedge clk or negedge rstn)
   begin
   	if(!rstn)
   	   xor_data <= 8'b0;
   	else if(cur_st == PHASE5)
   	   xor_data <= #UDLY sbox_dout;
   	else if(cur_st == IDLE)
   	   xor_data <= #UDLY 8'b0;     
   end   

assign data_out = data_in ^ xor_data;   
endmodule