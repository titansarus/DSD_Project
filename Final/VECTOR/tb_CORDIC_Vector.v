`include "CONSTANTS.v"

module tb_CORDIC_Vector();

parameter PERIOD = 5;
parameter DELAY_BETWEEN_TESTS = 10;
parameter CHANGE_STATE_PERIOD = 1000;

reg [31:0] circular_input_x [9:0], circular_input_y [9:0];
reg [31:0] circular_output_x [9:0], circular_output_y [9:0], circular_output_z [9:0];

reg [31:0] linear_input_x [9:0], linear_input_y [9:0];
reg [31:0] linear_output_x [9:0], linear_output_y [9:0], linear_output_z [9:0];

reg signed [31:0] x, y, angle;
wire signed [31:0] rotated_x, rotated_y, final_angle;

integer file, content, i;

reg [1:0] mode;
reg clock;

TopModule cr (.clock(clock),.x(x) ,.y(y) , .angle(angle) , .mode(mode) , .rotated_x(rotated_x) , .rotated_y(rotated_y) , .final_angle(final_angle));

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
    file = $fopen("VectoringCircular.txt","r");
    for(i=0;i<10;i=i+1)
    begin
      content = $fscanf(file, "%b %b %b %b %b\n", circular_input_x[i][31:0], circular_input_y[i][31:0], circular_output_x[i][31:0], circular_output_y[i][31:0], circular_output_z[i][31:0]);
      $display("The %d th x_output is %b, y_output is %b, z_output is %b", i, circular_output_x[i], circular_output_y[i], circular_output_z[i]);
    end
    file = $fopen("VectoringLinear.txt","r");
    for(i=0;i<10;i=i+1)
    begin
      content = $fscanf(file, "%b %b %b %b %b\n", linear_input_x[i][31:0], linear_input_y[i][31:0], linear_output_x[i][31:0], linear_output_y[i][31:0], linear_output_z[i][31:0]);
      $display("The %d th x_output is %b, y_output is %b, z_output is %b", i,linear_output_x[i], linear_output_y[i], linear_output_z[i]);
    end
  end
  
initial
  begin
    for(i=0;i<10;i=i+1)
    begin
      #DELAY_BETWEEN_TESTS
      mode = `CIRCULAR;
      x = circular_input_x[i];
      y = circular_input_y[i];
      angle = 0;
    end
    #CHANGE_STATE_PERIOD
    for(i=0;i<10;i=i+1)
    begin
      #DELAY_BETWEEN_TESTS
      mode = `LINEAR;
      x = linear_input_x[i];
      y = linear_input_y[i];
      angle = 0;
    end  
  end
  
initial
  begin
    $monitor ("@", $time, "ns:   rotated_x = %b ", rotated_x, "rotated_y = %b ", rotated_y, "final_angle = %b ", final_angle);  
  end
 
endmodule