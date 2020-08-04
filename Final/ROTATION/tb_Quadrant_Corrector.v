
`include "CONSTANTS.v"

module tb_Quadrant_Corrector();

    reg [31:0] x;
    reg [31:0] y;
    reg [31:0] angle;
    wire [31:0] x_out;
    wire [31:0] y_out;
    wire [31:0] angle_out;



    Quardrant_Corrector myQC(.x(x) , .y(y) , .angle(angle) , .x_out(x_out) , .y_out(y_out) , .angle_out(angle_out));

    initial
    begin
       x = 32'd20;
       y = 32'd40;
       angle = 32'b00010000000000000000000000000000;
       #5
       x = 32'd20;
       y = 32'd40;
       angle = 32'b00110000000000000000000000000000;
       #5
       x = 32'd20;
       y = 32'd40;
       angle = 32'b01010000000000000000000000000000;
       #5
       x = 32'd20;
       y = 32'd40;
       angle = 32'b00101010101010101010101010101010;

    end
	
 initial
  begin
    $monitor ("@", $time, "ns:   x_out = %b ", x_out, "y_out = %b ", y_out, "angle_out = %b ", angle_out);  
  end


endmodule
