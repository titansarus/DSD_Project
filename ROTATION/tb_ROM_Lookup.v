`include "CONSTANTS.v"

module tb_ROM_Lookup();

    reg [4:0] index;
    wire [31:0] answer;
    reg [1:0] mode;

    ROM_Lookup myROM(.index(index) , .module_output(answer), .mode(mode));

    initial
    begin
        mode = `HYPERBOLIC;
        index = 5'b00000;
        #5
        index = 5'b00001;
        #5
        index = 5'b00010;
        #5
        index = 5'b00011;
        #5
        index = 5'b00100;
        #5
        index = 5'b00101;
        #5
        index = 5'b00110;
        #5
        index = 5'b00111;
        #5
        index = 5'b01000;
        #5
        index = 5'b01001;
        #5
        index = 5'b01010;
        #5
        index = 5'b01011;
        #5
        index = 5'b01100;
        #5
        index = 5'b01101;
        #5
        index = 5'b01110;
        #5
        index = 5'b01111;
        #5
        index = 5'b10000;
        #5
        index = 5'b10001;
        #5
        index = 5'b10010;
        #5
        index = 5'b10011;
        #5
        index = 5'b10100;
        #5
        index = 5'b10101;
        #5
        index = 5'b10110;
        #5
        index = 5'b10111;
        #5
        index = 5'b11000;
        #5
        index = 5'b11001;
        #5
        index = 5'b11010;
        #5
        index = 5'b11011;
        #5
        index = 5'b11100;
        #5
        index = 5'b11101;
        #5
        index = 5'b11110;
        #5
        index = 5'b11111;               
        
    end



endmodule
