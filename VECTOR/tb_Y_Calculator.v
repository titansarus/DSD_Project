`include "CONSTANTS.v"

module tb_Y_Calculator();

parameter PERIOD = 5;
parameter DELAY_BETWEEN_TESTS = 10;

reg clock;
reg [31:0] x;
reg [31:0] y;
reg [31:0] angle;
reg [31:0] x_shift;
wire [31:0] y_out;

Y_Calculator yc(.clock(clock), .x(x), .y(y), .angle(angle), .x_shift(x_shift), .y_out(y_out));

initial 
  begin
    clock = 0;
  end

always 
  begin 
    #PERIOD clock = ~clock;
  end

initial
  begin
       y = 32'b00110000000000000000000000000000;
       x_shift = 32'b00001010000000000000000000000000;
       #DELAY_BETWEEN_TESTS
       y = 32'b10100001000000000000000000000000;
       x_shift = 32'b01001010000000000000000000000101;
       #DELAY_BETWEEN_TESTS
       y = 32'b00000010011011101000101101110101;
       x_shift = 32'b00000000000000000000000000000011;
  end

initial
  begin
    $monitor ("@", $time, "ns:   y_out = %b ", y_out);  
  end


endmodule