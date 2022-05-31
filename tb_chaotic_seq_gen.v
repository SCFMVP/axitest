`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/07 15:03:00
// Design Name: 
// Module Name: tb_chaotic_seq_gen
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


module tb_chaotic_seq_gen(

    );
    localparam integerBits  = 6;
    localparam fractionBits = 25;
    localparam totalBits    = 1 + integerBits + fractionBits;
    
    localparam dtBits       = 20;
    localparam dtShift      = 32;
    localparam iteratorBits = 18;
    localparam sigma        =        10.0 * (2.0 ** $itor(fractionBits));
    localparam beta         = (8.0 / 3.0) * (2.0 ** $itor(fractionBits));
    localparam rho          =        28.0 * (2.0 ** $itor(fractionBits));
    
    reg  clkSlow;
    reg  signed [dtBits       - 1 : 0] dt   = 0.00005 * (2.0 ** dtShift);
    reg         [iteratorBits - 1 : 0] skip = 1024;
    
    wire signed [totalBits - 1 : 0] x0;
    wire signed [totalBits - 1 : 0] y0;
    wire signed [totalBits - 1 : 0] z0;
    
    chaotic_seq_gen #( 
        .integerBits(integerBits),
        .fractionBits(fractionBits),
        .dtBits(dtBits),
        .dtShift(dtShift),
        .iteratorBits(iteratorBits),
        .sigma(sigma),
        .beta(beta),
        .rho(rho)
    ) lorenz(clkSlow, dt, skip, x0, y0, z0);
    
    initial begin
        clkSlow<=0;
        #300 $finish;
    end
    always #5 clkSlow=~clkSlow;
endmodule
