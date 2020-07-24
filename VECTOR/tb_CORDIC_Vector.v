`include "CONSTANTS.v"

module tb_CORDIC_Vector();



parameter PERIOD = 4;

reg signed [31:0] x, y , angle;
wire signed [31:0] rotated_x , rotated_y , final_angle;
reg [1:0] mode;
reg clock;

CORDIC_Vector cr (.clock(clock),.x(x) ,.y(y) , .angle(angle) , .mode(mode) , .rotated_x(rotated_x) , .rotated_y(rotated_y) , .final_angle(final_angle));

initial begin
    clock = 0;
end

always begin 
#PERIOD clock = ~clock;
end

initial begin
    mode = `CIRCULAR;
    x = 32'b000000000010_00000000_00000000_0000;
    y = 32'b000000000010_00000000_00000000_0000;
    #10;
    #10;
    #300;
    $stop;
end



endmodule
