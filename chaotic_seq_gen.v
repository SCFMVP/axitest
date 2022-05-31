`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/07 13:54:32
// Design Name: 
// Module Name: chaotic_seq_gen
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


module chaotic_seq_gen (
//clk, rst_n, 
//ap_start,ap_ready,
//x_seq, x_ap_valid, y_seq, y_ap_valid, z_seq, z_ap_valid
clk, dt, skip, x, y, z
);
       
    // parameter
    parameter integerBits   = 6;  //整数位
    parameter fractionBits  = 25; //小数位
    localparam totalBits = 1 + integerBits + fractionBits; // 符号位+整数位+小数位
    
//    parameter imgWidth  = 64;
//    parameter imgHeight = 64;
//    parameter imgDeep   = 8;    // 0-255 gray / single channel
//    localparam pointNum = imgWidth * imgHeight;
    
    // ports 
//    input                    clk;
//    input                    rst_n;
//    input                    ap_start;  // 开始生成有效数
//    output                   ap_ready;  // 开始产生所需的数时
    
//    output [totalBits - 1:0] x_seq;
//    output                   x_ap_valid;
//    output [totalBits - 1:0] y_seq;
//    output                   y_ap_valid;
//    output [totalBits - 1:0] z_seq;
//    output                   z_ap_valid;
    
    // from github
    parameter dtBits        = 16;
    parameter dtShift       = 30;
    parameter iteratorBits  = 16;
    
    parameter signed [integerBits + fractionBits : 0] sigma  =        10.0 * (2.0 ** $itor(fractionBits));  // 转换成定点小数
    parameter signed [integerBits + fractionBits : 0] beta   = (8.0 / 3.0) * (2.0 ** $itor(fractionBits));
    parameter signed [integerBits + fractionBits : 0] rho    =        28.0 * (2.0 ** $itor(fractionBits));
    
    parameter signed [integerBits + fractionBits : 0] startX =         8.0 * (2.0 ** fractionBits);
    parameter signed [integerBits + fractionBits : 0] startY =         8.0 * (2.0 ** fractionBits);
    parameter signed [integerBits + fractionBits : 0] startZ =        27.0 * (2.0 ** fractionBits);    
   
    input  wire clk;
    input  wire signed [dtBits       - 1 : 0] dt;
    input  wire        [iteratorBits - 1 : 0] skip;
    
    output reg  signed [totalBits    - 1 : 0] x = startX;
    output reg  signed [totalBits    - 1 : 0] y = startY;
    output reg  signed [totalBits    - 1 : 0] z = startZ;

    reg        [iteratorBits  - 1 : 0] iterator = 0;
    reg signed [totalBits     - 1 : 0] a        = startX;
    reg signed [totalBits     - 1 : 0] b        = startY;
    reg signed [totalBits     - 1 : 0] c        = startZ;
    reg signed [totalBits * 2 - 1 : 0] dxdt     = 0;
    reg signed [totalBits * 2 - 1 : 0] dydt     = 0;
    reg signed [totalBits * 2 - 1 : 0] dzdt     = 0;

    always @(posedge clk)
    begin
        iterator <= iterator + 1;    
       
        if (!iterator) begin
            // 为了循环生成，再次给初值
            x = a;
            y = b;
            z = c;
        end
        else begin
            if (iterator == skip) begin
                a = x;
                b = y;
                c = z;
            end

            dxdt = (sigma * (y - x)) >>> fractionBits;
            dydt = ((x * (rho - z)) >>> fractionBits) - y;
            dzdt = (x * y - beta * z) >>> fractionBits;

            x = x + ((dxdt * dt) >>> dtShift);//除2^n,为了保证小数点位置不变（>>>针对有符号数,>>针对无符号数）
            y = y + ((dydt * dt) >>> dtShift);
            z = z + ((dzdt * dt) >>> dtShift);
        end
    end
    
    
endmodule
