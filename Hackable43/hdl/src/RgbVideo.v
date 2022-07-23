`timescale 1ps/1ps
/* SimpleVga generator
* 640 x 480 with 25Mhz clock
* Widely inspired by fpga4fun :
* https://www.fpga4fun.com/PongGame.html
*/

//`define VGA640X480
`define VGA800X600

module RgbVideo
(
    input clk_i,
    input rst_i,
    // VGA output
    output red_o,
    output green_o,
    output blue_o,
    output vsync_o,
    output hsync_o
);

wire display_on;
wire [10:0] hpos;
wire [9:0] vpos;

/* hvsync */
HVSync hvs(
    .clk_i(clk_i),
    .rst_i(rst_i),
    .hsync_o(hsync_o),
    .vsync_o(vsync_o),
    .display_on,
    .hpos(hpos),
    .vpos(vpos)
);

localparam SQWIDTH = 2;

`ifdef VGA640X480
localparam HWIDTH = 640;
localparam VWIDTH = 480;
`endif
`ifdef VGA800X600
localparam HWIDTH = 800;
localparam VWIDTH = 600;
`endif

wire square =    (hpos <= SQWIDTH)
              || ((hpos <= (HWIDTH - 1)) && (hpos >= (HWIDTH - SQWIDTH - 1)))
              || (vpos <= SQWIDTH)
              || ((vpos <= VWIDTH - 1) && (vpos >= VWIDTH - SQWIDTH - 1));

assign red_o = display_on & ((hpos[4] == 1'b1) | square);
assign green_o = display_on & ((hpos[5] == 1'b1) | square);
assign blue_o = display_on & ((hpos[6] == 1'b1) | square);

/* 640 x 480 : X * Y */

endmodule
