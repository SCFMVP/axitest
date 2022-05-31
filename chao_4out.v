`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/18 11:24:25
// Design Name: 
// Module Name: chao_4out
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


module chao_4out(
    clk, rst_n, 
    ap_start,ap_ready,
    x_seq, x_ap_valid, y_seq, y_ap_valid, z_seq, z_ap_valid, w_seq, w_ap_valid
    );
    
    // parameter
    parameter integerBits   = 1;  //整数位
    parameter fractionBits  = 31; //小数位
    localparam totalBits = integerBits + fractionBits; // 符号位+整数位+小数位
    // start value (key)
    parameter [totalBits - 1 : 0] startX = 0.5 * (2.0 ** fractionBits);
    parameter [totalBits - 1 : 0] startY = 0.3 * (2.0 ** fractionBits);
    parameter [totalBits - 1 : 0] startZ = 0.7 * (2.0 ** fractionBits); 
    parameter [totalBits - 1 : 0] startW = 0.5 * (2.0 ** fractionBits); 
    // canshu
    parameter [totalBits - 1 : 0] a1 =   0.2 * (2.0 ** fractionBits); 
    parameter [totalBits - 1 : 0] b1 =   1.8 * (2.0 ** fractionBits); 
    parameter [totalBits - 1 : 0] c1 =   3.2 * (2.0 ** fractionBits); 
    parameter [totalBits - 1 : 0] d1 =   4.2 * (2.0 ** fractionBits); 
    parameter [totalBits - 1 : 0] a2 =   3   * (2.0 ** fractionBits); 
    parameter [totalBits - 1 : 0] b2 =   2   * (2.0 ** fractionBits); 
    parameter [totalBits - 1 : 0] c2 =   3   * (2.0 ** fractionBits); 
    parameter [totalBits - 1 : 0] d2 =   4   * (2.0 ** fractionBits); 
    parameter [totalBits - 1 : 0] a3 =   4   * (2.0 ** fractionBits); 
    parameter [totalBits - 1 : 0] b3 =   3   * (2.0 ** fractionBits); 
    parameter [totalBits - 1 : 0] c3 =  11   * (2.0 ** fractionBits); 
    parameter [totalBits - 1 : 0] d3 =   3   * (2.0 ** fractionBits); 
    parameter [totalBits - 1 : 0] a4 =   4.2 * (2.0 ** fractionBits); 
    parameter [totalBits - 1 : 0] b4 =   3.2 * (2.0 ** fractionBits); 
    parameter [totalBits - 1 : 0] c4 =   1.8 * (2.0 ** fractionBits); 
    parameter [totalBits - 1 : 0] d4 =  12.8 * (2.0 ** fractionBits); 
    
    // port 
    input wire clk;
    input wire rst_n;
    input wire ap_start;
    output reg ap_ready;
    output reg [totalBits - 1 : 0] x_seq;
    output reg [totalBits - 1 : 0] y_seq;
    output reg [totalBits - 1 : 0] z_seq;
    output reg [totalBits - 1 : 0] w_seq;
    output reg x_ap_valid;
    output reg y_ap_valid;
    output reg z_ap_valid;
    output reg w_ap_valid;
    //inside wire or reg
    reg [totalBits * 2 - 1 : 0] a,b,c,d;
    // fmc
    
    // rst
    always @ (posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            ap_ready   <= 1'b1;
            x_seq      <= startX;
            y_seq      <= startY;
            z_seq      <= startZ;
            w_seq      <= startW;
            x_ap_valid <= 1'b0;
            y_ap_valid <= 1'b0;
            z_ap_valid <= 1'b0;
            w_ap_valid <= 1'b0;            
        end
        else begin
            a = (a1 * x_seq + b1 * y_seq + c1 * z_seq + d1 * w_seq) ;                  
            b = (a2 * x_seq + b2 * y_seq + c2 * z_seq + d2 * w_seq) ;                  
            c = (a3 * x_seq + b3 * y_seq + c3 * z_seq + d3 * w_seq) ;                  
            d = (a4 * x_seq + b4 * y_seq + c4 * z_seq + d4 * w_seq) ;   
            x_seq = a >> fractionBits;                  
            y_seq = b >> fractionBits;                  
            z_seq = c >> fractionBits;                  
            w_seq = d >> fractionBits;   
//            x_seq <= (a1 * x_seq + b1 * y_seq + c1 * z_seq + d1 * w_seq) >> fractionBits;                  
//            y_seq <= (a2 * x_seq + b2 * y_seq + c2 * z_seq + d2 * w_seq) >> fractionBits;                  
//            z_seq <= (a3 * x_seq + b3 * y_seq + c3 * z_seq + d3 * w_seq) >> fractionBits;                  
//            w_seq <= (a4 * x_seq + b4 * y_seq + c4 * z_seq + d4 * w_seq) >> fractionBits;               
            x_ap_valid = 1;
            y_ap_valid = 1;
            z_ap_valid = 1;
            w_ap_valid = 1;
        end
    end
    
    
    
    
endmodule
