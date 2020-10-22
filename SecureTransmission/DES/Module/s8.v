module s8(stage1_input,stage1_output);
input [5:0] stage1_input;
output [3:0] stage1_output;

reg [3:0] stage1_output;

always @(stage1_input)
begin
   case(stage1_input)			//synopsys full_case parallel_case
        0: stage1_output = 4'd13; 
        1: stage1_output = 4'd1; 
        2: stage1_output = 4'd2; 
        3: stage1_output = 4'd15; 
        4: stage1_output = 4'd8; 
        5: stage1_output = 4'd13; 
        6: stage1_output = 4'd4; 
        7: stage1_output = 4'd8; 
        8: stage1_output = 4'd6; 
        9: stage1_output = 4'd10; 
        10: stage1_output = 4'd15; 
        11: stage1_output = 4'd3; 
        12: stage1_output = 4'd11; 
        13: stage1_output = 4'd7; 
        14: stage1_output = 4'd1; 
        15: stage1_output = 4'd4; 
        16: stage1_output = 4'd10; 
        17: stage1_output = 4'd12; 
        18: stage1_output = 4'd9; 
        19: stage1_output = 4'd5; 
        20: stage1_output = 4'd3; 
        21: stage1_output = 4'd6; 
        22: stage1_output = 4'd14; 
        23: stage1_output = 4'd11; 
        24: stage1_output = 4'd5; 
        25: stage1_output = 4'd0; 
        26: stage1_output = 4'd0; 
        27: stage1_output = 4'd14; 
        28: stage1_output = 4'd12; 
        29: stage1_output = 4'd9; 
        30: stage1_output = 4'd7; 
        31: stage1_output = 4'd2; 
        32: stage1_output = 4'd7; 
        33: stage1_output = 4'd2; 
        34: stage1_output = 4'd11; 
        35: stage1_output = 4'd1; 
        36: stage1_output = 4'd4; 
        37: stage1_output = 4'd14; 
        38: stage1_output = 4'd1; 
        39: stage1_output = 4'd7; 
        40: stage1_output = 4'd9; 
        41: stage1_output = 4'd4; 
        42: stage1_output = 4'd12; 
        43: stage1_output = 4'd10; 
        44: stage1_output = 4'd14; 
        45: stage1_output = 4'd8; 
        46: stage1_output = 4'd2; 
        47: stage1_output = 4'd13; 
        48: stage1_output = 4'd0; 
        49: stage1_output = 4'd15; 
        50: stage1_output = 4'd6; 
        51: stage1_output = 4'd12; 
        52: stage1_output = 4'd10; 
        53: stage1_output = 4'd9; 
        54: stage1_output = 4'd13; 
        55: stage1_output = 4'd0; 
        56: stage1_output = 4'd15; 
        57: stage1_output = 4'd3; 
        58: stage1_output = 4'd3; 
        59: stage1_output = 4'd5; 
        60: stage1_output = 4'd5; 
        61: stage1_output = 4'd6; 
        62: stage1_output = 4'd8; 
        63: stage1_output = 4'd11; 
   endcase
end

endmodule
