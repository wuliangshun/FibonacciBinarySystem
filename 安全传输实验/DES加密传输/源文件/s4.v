module s4(stage1_input,stage1_output);
input [5:0] stage1_input;
output [3:0] stage1_output;

reg [3:0] stage1_output;

always @(  stage1_input)
begin
   case(stage1_input)			//synopsys full_case parallel_case
        0: stage1_output = 4'd7; 
        1: stage1_output = 4'd13; 
        2: stage1_output = 4'd13; 
        3: stage1_output = 4'd8; 
        4: stage1_output = 4'd14; 
        5: stage1_output = 4'd11; 
        6: stage1_output = 4'd3; 
        7: stage1_output = 4'd5; 
        8: stage1_output = 4'd0; 
        9: stage1_output = 4'd6; 
        10: stage1_output = 4'd6; 
        11: stage1_output = 4'd15; 
        12: stage1_output = 4'd9; 
        13: stage1_output = 4'd0; 
        14: stage1_output = 4'd10; 
        15: stage1_output = 4'd3; 
        16: stage1_output = 4'd1; 
        17: stage1_output = 4'd4; 
        18: stage1_output = 4'd2; 
        19: stage1_output = 4'd7; 
        20: stage1_output = 4'd8; 
        21: stage1_output = 4'd2; 
        22: stage1_output = 4'd5; 
        23: stage1_output = 4'd12; 
        24: stage1_output = 4'd11; 
        25: stage1_output = 4'd1; 
        26: stage1_output = 4'd12; 
        27: stage1_output = 4'd10; 
        28: stage1_output = 4'd4; 
        29: stage1_output = 4'd14; 
        30: stage1_output = 4'd15; 
        31: stage1_output = 4'd9; 
        32: stage1_output = 4'd10; 
        33: stage1_output = 4'd3; 
        34: stage1_output = 4'd6; 
        35: stage1_output = 4'd15; 
        36: stage1_output = 4'd9; 
        37: stage1_output = 4'd0; 
        38: stage1_output = 4'd0; 
        39: stage1_output = 4'd6; 
        40: stage1_output = 4'd12; 
        41: stage1_output = 4'd10; 
        42: stage1_output = 4'd11; 
        43: stage1_output = 4'd1; 
        44: stage1_output = 4'd7; 
        45: stage1_output = 4'd13; 
        46: stage1_output = 4'd13; 
        47: stage1_output = 4'd8; 
        48: stage1_output = 4'd15; 
        49: stage1_output = 4'd9; 
        50: stage1_output = 4'd1; 
        51: stage1_output = 4'd4; 
        52: stage1_output = 4'd3; 
        53: stage1_output = 4'd5; 
        54: stage1_output = 4'd14; 
        55: stage1_output = 4'd11; 
        56: stage1_output = 4'd5; 
        57: stage1_output = 4'd12; 
        58: stage1_output = 4'd2; 
        59: stage1_output = 4'd7; 
        60: stage1_output = 4'd8; 
        61: stage1_output = 4'd2; 
        62: stage1_output = 4'd4; 
        63: stage1_output = 4'd14; 
   endcase
end

endmodule
