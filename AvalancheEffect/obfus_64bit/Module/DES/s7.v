module s7(stage1_input,stage1_output);
input [5:0] stage1_input;
output [3:0] stage1_output;

reg [3:0] stage1_output;

always @(  stage1_input)
begin
   case(stage1_input)			//synopsys full_case parallel_case
        0: stage1_output = 4'd4; 
        1: stage1_output = 4'd13; 
        2: stage1_output = 4'd11; 
        3: stage1_output = 4'd0; 
        4: stage1_output = 4'd2; 
        5: stage1_output = 4'd11; 
        6: stage1_output = 4'd14; 
        7: stage1_output = 4'd7; 
        8: stage1_output = 4'd15; 
        9: stage1_output = 4'd4; 
        10: stage1_output = 4'd0; 
        11: stage1_output = 4'd9; 
        12: stage1_output = 4'd8; 
        13: stage1_output = 4'd1; 
        14: stage1_output = 4'd13; 
        15: stage1_output = 4'd10; 
        16: stage1_output = 4'd3; 
        17: stage1_output = 4'd14; 
        18: stage1_output = 4'd12; 
        19: stage1_output = 4'd3; 
        20: stage1_output = 4'd9; 
        21: stage1_output = 4'd5; 
        22: stage1_output = 4'd7; 
        23: stage1_output = 4'd12; 
        24: stage1_output = 4'd5; 
        25: stage1_output = 4'd2; 
        26: stage1_output = 4'd10; 
        27: stage1_output = 4'd15; 
        28: stage1_output = 4'd6; 
        29: stage1_output = 4'd8; 
        30: stage1_output = 4'd1; 
        31: stage1_output = 4'd6; 
        32: stage1_output = 4'd1; 
        33: stage1_output = 4'd6; 
        34: stage1_output = 4'd4; 
        35: stage1_output = 4'd11; 
        36: stage1_output = 4'd11; 
        37: stage1_output = 4'd13; 
        38: stage1_output = 4'd13; 
        39: stage1_output = 4'd8; 
        40: stage1_output = 4'd12; 
        41: stage1_output = 4'd1; 
        42: stage1_output = 4'd3; 
        43: stage1_output = 4'd4; 
        44: stage1_output = 4'd7; 
        45: stage1_output = 4'd10; 
        46: stage1_output = 4'd14; 
        47: stage1_output = 4'd7; 
        48: stage1_output = 4'd10; 
        49: stage1_output = 4'd9; 
        50: stage1_output = 4'd15; 
        51: stage1_output = 4'd5; 
        52: stage1_output = 4'd6; 
        53: stage1_output = 4'd0; 
        54: stage1_output = 4'd8; 
        55: stage1_output = 4'd15; 
        56: stage1_output = 4'd0; 
        57: stage1_output = 4'd14; 
        58: stage1_output = 4'd5; 
        59: stage1_output = 4'd2; 
        60: stage1_output = 4'd9; 
        61: stage1_output = 4'd3; 
        62: stage1_output = 4'd2; 
        63: stage1_output = 4'd12; 
   endcase
end

endmodule
