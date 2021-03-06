`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:30:45 08/04/2020 
// Design Name: 
// Module Name:    Scaler 
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

module Scaler(input [31:0] number , input [1:0] mode , output [31:0] answer);

reg [31:0] circular_answer , hyperbolic_answer;
always @(*)
begin
    hyperbolic_answer <= number + (((number>>>3) + (number>>>4))
     + ((number>>>6) + (number>>>8))) + (((number>>>12) + (number>>>13)) + ((number>>>14) + (number>>>15)));
    circular_answer <=  (number >>> 1) + ((((number >>>4) + (number>>>5))
     + ((number>>>7) + (number>>>8))) + (((number>>>10) + (number>>>11)) + ((number>>>12) + (number>>>13))));
end
assign answer = (mode == `CIRCULAR)? circular_answer : ((mode == `HYPERBOLIC) ? hyperbolic_answer : number);

endmodule