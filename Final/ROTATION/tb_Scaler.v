
`include "CONSTANTS.v"

module tb_Scaler();
    reg[31:0] number;
    reg [1:0] mode;
    wire [31:0] answer;
    

    parameter Time_Between_Tests = 10;
    
    
    
    Scaler scaler(.number(number), .mode(mode), .answer(answer));
    
  initial
    begin
    number <= 32'd20;
    mode <=`CIRCULAR;
    #Time_Between_Tests
    number <= 32'd10;
    mode <= `HYPERBOLIC;
    #Time_Between_Tests
    number <= 32'd25;
    mode <=`LINEAR;
    end
    initial
      begin
      $monitor ("@", $time, "ns:   answer = %b ", answer);  
      end
endmodule
  

