`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:29:53 08/04/2020 
// Design Name: 
// Module Name:    TopModule 
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

module TopModule(input clock,
    input signed [31:0] x,
    input signed [31:0] y,
    input signed [31:0] angle,
    input [1:0] mode,
    output wire signed [31:0] rotated_x,
    output wire signed [31:0] rotated_y,
    output wire signed [31:0] final_angle);



CORDIC_Vector #(17) cr  (.clock(clock),.x(x) ,.y(y) , .angle(angle) , .mode(mode) , .rotated_x(rotated_x) , .rotated_y(rotated_y) , .final_angle(final_angle));


endmodule