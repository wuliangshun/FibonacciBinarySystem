module s3(stage1_input,stage1_output);
input [5:0] stage1_input;
output [3:0] stage1_output;

reg [3:0] stage1_output;

always @(  stage1_input)
begin
   case(stage1_input)   			//synopsys full_case parallel_case
        0: stage1_output = 4'd10 ; 
        1: stage1_output = 4'd13 ; 
        2: stage1_output = 4'd0 ; 
        3: stage1_output = 4'd7 ; 
        4: stage1_output = 4'd9 ; 
        5: stage1_output = 4'd0 ; 
        6: stage1_output = 4'd14 ; 
        7: stage1_output = 4'd9 ; 
        8: stage1_output = 4'd6 ; 
        9: stage1_output = 4'd3 ; 
        10: stage1_output = 4'd3 ; 
        11: stage1_output = 4'd4 ; 
        12: stage1_output = 4'd15 ; 
        13: stage1_output = 4'd6 ; 
        14: stage1_output = 4'd5 ; 
        15: stage1_output = 4'd10 ; 
        16: stage1_output = 4'd1 ; 
        17: stage1_output = 4'd2 ; 
        18: stage1_output = 4'd13 ; 
        19: stage1_output = 4'd8 ; 
        20: stage1_output = 4'd12 ; 
        21: stage1_output = 4'd5 ; 
        22: stage1_output = 4'd7 ; 
        23: stage1_output = 4'd14 ; 
        24: stage1_output = 4'd11 ; 
        25: stage1_output = 4'd12 ; 
        26: stage1_output = 4'd4 ; 
        27: stage1_output = 4'd11 ; 
        28: stage1_output = 4'd2 ; 
        29: stage1_output = 4'd15 ; 
        30: stage1_output = 4'd8 ; 
        31: stage1_output = 4'd1 ; 
        32: stage1_output = 4'd13 ; 
        33: stage1_output = 4'd1 ; 
        34: stage1_output = 4'd6 ; 
        35: stage1_output = 4'd10 ; 
        36: stage1_output = 4'd4 ; 
        37: stage1_output = 4'd13 ; 
        38: stage1_output = 4'd9 ; 
        39: stage1_output = 4'd0 ; 
        40: stage1_output = 4'd8 ; 
        41: stage1_output = 4'd6 ; 
        42: stage1_output = 4'd15 ; 
        43: stage1_output = 4'd9 ; 
        44: stage1_output = 4'd3 ; 
        45: stage1_output = 4'd8 ; 
        46: stage1_output = 4'd0 ; 
        47: stage1_output = 4'd7 ; 
        48: stage1_output = 4'd11 ; 
        49: stage1_output = 4'd4 ; 
        50: stage1_output = 4'd1 ; 
        51: stage1_output = 4'd15 ; 
        52: stage1_output = 4'd2 ; 
        53: stage1_output = 4'd14 ; 
        54: stage1_output = 4'd12 ; 
        55: stage1_output = 4'd3 ; 
        56: stage1_output = 4'd5 ; 
        57: stage1_output = 4'd11 ; 
        58: stage1_output = 4'd10 ; 
        59: stage1_output = 4'd5 ; 
        60: stage1_output = 4'd14 ; 
        61: stage1_output = 4'd2 ; 
        62: stage1_output = 4'd7 ; 
        63: stage1_output = 4'd12 ; 
   endcase
end
endmodule
