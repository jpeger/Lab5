`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:56:21 08/14/2015 
// Design Name: 
// Module Name:    push_button 
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
module push_button(
	clk,
	button,
	pulse,
	long
);
input clk;
input button;
output pulse;
output long;

reg [127:0]tmp;
reg pulse;
reg delay;

assign long = (&tmp==1'b1) ? 1'b1 : 1'b0;

always@(posedge clk) 
	begin
		tmp <= {tmp[126:0],~button};
	end

always@(posedge clk)
	delay <= (&tmp[3:0]);

always@(posedge clk)
	pulse <= (&tmp[3:0]) & (~delay);

	
endmodule
