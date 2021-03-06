`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:31:37 08/04/2020 
// Design Name: 
// Module Name:    Z_Calculator 
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

module Z_Calculator(
    input [31:0] angle,
    input [31:0] y,
    input [31:0] lookup_table_amount,
    input clock,
    output wire [31:0] angle_out
);
reg [31:0] angle_out_temp;
always @ (posedge clock)
begin
  angle_out_temp <= y[31] ? angle - lookup_table_amount : angle + lookup_table_amount;

//angle_out_temp <= (angle == 32'b00000000_00000000_00000000_00000000)? 0 :  (angle[30] ? angle + lookup_table_amount : angle - lookup_table_amount);
end
assign angle_out = angle_out_temp;

endmodule
