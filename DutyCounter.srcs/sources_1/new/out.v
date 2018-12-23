`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/23 15:18:34
// Design Name: 
// Module Name: out_flag
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


module out_flag(
    input CLK,
    output flag
    );
    reg [5:0] cnt = 6'b0;//发送一次要28个时钟周期，那么就每50个周期发送一次
    reg flag_reg;
    always @ (posedge CLK)
        begin
            if (cnt == 6'd50)
                begin
                    flag_reg <= 1'b1;
                    cnt <= 1'b0;
                end
            else if (cnt == 1)
                begin
                    flag_reg <= 1'b0;
                    cnt <= cnt + 1'b1;
                end
            else
                cnt <= cnt + 1'b1;
        end
    assign flag = flag_reg;
endmodule
