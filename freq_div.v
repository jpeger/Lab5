`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:02:09 08/18/2015 
// Design Name: 
// Module Name:    freq_div 
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
module freq_div(
	clk,
	rst_n,
	cnt
);

input clk,rst_n;
output [25:0]cnt;

reg [25:0]cnt,next_cnt;

always@(posedge clk or negedge rst_n)
	if(~rst_n)
		cnt <= 26'd0;
	else
		cnt <= next_cnt;
		
always@(*)
	if(cnt==26'b11_1111_1111_1111_1111_1111_1111)
		next_cnt = 26'd0;
	else
		next_cnt = cnt + 26'd1;

endmodule
