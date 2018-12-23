`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/23 15:45:41
// Design Name: 
// Module Name: DutyCounter_tb
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


module DutyCounter_tb(

    );
    reg CLK;
    reg PWM_in;
    wire High_time;
    wire Cycle_time;
    initial begin
        CLK = 0;
        PWM_in = 0;
    end
    always begin
        #5 CLK = ~CLK;
    end
    always begin
        #500 PWM_in = 1;
        #1500 PWM_in = 0;
    end
    top uut(
        .CLK(CLK),
        .PWM_in(PWM_in),
        .High_time(High_time),
        .Cycle_time(Cycle_time)
        );
endmodule
