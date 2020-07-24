`include "CONSTANTS.v"

module X_Calculator(
    input[31:0] x,
    input[31:0] y,
    input [31:0] angle,
    input [1:0] mode,
    input [31:0] y_shift,
    input clock,
    output [31:0] x_out
);


reg [31:0] x_out_temp;
always @ (posedge clock)
begin
    case(mode)
    `CIRCULAR:
    begin
        x_out_temp <= y[31] ? x - y_shift : x + y_shift;
    end
    `HYPERBOLIC:
    begin
        x_out_temp <= y[31] ? x + y_shift : x - y_shift;
    end
    `LINEAR:
    begin
        x_out_temp <= x;
    end
    endcase 
end

assign x_out = x_out_temp;



endmodule