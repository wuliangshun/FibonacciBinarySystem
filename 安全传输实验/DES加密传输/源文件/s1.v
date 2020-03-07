module s1(stage1_input,stage1_output);
input [5:0] stage1_input;
output [3:0] stage1_output;

reg [3:0] stage1_output;

//BIT5 and BIT0 is ?  
//BIT4~1 is ?
always @(  stage1_input)
begin
   case(stage1_input)					//synopsys full_case parallel_case
	    0: stage1_output = 4'd14; 
        1: stage1_output = 4'd0; 
        2: stage1_output = 4'd4; 
        3: stage1_output = 4'd15; 
        4: stage1_output = 4'd13; 
        5: stage1_output = 4'd7; 
        6: stage1_output = 4'd1; 
        7: stage1_output = 4'd4; 
        8: stage1_output = 4'd2; 
        9: stage1_output = 4'd14; 
        10: stage1_output = 4'd15; 
        11: stage1_output = 4'd2; 
        12: stage1_output = 4'd11; 
        13: stage1_output = 4'd13; 
        14: stage1_output = 4'd8; 
        15: stage1_output = 4'd1; 
        16: stage1_output = 4'd3; 
        17: stage1_output = 4'd10; 
        18: stage1_output = 4'd10; 
        19: stage1_output = 4'd6; 
        20: stage1_output = 4'd6; 
        21: stage1_output = 4'd12; 
        22: stage1_output = 4'd12; 
        23: stage1_output = 4'd11; 
        24: stage1_output = 4'd5; 
        25: stage1_output = 4'd9; 
        26: stage1_output = 4'd9; 
        27: stage1_output = 4'd5; 
        28: stage1_output = 4'd0; 
        29: stage1_output = 4'd3; 
        30: stage1_output = 4'd7; 
        31: stage1_output = 4'd8; 
        32: stage1_output = 4'd4; 
        33: stage1_output = 4'd15; 
        34: stage1_output = 4'd1; 
        35: stage1_output = 4'd12; 
        36: stage1_output = 4'd14; 
        37: stage1_output = 4'd8; 
        38: stage1_output = 4'd8; 
        39: stage1_output = 4'd2; 
        40: stage1_output = 4'd13; 
        41: stage1_output = 4'd4; 
        42: stage1_output = 4'd6; 
        43: stage1_output = 4'd9; 
        44: stage1_output = 4'd2; 
        45: stage1_output = 4'd1; 
        46: stage1_output = 4'd11; 
        47: stage1_output = 4'd7; 
        48: stage1_output = 4'd15; 
        49: stage1_output = 4'd5; 
        50: stage1_output = 4'd12; 
        51: stage1_output = 4'd11; 
        52: stage1_output = 4'd9; 
        53: stage1_output = 4'd3; 
        54: stage1_output = 4'd7; 
        55: stage1_output = 4'd14; 
        56: stage1_output = 4'd3; 
        57: stage1_output = 4'd10; 
        58: stage1_output = 4'd10; 
        59: stage1_output = 4'd0; 
        60: stage1_output = 4'd5; 
        61: stage1_output = 4'd6; 
        62: stage1_output = 4'd0; 
        63: stage1_output = 4'd13;   
   endcase
end

endmodule
