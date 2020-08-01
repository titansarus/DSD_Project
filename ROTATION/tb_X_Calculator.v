`include "CONSTANTS.v"

module tb_X_Calculator();
    reg[31:0] x;
    reg[31:0] y;
    reg [31:0] angle;
    reg [1:0] mode;
    reg [31:0] y_shift;
    reg clock;
    wire [31:0] x_out;
    
    
    parameter PERIOD = 5;
    parameter Time_Between_Tests = 10;
    
    
    
    X_Calculator xcal(.x(x),.y(y),.angle(angle),.mode(mode),.y_shift(y_shift),.clock(clock),.x_out(x_out));
    
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
    x <= 32'd20;
    y <= 32'd40;
    angle<=32'b00010000000000000000000000000000;
    mode <=`CIRCULAR;
    y_shift <= 32'b00001111000000000000000000000000;
    #Time_Between_Tests
    x <= 32'd10;
    y <= 32'd20;
    angle <= 32'b00011100000000000000000000000000;
    mode <= `HYPERBOLIC;
    y_shift <=32'b01011110000000000000000000000000;
    #Time_Between_Tests
    x <= 32'd25;
    y <= 32'd30;
    angle <= 32'b01010110000000000000000000000000;
    mode <=`LINEAR;
    y_shift <= 32'b00111110000000000000000000000000;  
    end
    initial
  begin
    $monitor ("@", $time, "ns:   x_out = %b ", x_out);  
  end
endmodule
  
