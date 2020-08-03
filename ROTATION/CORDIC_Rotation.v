`include "CONSTANTS.v"

module CORDIC_Rotation(input clock,
    input signed [31:0] x,
    input signed [31:0] y,
    input signed [31:0] angle,
    input [1:0] mode,
    output wire signed [31:0] rotated_x,
    output wire signed [31:0] rotated_y,
    output wire signed [31:0] final_angle);
parameter NUMBER_OF_ITERATIONS = 29;

wire signed [31:0] x_prime [0:NUMBER_OF_ITERATIONS-1];
wire signed [31:0] y_prime [0:NUMBER_OF_ITERATIONS-1];
wire signed [31:0] x_start, y_start,angle_start;
wire signed [31:0] rotated_angles [0:NUMBER_OF_ITERATIONS-1];

Quadrant_Corrector qc(.x(x) , .y(y) , .angle(angle) , .x_out(x_start) , .y_out(y_start) , .angle_out(angle_start));


begin
  assign  x_prime[0] = x_start;
  assign  y_prime[0] = y_start;
  assign rotated_angles[0] = angle_start;
end



// x_start = (x>>>1)+(x>>>4)+(x>>>5);
// y_start = (y>>>1)+(y>>>4)+(y>>>5);



genvar i;
generate
for (i=0;i<NUMBER_OF_ITERATIONS;i=i+1)
begin: iterations
	    wire signed [31:0] xshift, yshift , lta;

        assign xshift = x_prime[i] >>> i; // signed shift right
        assign yshift = y_prime[i] >>> i;
        assign lta = Lookup(i , mode);
	
		
        X_Calculator xc(.x(x_prime[i]) , .y(y_prime[i]) , .angle(rotated_angles[i])
        , .mode (mode) , .y_shift(yshift) , .clock(clock) , .x_out(x_prime[i+1]));
        Y_Calculator yc(.y(y_prime[i]) , .angle(rotated_angles[i]), .x_shift(xshift), .clock(clock), .y_out(y_prime[i+1]));
        Z_Calculator zc(.angle(rotated_angles[i]) , .lookup_table_amount(lta) , .clock(clock) , .angle_out(rotated_angles[i+1]));
	


end
endgenerate




wire [31:0] scaled_x , scaled_y;

Scaler scaler(.number(x_prime[NUMBER_OF_ITERATIONS-1]) , .mode(mode) , .answer(scaled_x));
Scaler scaler2(.number(y_prime[NUMBER_OF_ITERATIONS-1]) , .mode(mode) , .answer(scaled_y));

assign rotated_x = scaled_x;
assign rotated_y = scaled_y;
assign final_angle = rotated_angles[NUMBER_OF_ITERATIONS-1];


 function [31:0] Lookup;
 
    input [4:0] index; input [1:0] mode;
     begin : funcbody
    //LINEAR = 00 , CIRCULAR = 10, HYPERBOLIC = 11

  
    reg [31:0] atan_table [0:31];
    reg [31:0] atanh_table [0:31];
    reg [31:0] lin_table [0:31];

//00010000000000000000000000000000 45 deg
//00110000000000000000000000000000 135 deg
//01010000000000000000000000000000 225 deg
//01110000000000000000000000000000 315 deg

  
     
    
     atan_table[0] 	= 32'b00010000000000000000000000000000;
     atan_table[1] 	= 32'b00001001011100100000001010001111;
     atan_table[2] 	= 32'b00000100111111011001110000101110;
     atan_table[3] 	= 32'b00000010100010001000100011101010;
     atan_table[4] 	= 32'b00000001010001011000011010100010;
     atan_table[5] 	= 32'b00000000101000101110101111110001;
     atan_table[6] 	= 32'b00000000010100010111101100001111;
     atan_table[7] 	= 32'b00000000001010001011111000101011;
     atan_table[8] 	= 32'b00000000000101000101111100101010;
     atan_table[9] 	= 32'b00000000000010100010111110010111;
     atan_table[10] 	= 32'b00000000000001010001011111001100;
     atan_table[11] 	= 32'b00000000000000101000101111100110;
     atan_table[12] 	= 32'b00000000000000010100010111110011;
     atan_table[13] 	= 32'b00000000000000001010001011111010;
     atan_table[14] 	= 32'b00000000000000000101000101111101;
     atan_table[15] 	= 32'b00000000000000000010100010111110;
     atan_table[16] 	= 32'b00000000000000000001010001011111;
     atan_table[17] 	= 32'b00000000000000000000101000110000;
     atan_table[18] 	= 32'b00000000000000000000010100011000;
     atan_table[19] 	= 32'b00000000000000000000001010001100;
     atan_table[20] 	= 32'b00000000000000000000000101000110;
     atan_table[21] 	= 32'b00000000000000000000000010100011;
     atan_table[22] 	= 32'b00000000000000000000000001010001;
     atan_table[23] 	= 32'b00000000000000000000000000101001;
     atan_table[24] 	= 32'b00000000000000000000000000010100;
     atan_table[25] 	= 32'b00000000000000000000000000001010;
     atan_table[26] 	= 32'b00000000000000000000000000000101;
     atan_table[27] 	= 32'b00000000000000000000000000000011;
     atan_table[28] 	= 32'b00000000000000000000000000000001;
     atan_table[29] 	= 32'b00000000000000000000000000000001;
     atan_table[30] 	= 32'b00000000000000000000000000000000;
     atan_table[31] 	= 32'b00000000000000000000000000000000;

     atanh_table[0] 	= 32'b01000110010011111010100111101011; //dont now what is this exactly
     atanh_table[1] 	= 32'b01000110010011111010100111101011;
     atanh_table[2] 	= 32'b00100000101100010101110111110101;
     atanh_table[3] 	= 32'b00010000000101011000100100011101;
     atanh_table[4] 	= 32'b00001000000000101010110001000101;
     atanh_table[5] 	= 32'b00000100000000000101010101100010;
     atanh_table[6] 	= 32'b00000010000000000000101010101011;
     atanh_table[7] 	= 32'b00000001000000000000000101010101;
     atanh_table[8] 	= 32'b00000000100000000000000000101011;
     atanh_table[9] 	= 32'b00000000010000000000000000000101;
     atanh_table[10] 	= 32'b00000000001000000000000000000001;
     atanh_table[11] 	= 32'b00000000000100000000000000000000;
     atanh_table[12] 	= 32'b00000000000010000000000000000000;
     atanh_table[13] 	= 32'b00000000000001000000000000000000;
     atanh_table[14] 	= 32'b00000000000000100000000000000000;
     atanh_table[15] 	= 32'b00000000000000010000000000000000;
     atanh_table[16] 	= 32'b00000000000000001000000000000000;
     atanh_table[17] 	= 32'b00000000000000000100000000000000;
     atanh_table[18] 	= 32'b00000000000000000010000000000000;
     atanh_table[19] 	= 32'b00000000000000000001000000000000;
     atanh_table[20] 	= 32'b00000000000000000000100000000000;
     atanh_table[21] 	= 32'b00000000000000000000010000000000;
     atanh_table[22] 	= 32'b00000000000000000000001000000000;
     atanh_table[23] 	= 32'b00000000000000000000000100000000;
     atanh_table[24] 	= 32'b00000000000000000000000010000000;
     atanh_table[25] 	= 32'b00000000000000000000000001000000;
     atanh_table[26] 	= 32'b00000000000000000000000000100000;
     atanh_table[27] 	= 32'b00000000000000000000000000010000;
     atanh_table[28] 	= 32'b00000000000000000000000000001000;
     atanh_table[29] 	= 32'b00000000000000000000000000000100;
     atanh_table[30] 	= 32'b00000000000000000000000000000010;
     atanh_table[31] 	= 32'b00000000000000000000000000000001;


     lin_table[0] 	= 32'b10000000000000000000000000000000;
     lin_table[1] 	= 32'b01000000000000000000000000000000;
     lin_table[2] 	= 32'b00100000000000000000000000000000;
     lin_table[3] 	= 32'b00010000000000000000000000000000;
     lin_table[4] 	= 32'b00001000000000000000000000000000;
     lin_table[5] 	= 32'b00000100000000000000000000000000;
     lin_table[6] 	= 32'b00000010000000000000000000000000;
     lin_table[7] 	= 32'b00000001000000000000000000000000;
     lin_table[8] 	= 32'b00000000100000000000000000000000;
     lin_table[9] 	= 32'b00000000010000000000000000000000;
     lin_table[10] 	= 32'b00000000001000000000000000000000;
     lin_table[11] 	= 32'b00000000000100000000000000000000;
     lin_table[12] 	= 32'b00000000000010000000000000000000;
     lin_table[13] 	= 32'b00000000000001000000000000000000;
     lin_table[14] 	= 32'b00000000000000100000000000000000;
     lin_table[15] 	= 32'b00000000000000010000000000000000;
     lin_table[16] 	= 32'b00000000000000001000000000000000;
     lin_table[17] 	= 32'b00000000000000000100000000000000;
     lin_table[18] 	= 32'b00000000000000000010000000000000;
     lin_table[19] 	= 32'b00000000000000000001000000000000;
     lin_table[20] 	= 32'b00000000000000000000100000000000;
     lin_table[21] 	= 32'b00000000000000000000010000000000;
     lin_table[22] 	= 32'b00000000000000000000001000000000;
     lin_table[23] 	= 32'b00000000000000000000000100000000;
     lin_table[24] 	= 32'b00000000000000000000000010000000;
     lin_table[25] 	= 32'b00000000000000000000000001000000;
     lin_table[26] 	= 32'b00000000000000000000000000100000;
     lin_table[27] 	= 32'b00000000000000000000000000010000;
     lin_table[28] 	= 32'b00000000000000000000000000001000;
     lin_table[29] 	= 32'b00000000000000000000000000000100;
     lin_table[30] 	= 32'b00000000000000000000000000000010;
     lin_table[31] 	= 32'b00000000000000000000000000000001;





     Lookup = (mode == `CIRCULAR)? atan_table[index] : ((mode == `HYPERBOLIC)? atanh_table[index] : lin_table[index]);
   end
  endfunction

endmodule

