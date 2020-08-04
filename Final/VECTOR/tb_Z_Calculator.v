`include "CONSTANTS.v"

module tb_X_Calculator();
    reg [31:0] angle;
    reg[31:0] y;
    reg [31:0] lookup_table_amount;
    reg clock;
    wire [31:0] angle_out;
    
    
    parameter PERIOD = 5;
    parameter Time_Between_Tests = 10;
    
    
    
    Z_Calculator zcal(.angle(angle), .y(y), .lookup_table_amount(lookup_table_amount), .clock(clock), .angle_out(angle_out));
    
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
    angle<=32'b00010000000000000000000000000000;
    y <= 32'd40;
    lookup_table_amount <= 32'b00001111000000000000000000000000;
    #Time_Between_Tests
    angle <= 32'b00011100000000000000000000000000;
    y <= 32'd20;
    lookup_table_amount <=32'b01011110000000000000000000000000;
    #Time_Between_Tests
    angle <= 32'b01010110000000000000000000000000;
    y <= 32'd30;
    lookup_table_amount <= 32'b00111110000000000000000000000000;  
    end
    initial
  begin
    $monitor ("@", $time, "ns:   angle_out = %b ", angle_out);  
  end
endmodule
  


