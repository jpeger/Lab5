`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:23:03 08/19/2015 
// Design Name: 
// Module Name:    lab5 
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
module lab5(
	led,
	ftsd_ctl,
	ftseg,
	clk,
	rst_n,
	button0,
	button1	
);

output [15:0]led;
output [3:0]ftsd_ctl;
output [14:0]ftseg;

input clk,rst_n;
input button0,button1;

wire [25:0]cnt;
wire [3:0]bcd;
wire pulse0,pulse1;
wire [1:0]state;
wire zero;
wire [3:0]in0,in1,in2,in3;

//assign led[0] = (zero) ? 1'b1 : 1'b0;
//assign led[11:1] = 11'b00000000000;
//assign led[15] = (state==2'b00) ? 1'b1: 1'b0;
//assign led[14] = (state==2'b01) ? 1'b1: 1'b0;
//assign led[13] = (state==2'b10) ? 1'b1: 1'b0;
//assign led[12] = (state==2'b11) ? 1'b1: 1'b0;
assign led = |(in0 | in1 | in2 | in3) ? 16'd0 : 16'b1111_1111_1111_1111;

freq_div U0(
	.clk(clk),
	.rst_n(rst_n),
	.cnt(cnt)
);

push_button U1(
	.clk(cnt[18]),
	.button(button0),
	.pulse(pulse0),
	.long(zero)
);
push_button U2(
	.clk(cnt[18]),
	.button(button1),
	.pulse(pulse1),
	.long()
);

control U3(
	.state(state),
	.clk(cnt[18]),
	.rst_n(rst_n),
	.mode(pulse1),
	.down_cnt_en(pulse0),
	.zero(zero)
);

down_cnt U4(
	.sec0(in0),
	.sec1(in1),
	.min0(in2),
	.min1(in3),
	.clk(cnt[24]),
	.rst_n(rst_n),
	.state(state)
);

scan_ctl U5(
	.ftsd_ctl(ftsd_ctl),
	.ftsd_in(bcd),
	.in0(in0),
	.in1(in1),
	.in2(in2),
	.in3(in3),
	.ftsd_ctl_en(cnt[15:14])
);

bcd2ftsegdec U6(
	.display(ftseg),
	.bcd(bcd)
);

endmodule
