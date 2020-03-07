module s6(stage1_input,stage1_output);
input [5:0] stage1_input;
output [3:0] stage1_output;

reg [3:0] stage1_output;

always @(  stage1_input)
begin
   case(stage1_input)			//synopsys full_case parallel_case
        0: stage1_output = 4'd12; 
        1: stage1_output = 4'd10; 
        2: stage1_output = 4'd1; 
        3: stage1_output = 4'd15; 
        4: stage1_output = 4'd10; 
        5: stage1_output = 4'd4; 
        6: stage1_output = 4'd15; 
        7: stage1_output = 4'd2; 
        8: stage1_output = 4'd9; 
        9: stage1_output = 4'd7; 
        10: stage1_output = 4'd2; 
        11: stage1_output = 4'd12; 
        12: stage1_output = 4'd6; 
        13: stage1_output = 4'd9; 
        14: stage1_output = 4'd8; 
        15: stage1_output = 4'd5; 
        16: stage1_output = 4'd0; 
        17: stage1_output = 4'd6; 
        18: stage1_output = 4'd13; 
        19: stage1_output = 4'd1; 
        20: stage1_output = 4'd3; 
        21: stage1_output = 4'd13; 
        22: stage1_output = 4'd4; 
        23: stage1_output = 4'd14; 
        24: stage1_output = 4'd14; 
        25: stage1_output = 4'd0; 
        26: stage1_output = 4'd7; 
        27: stage1_output = 4'd11; 
        28: stage1_output = 4'd5; 
        29: stage1_output = 4'd3; 
        30: stage1_output = 4'd11; 
        31: stage1_output = 4'd8; 
        32: stage1_output = 4'd9; 
        33: stage1_output = 4'd4; 
        34: stage1_output = 4'd14; 
        35: stage1_output = 4'd3; 
        36: stage1_output = 4'd15; 
        37: stage1_output = 4'd2; 
        38: stage1_output = 4'd5; 
        39: stage1_output = 4'd12; 
        40: stage1_output = 4'd2; 
        41: stage1_output = 4'd9; 
        42: stage1_output = 4'd8; 
        43: stage1_output = 4'd5; 
        44: stage1_output = 4'd12; 
        45: stage1_output = 4'd15; 
        46: stage1_output = 4'd3; 
        47: stage1_output = 4'd10; 
        48: stage1_output = 4'd7; 
        49: stage1_output = 4'd11; 
        50: stage1_output = 4'd0; 
        51: stage1_output = 4'd14; 
        52: stage1_output = 4'd4; 
        53: stage1_output = 4'd1; 
        54: stage1_output = 4'd10; 
        55: stage1_output = 4'd7; 
        56: stage1_output = 4'd1; 
        57: stage1_output = 4'd6; 
        58: stage1_output = 4'd13; 
        59: stage1_output = 4'd0; 
        60: stage1_output = 4'd11; 
        61: stage1_output = 4'd8; 
        62: stage1_output = 4'd6; 
        63: stage1_output = 4'd13; 
   endcase
end

endmodule
