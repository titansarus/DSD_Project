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
    case(angle[30:29])
        2'b00,2'b11:
            begin		// -90 to 90
            x_out <= x;
            y_out <= y;
            angle_out <= angle;
            end
        2'b01:				// subtract 90	(second quadrant)
            begin
            x_out <= -y;
            y_out <= x;
            angle_out <= {3'b000, angle[28:0]};
            end
        2'b10:				// add 90 (third quadrant)
            begin
            x_out <= y;			
            y_out <= -x;
            angle_out <= {2'b011,angle[28:0]};
            end
    endcase
end



endmodule
