`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/23 14:45:01
// Design Name: 
// Module Name: para2serial
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


module para2serial #(parameter N = 27) (
    input CLK,
    input load,
    input [N-1:0] para_in,
    output serial_out
    );
    reg [N+1:0] output_buffer_reg;//˼·��ƽʱ�����Ϊ�͵�ƽ����һ���ߵ�ƽΪ�����ʼ�ı�־��֮���NλΪ���
    always @ (posedge CLK)
        begin
            if (load)
                output_buffer_reg <= {1'b0, 1'b1, para_in};
            else
                output_buffer_reg <= output_buffer_reg << 1;
        end
    assign serial_out = output_buffer_reg[N+1];
endmodule
