`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/19 11:19:20
// Design Name: 
// Module Name: tb_imread
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


module tb_imread(

    );
    // parameter
    parameter img_width = 24;
    parameter img_deepth = 262144;
    
    reg clk;
    reg rst_n;
    wire [img_width - 1 : 0] img_dout;
    wire img_dout_vld;
    imread u_imread(
        clk,rst_n,
        img_dout,img_dout_vld
    );
    initial begin
        clk=0;
        rst_n=0;
        #10 rst_n  = 1;
        //40 * 262144+1
        # 10_485_800 $finish;
    end
    always #20 clk = ~clk; 
    
endmodule
