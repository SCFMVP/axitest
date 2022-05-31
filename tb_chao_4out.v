`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/18 11:56:55
// Design Name: 
// Module Name: tb_chao_4out
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


module tb_chao_4out(

    );
    localparam totalBits = 32;
    reg clk;
    reg rst_n;
    reg ap_start;
    wire ap_ready;
    wire [totalBits - 1 : 0] x_seq;
    wire [totalBits - 1 : 0] y_seq;
    wire [totalBits - 1 : 0] z_seq;
    wire [totalBits - 1 : 0] w_seq;
    wire x_ap_valid;
    wire y_ap_valid;
    wire z_ap_valid;
    wire w_ap_valid;
    chao_4out u_chao_4out(
    clk, rst_n, 
    ap_start,ap_ready,
    x_seq, x_ap_valid, y_seq, y_ap_valid, z_seq, z_ap_valid, w_seq, w_ap_valid
        );
    initial begin
        clk=0;
        rst_n=0;
        #10 rst_n  = 1;
        //40 * 1000
        # 40_000 $finish;
    end
    always #20 clk = ~clk;
endmodule
