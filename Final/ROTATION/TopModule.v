`include "CONSTANTS.v"

module TopModule(input clock,
    input signed [31:0] x,
    input signed [31:0] y,
    input signed [31:0] angle,
    input [1:0] mode,
    output wire signed [31:0] rotated_x,
    output wire signed [31:0] rotated_y,
    output wire signed [31:0] final_angle);



CORDIC_Rotation #(29) cr  (.clock(clock),.x(x) ,.y(y) , .angle(angle) , .mode(mode) , .rotated_x(rotated_x) , .rotated_y(rotated_y) , .final_angle(final_angle));


endmodule

