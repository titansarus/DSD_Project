`include "CONSTANTS.v"

module tb_CORDIC_Rotation();

parameter PERIOD = 5;
parameter CHANGE_STATE_PERIOD = 1000;

reg [31:0] circular_input_x [19:0], circular_input_y [19:0], circular_input_z [19:0];
reg [31:0] circular_output_x [19:0], circular_output_y [19:0], circular_output_z [19:0];

reg [31:0] linear_input_x [19:0], linear_input_y [19:0], linear_input_z [19:0];
reg [31:0] linear_output_x [19:0], linear_output_y [19:0], linear_output_z [19:0];

reg signed [31:0] x, y, angle;
wire signed [31:0] rotated_x, rotated_y, final_angle;

integer file, content, i;

reg [1:0] mode;
reg clock;

CORDIC_Rotation cr (.clock(clock),.x(x) ,.y(y) , .angle(angle) , .mode(mode) , .rotated_x(rotated_x) , .rotated_y(rotated_y) , .final_angle(final_angle));

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
    file = $fopen("RotationCircular.txt","r");
    for(i=0;i<20;i=i+1)
      content = $fscanf(file, "%b %b %b %b %b %b\n", circular_input_x[i][31:0], circular_input_y[i][31:0], circular_input_z[i][31:0], circular_output_x[i][31:0], circular_output_y[i][31:0], circular_output_z[i][31:0]);
    file = $fopen("RotationLinear.txt","r");
    for(i=0;i<20;i=i+1)
      content = $fscanf(file, "%b %b %b %b %b %b\n", linear_input_x[i][31:0], linear_input_y[i][31:0], linear_input_z[i][31:0], linear_output_x[i][31:0], linear_output_y[i][31:0], linear_output_z[i][31:0]);
    end

initial
  begin
    for(i=0;i<20;i=i+1)
    begin
      #10
      mode = `CIRCULAR;
      x = circular_input_x[i];
      y = circular_input_y[i];
      angle = circular_input_z[i];
    
    end
    #CHANGE_STATE_PERIOD
    for(i=0;i<20;i=i+1)
    begin
      #10
      mode = `LINEAR;
      x = linear_input_x[i];
      y = linear_input_y[i];
      angle = linear_input_z[i];
  
    end  
  end
endmodule