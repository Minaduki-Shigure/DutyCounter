`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/23 14:20:26
// Design Name: 
// Module Name: PWM_cnt
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


module PWM_cnt(
    input CLK,
    input PWM_in,
    output [26:0] High_time_para,
    output [26:0] Low_time_para,
    output [26:0] Cycle_time_para
    );
    reg [26:0] cnt_high;
    reg [26:0] cnt_low;
    reg [26:0] loadbuffer_high;
    reg [26:0] loadbuffer_low;
    reg [26:0] loadbuffer_cycle;
    always @ (posedge CLK)
        begin
            if (PWM_in == 1)
                begin
                    cnt_high <= cnt_high + 1'b1;
                    if (cnt_low)
                        loadbuffer_low <= cnt_low;
                    cnt_low <= 1'b0;
                end
            else
                begin
                    cnt_low <= cnt_low + 1'b1;
                    if (cnt_high)
                        loadbuffer_high <= cnt_high;
                    cnt_high <= 1'b0;
                end
        end
    always @ (posedge CLK)
        begin
            loadbuffer_cycle <= loadbuffer_high + loadbuffer_low;
        end
    assign High_time_para = loadbuffer_high;
    assign Low_time_para = loadbuffer_low;
    assign Cycle_time_para = loadbuffer_cycle;
endmodule
