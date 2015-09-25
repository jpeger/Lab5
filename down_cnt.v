`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:03:59 08/13/2015 
// Design Name: 
// Module Name:    down_counter 
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
module down_cnt(
	sec0,
	sec1,
	min0,
	min1,
	clk,
	rst_n,
	state,
	zero
);
localparam IDLE1=2'b00;
localparam IDLE2=2'b01;
localparam RUN = 2'b10;
localparam STOP =2'b11;

output [3:0]sec0,sec1,min0,min1;
input clk,rst_n;
input [1:0]state;
input zero;
reg [3:0]sec0,sec1,min0,min1;
reg [3:0]next_sec0,next_sec1,next_min0,next_min1;
//reg reset_state,next_reset_state;

always@(posedge clk or negedge rst_n)
	if(~rst_n)begin
		sec0 <= 4'd0;
		sec1 <= 4'd0;
		min0 <= 4'd0;
		min1 <= 4'd0;
		//reset_state <= 1'b0;
	end
	else begin
		sec0 <= next_sec0;
		sec1 <= next_sec1;
		min0 <= next_min0;
		min1 <= next_min1;
		//reset_state <= next_rsset_state;
	end

always@(*)
	case(state)
		IDLE1: begin
			next_sec0 = 4'd0;
			next_sec1 = 4'd3;
			next_min0 = 4'd0;
			next_min1 = 4'd0;
		end
		IDLE2: begin
			next_sec0 = 4'd0;
			next_sec1 = 4'd0;
			next_min0 = 4'd1;
			next_min1 = 4'd0;
		end		
		RUN: begin
			if(sec0==4'd0 && sec1==4'd0 && min0==4'd0 && min1==4'd0) begin
				next_sec0 = sec0;
		        next_sec1 = sec1;
		        next_min0 = min0;
		        next_min1 = min1;
			end
			else if(sec0==4'd0 && sec1==4'd0 && min0==4'd0 && min1!=4'd0)begin
				next_sec0 = 4'd9;
			    next_sec1 = 4'd5;
			    next_min0 = 4'd9;
			    next_min1 = min1 - 4'd1;
			end
			else if(sec0==4'd0 && sec1==4'd0 && min0!=4'd0)begin
				next_sec0 = 4'd9;
			    next_sec1 = 4'd5;
			    next_min0 = min0 - 4'd1;
			    next_min1 = min1;
			end
			else if(sec0==4'd0 && sec1!=4'd0)begin
				next_sec0 = 4'd9;
			    next_sec1 = sec1 - 4'd1;
			    next_min0 = min0;
			    next_min1 = min1;
			end
			else begin
				next_sec0 = sec0 - 4'd1;
			    next_sec1 = sec1;
			    next_min0 = min0;
			    next_min1 = min1;
			end
		end
		STOP: begin
				next_sec0 = sec0;
				next_sec1 = sec1;
				next_min0 = min0;
				next_min1 = min1;
		end
		default: begin
				next_sec0 = sec0;
				next_sec1 = sec1;
				next_min0 = min0;
				next_min1 = min1;
		end
	endcase
	
endmodule