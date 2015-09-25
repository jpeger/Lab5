`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:21:38 08/13/2015 
// Design Name: 
// Module Name:    scan_ctl 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module scan_ctl(
	ftsd_ctl,
	ftsd_in,
	in0,
	in1,
	in2,
	in3,
	ftsd_ctl_en
);

output [3:0]ftsd_ctl,ftsd_in;
input [3:0]in0,in1,in2,in3;
input [1:0]ftsd_ctl_en;

reg [3:0]ftsd_ctl,ftsd_in;

always@(ftsd_ctl_en)
	case(ftsd_ctl_en)
		2'b00: begin
			ftsd_ctl = 4'b1110;
			ftsd_in = in0;
		end
		2'b01: begin
			ftsd_ctl = 4'b1101;
			ftsd_in = in1;
		end
		2'b10: begin
			ftsd_ctl = 4'b1011;
			ftsd_in = in2;
		end
		2'b11: begin
			ftsd_ctl = 4'b0111;
			ftsd_in = in3;
		end
		default: begin
			ftsd_ctl = 4'b1111;
			ftsd_in = 4'b0000;
		end
	endcase
	

endmodule
