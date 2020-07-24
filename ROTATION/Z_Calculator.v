`include "CONSTANTS.v"

module Z_Calculator(
    input [31:0] angle,
    input [31:0] lookup_table_amount,
    input clock,
    output wire [31:0] angle_out
);
reg [31:0] angle_out_temp;
always @ (posedge clock)
begin
  angle_out_temp <= (angle[30] ? angle + lookup_table_amount : angle - lookup_table_amount);

//angle_out_temp <= (angle == 32'b00000000_00000000_00000000_00000000)? 0 :  (angle[30] ? angle + lookup_table_amount : angle - lookup_table_amount);
end
assign angle_out = angle_out_temp;

endmodule
