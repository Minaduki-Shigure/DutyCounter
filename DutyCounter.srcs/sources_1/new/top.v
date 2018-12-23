`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/23 14:18:53
// Design Name: 
// Module Name: top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top(
    input CLK,
    input PWM_in,
    output High_time,
    output Cycle_time
    );
    wire out_flag;
    wire [26:0] High_time_para;
    wire [26:0] Low_time_para;
    wire [26:0] Cycle_time_para;
    PWM_cnt cnt(
        .CLK(CLK),
        .PWM_in(PWM_in),
        .High_time_para(High_time_para),
        .Low_time_para(Low_time_para),
        .Cycle_time_para(Cycle_time_para)
        );
    out_flag out(
        .CLK(CLK),
        .flag(out_flag)
        );
    para2serial convert_high(
        .CLK(CLK),
        .load(out_flag),
        .para_in(High_time_para),
        .serial_out(High_time)
        );
    para2serial convert_cycle(
        .CLK(CLK),
        .load(out_flag),
        .para_in(Cycle_time_para),
        .serial_out(Cycle_time)
        );
endmodule
