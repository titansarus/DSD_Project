`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:31:29 08/04/2020 
// Design Name: 
// Module Name:    Y_Calculator 
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

module Y_Calculator(
    input [31:0] y,
    input [31:0] x_shift,
    input clock,
    output wire [31:0] y_out
);

reg [31:0] y_out_temp;

always @ (posedge clock)
  begin
    y_out_temp <= y[31] ? y + x_shift : y - x_shift;
  end

assign y_out = y_out_temp;

endmodule