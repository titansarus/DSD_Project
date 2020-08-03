`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:25:16 08/03/2020 
// Design Name: 
// Module Name:    X_Calculator 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
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
        x_out_temp <= angle[30] ? x + y_shift : x - y_shift;
    end
    `HYPERBOLIC:
    begin
        x_out_temp <= angle[30] ? x - y_shift : x + y_shift;
    end
    `LINEAR:
    begin
        x_out_temp <= x;
    end
    endcase 
end

assign x_out = x_out_temp;



endmodule