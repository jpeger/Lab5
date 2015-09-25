`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:59:04 08/20/2015 
// Design Name: 
// Module Name:    control 
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
module control(
	state,
	clk,
	rst_n,
	mode,
	down_cnt_en,
	zero
);

localparam IDLE1=2'b00;
localparam IDLE2=2'b01;
localparam RUN = 2'b10;
localparam STOP =2'b11;


output [1:0]state;
input clk,rst_n;
input mode,down_cnt_en,zero;

reg [1:0]state,next_state;
reg reset_state,next_reset_state;

always@(posedge clk or negedge rst_n)
	if(~rst_n)
		state <= IDLE1;
	else
		state <= next_state;
		
always@(posedge clk or negedge rst_n)
	if(~rst_n)
		reset_state <= 1'b1;
	else
		reset_state <= next_reset_state;
		
always@(*)
	case(state)
		IDLE1: begin
			if(zero==1'b1) begin
				next_state = state;
				next_reset_state = 1'b1;
			end
			else begin
				if(mode==1'b1 && down_cnt_en==1'b0) begin
					next_state = IDLE2;
					next_reset_state = 1'b0;
				end
				else if(mode==1'b0 && down_cnt_en==1'b1) begin
					next_state = RUN;
					next_reset_state = reset_state;
				end
				else begin
					next_state = state;
					next_reset_state = reset_state;
				end
			end
		end
		IDLE2: begin
			if(zero==1'b1) begin
				next_state = state;
				next_reset_state = 1'b0;
			end
			else begin
				if(mode==1'b1 && down_cnt_en==1'b0) begin
					next_state = IDLE1;
					next_reset_state = 1'b1;
				end
				else if(mode==1'b0 && down_cnt_en==1'b1) begin
					next_state = RUN;
					next_reset_state = reset_state;
				end
				else begin
					next_state = state;
					next_reset_state = reset_state;
				end
			end
		end
		/*IDLE2: begin
			if(mode==1'b1 && down_cnt_en==1'b0) begin
				next_state = IDLE1;
				next_reset_state = 1'b1;
			end
			else if(mode==1'b0 && down_cnt_en==1'b1) begin
				next_state = RUN;
				next_reset_state = reset_state;
			end
			else begin
				next_state = state;
				next_reset_state = reset_state;
			end
		end*/
		RUN : begin
			if(zero==1'b1) begin
				if(reset_state==1'b1) begin
					next_state = IDLE1;
					next_reset_state = 1'b1;
				end
				else begin
					next_state = IDLE2;
					next_reset_state = 1'b0;
				end
			end
			else begin
				if(mode==1'b0 && down_cnt_en==1'b1) begin
					next_state = STOP;
					next_reset_state = reset_state;
				end
				else begin
					next_state = state;
					next_reset_state = reset_state;
				end
			end
		end
		/*RUN : begin
			if(zero==1'b1 && reset_state==1'b1) begin
				next_state = IDLE1;
				next_reset_state = 1'b1;
			end
			else if(zero==1'b1 && reset_state==1'b0) begin
				next_state = IDLE2;
				next_reset_state = 1'b0;
			end
			else if(mode==1'b0 &&down_cnt_en==1'b1) begin
				next_state = STOP;
				next_reset_state = reset_state;
			end
			else begin
				next_state = state;
				next_reset_state = reset_state;
			end
		end*/
		STOP : begin
			if(zero==1'b1) begin
				if(reset_state==1'b1) begin
					next_state = IDLE1;
					next_reset_state = 1'b1;
				end
				else begin
					next_state = IDLE2;
					next_reset_state = 1'b0;
				end
			end
			else begin
				if(mode==1'b1 && down_cnt_en==1'b0) begin
					next_state = IDLE1;
					next_reset_state = 1'b1;
				end
				else if(mode==1'b0 && down_cnt_en==1'b1) begin
					next_state = RUN;
					next_reset_state = reset_state;
				end
				else begin
					next_state = state;
					next_reset_state = reset_state;
				end
			end
		end
		/*STOP : begin
			if(zero==1'b1 && reset_state==1'b1) begin
				next_state = IDLE1;
				next_reset_state = 1'b1;
			end
			else if(zero==1'b1 && reset_state==1'b0) begin
				next_state = IDLE2;
				next_reset_state = 1'b0;
			end
			else if(mode==1'b1 && down_cnt_en==1'b0) begin
				next_state = IDLE1;
				next_reset_state = reset_state;
			end
			else if(mode==1'b0 && down_cnt_en==1'b1) begin
				next_state = RUN;
				next_reset_state = reset_state;
			end
			else begin
				next_state = state;
				next_reset_state = reset_state;
			end
		end*/
		default: begin
			next_state = state;
			next_reset_state = reset_state;
		end
	endcase	

endmodule
