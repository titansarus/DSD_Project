`include "CONSTANTS.v"

module Y_Calculator(
    input[31:0] x,
    input[31:0] y,
    input [31:0] angle,
    input [31:0] x_shift,
    input clock,
    output wire [31:0] y_out
);

reg [31:0] y_out_temp;
always @ (posedge clock)
begin
  y_out_temp <= angle[30] ? y - x_shift : y + x_shift;
end

assign y_out = y_out_temp;

endmodule