
`include "CONSTANTS.v"

module tb_X_Calculator();
    reg [31:0] angle;
    reg [31:0] lookup_table_amount;
    reg clock;
    wire [31:0] angle_out;
    
    
    parameter PERIOD = 5;
    parameter Time_Between_Tests = 10;
    
    
    
    Z_Calculator zcal(.angle(angle), .lookup_table_amount(lookup_table_amount), .clock(clock), .angle_out(angle_out));
    
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
    lookup_table_amount<=32'b00100111000000011000100000100000;
    #Time_Between_Tests
    angle <= 32'b00011100000000000000000000000000;
    lookup_table_amount<=32'b00100111001100011000101100100000;
    #Time_Between_Tests
    angle <= 32'b01010110000000000000000000000000;
    lookup_table_amount<=32'b11100111001100011000101100100011;
    end
    initial
  begin
    $monitor ("@", $time, "ns:   angle_out = %b ", angle_out);  
  end
endmodule
  

