`include "CONSTANTS.v"

module tb_CORDIC_Rotation();



parameter PERIOD = 4;

reg signed [31:0] x, y , angle;
wire signed [31:0] rotated_x , rotated_y , final_angle;
reg [1:0] mode;
reg clock;

CORDIC_Rotation cr (.clock(clock),.x(x) ,.y(y) , .angle(angle) , .mode(mode) , .rotated_x(rotated_x) , .rotated_y(rotated_y) , .final_angle(final_angle));

initial begin
    clock = 0;
end

always begin 
#PERIOD clock = ~clock;
end

initial begin
    mode = `CIRCULAR;
    x = 32'b000000000001_00000000_00000000_0000;
    y = 32'b000000000000_00000000_00000000_0000;
    angle = 32'b00010000000000000000000000000000;
    #10
    angle = 32'b00001010101010101010101010101010;
    #10
    angle = 32'b00110000000000000000000000000000;
    #300;
    $stop;
end



endmodule
