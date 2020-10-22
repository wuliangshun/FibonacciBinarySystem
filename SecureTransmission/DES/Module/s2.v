module s2(stage1_input,stage1_output);
input [5:0] stage1_input;
output [3:0] stage1_output;

reg [3:0] stage1_output;

always @( stage1_input)
begin
   case(stage1_input)			//synopsys full_case parallel_case
        0: stage1_output = 4'd15; 
        1: stage1_output = 4'd3; 
        2: stage1_output = 4'd1; 
        3: stage1_output = 4'd13; 
        4: stage1_output = 4'd8; 
        5: stage1_output = 4'd4; 
        6: stage1_output = 4'd14; 
        7: stage1_output = 4'd7; 
        8: stage1_output = 4'd6; 
        9: stage1_output = 4'd15; 
        10: stage1_output = 4'd11; 
        11: stage1_output = 4'd2; 
        12: stage1_output = 4'd3; 
        13: stage1_output = 4'd8; 
        14: stage1_output = 4'd4; 
        15: stage1_output = 4'd14; 
        16: stage1_output = 4'd9; 
        17: stage1_output = 4'd12; 
        18: stage1_output = 4'd7; 
        19: stage1_output = 4'd0; 
        20: stage1_output = 4'd2; 
        21: stage1_output = 4'd1; 
        22: stage1_output = 4'd13; 
        23: stage1_output = 4'd10; 
        24: stage1_output = 4'd12; 
        25: stage1_output = 4'd6; 
        26: stage1_output = 4'd0; 
        27: stage1_output = 4'd9; 
        28: stage1_output = 4'd5; 
        29: stage1_output = 4'd11; 
        30: stage1_output = 4'd10; 
        31: stage1_output = 4'd5; 
        32: stage1_output = 4'd0; 
        33: stage1_output = 4'd13; 
        34: stage1_output = 4'd14; 
        35: stage1_output = 4'd8; 
        36: stage1_output = 4'd7; 
        37: stage1_output = 4'd10; 
        38: stage1_output = 4'd11; 
        39: stage1_output = 4'd1; 
        40: stage1_output = 4'd10; 
        41: stage1_output = 4'd3; 
        42: stage1_output = 4'd4; 
        43: stage1_output = 4'd15; 
        44: stage1_output = 4'd13; 
        45: stage1_output = 4'd4; 
        46: stage1_output = 4'd1; 
        47: stage1_output = 4'd2; 
        48: stage1_output = 4'd5; 
        49: stage1_output = 4'd11; 
        50: stage1_output = 4'd8; 
        51: stage1_output = 4'd6; 
        52: stage1_output = 4'd12; 
        53: stage1_output = 4'd7; 
        54: stage1_output = 4'd6; 
        55: stage1_output = 4'd12; 
        56: stage1_output = 4'd9; 
        57: stage1_output = 4'd0; 
        58: stage1_output = 4'd3; 
        59: stage1_output = 4'd5; 
        60: stage1_output = 4'd2; 
        61: stage1_output = 4'd14; 
        62: stage1_output = 4'd15; 
        63: stage1_output = 4'd9;   
  endcase
end
endmodule 