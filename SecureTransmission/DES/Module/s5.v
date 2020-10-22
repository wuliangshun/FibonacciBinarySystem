module s5(stage1_input,stage1_output);
input [5:0] stage1_input;
output [3:0] stage1_output;

reg [3:0] stage1_output;

always @(  stage1_input)
begin
   case(stage1_input)			//synopsys full_case parallel_case
        0: stage1_output = 4'd2; 
        1: stage1_output = 4'd14; 
        2: stage1_output = 4'd12; 
        3: stage1_output = 4'd11; 
        4: stage1_output = 4'd4; 
        5: stage1_output = 4'd2; 
        6: stage1_output = 4'd1; 
        7: stage1_output = 4'd12; 
        8: stage1_output = 4'd7; 
        9: stage1_output = 4'd4; 
        10: stage1_output = 4'd10; 
        11: stage1_output = 4'd7; 
        12: stage1_output = 4'd11; 
        13: stage1_output = 4'd13; 
        14: stage1_output = 4'd6; 
        15: stage1_output = 4'd1; 
        16: stage1_output = 4'd8; 
        17: stage1_output = 4'd5; 
        18: stage1_output = 4'd5; 
        19: stage1_output = 4'd0; 
        20: stage1_output = 4'd3; 
        21: stage1_output = 4'd15; 
        22: stage1_output = 4'd15; 
        23: stage1_output = 4'd10; 
        24: stage1_output = 4'd13; 
        25: stage1_output = 4'd3; 
        26: stage1_output = 4'd0; 
        27: stage1_output = 4'd9; 
        28: stage1_output = 4'd14; 
        29: stage1_output = 4'd8; 
        30: stage1_output = 4'd9; 
        31: stage1_output = 4'd6; 
        32: stage1_output = 4'd4; 
        33: stage1_output = 4'd11; 
        34: stage1_output = 4'd2; 
        35: stage1_output = 4'd8; 
        36: stage1_output = 4'd1; 
        37: stage1_output = 4'd12; 
        38: stage1_output = 4'd11; 
        39: stage1_output = 4'd7; 
        40: stage1_output = 4'd10; 
        41: stage1_output = 4'd1; 
        42: stage1_output = 4'd13; 
        43: stage1_output = 4'd14; 
        44: stage1_output = 4'd7; 
        45: stage1_output = 4'd2; 
        46: stage1_output = 4'd8; 
        47: stage1_output = 4'd13; 
        48: stage1_output = 4'd15; 
        49: stage1_output = 4'd6; 
        50: stage1_output = 4'd9; 
        51: stage1_output = 4'd15; 
        52: stage1_output = 4'd12; 
        53: stage1_output = 4'd0; 
        54: stage1_output = 4'd5; 
        55: stage1_output = 4'd9; 
        56: stage1_output = 4'd6; 
        57: stage1_output = 4'd10; 
        58: stage1_output = 4'd3; 
        59: stage1_output = 4'd4; 
        60: stage1_output = 4'd0; 
        61: stage1_output = 4'd5; 
        62: stage1_output = 4'd14; 
        63: stage1_output = 4'd3; 
   endcase
end
endmodule 