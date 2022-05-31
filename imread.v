`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/18 18:29:42
// Design Name: 
// Module Name: imread
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


module imread(
    clk,rst_n,
    img_dout,img_dout_vld
    );
    // parameter
    parameter img_width = 24;
    parameter img_deepth = 262144;
    // port
    input wire clk;
    input wire rst_n;
    output wire [img_width - 1 : 0] img_dout;
    output reg img_dout_vld;
    // inside wire or reg
    reg [19 - 1 : 0] count;
    wire [17 : 0] addra;
   
    // data相对addra有一个周期时钟的延迟！
    blk_mem_gen_0 u_single_native_rom_512_512_24bit (
      .clka(clk),    // input wire clka
      .addra(addra),  // input wire [17 : 0] addra
      .douta(img_dout)  // output wire [23 : 0] douta
    );
    
    always @ (posedge clk or negedge rst_n) begin
        if(!rst_n) begin
//            img_dout <= 'b0;
            img_dout_vld <= 1'b0;
            count <= 'b0;
        end
        else if(count!=img_deepth) begin
            count <= count + 1;
            img_dout_vld <= 1'b1;
        end
        else begin
            // count <= 'b0;
            img_dout_vld <= 1'b0;
        end
    end
    assign addra = count;
endmodule



