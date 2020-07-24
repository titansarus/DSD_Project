`include "CONSTANTS.v"

module Quardrant_Corrector(
    input [31:0] x,
    input [31:0] y,
    input[31:0] angle,
    output reg [31:0] x_out,
    output reg [31:0] y_out,
    output reg [31:0] angle_out
);

always @(*)
begin
    case({x[31] , y[31]})
        2'b00,2'b01:
            begin		// -90 to 90
            x_out <= x;
            y_out <= y;
            angle_out <= 32'b00000000000000000000000000000000;
            end
        2'b10:				// subtract 90	(second quadrant)
            begin
            x_out <= -y;
            y_out <= x;
            angle_out <= 32'b00100000000000000000000000000000;
            end
        2'b11:				// add 90 (third quadrant)
            begin
            x_out <= y;			
            y_out <= -x;
            angle_out <= 32'b01000000000000000000000000000000;
            end
    endcase
end



endmodule
