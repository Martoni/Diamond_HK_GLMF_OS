`timescale 1ns/1ns

/* Horizontal, vertical VGA signals generation
* for 640 x 480 VGA
* inspired from fpga4fun
* and Stephen Hugg book "Designing Video Game Hardware in Verilog"
* */

//`define VGA640X480
`define VGA800X600

module HVSync(
    input clk_i,
    input rst_i,
    output reg hsync_o,
    output reg vsync_o,
    output display_on,
    output [10:0] hpos,
    output [9:0] vpos);

`ifdef VGA640X480
/* Dimensions for 640x480 @60Hz
* found here http://martin.hinner.info/vga/640x480_60.html*/
localparam H_DISPLAY = 640;  // horizontal display width
localparam H_FRONT = 8;      // front porch
localparam H_SYNC = 96;      // sync width
localparam H_BACK = 40;      // back porch

localparam V_SYNC = 4;       // sync width
localparam V_TOP = 4;        // top border
localparam V_DISPLAY = 480;  // vertical display width
localparam V_BOTTOM = 14;    // bottom border

localparam H_SYNC_START = H_DISPLAY + H_FRONT;
localparam H_SYNC_END = H_DISPLAY + H_FRONT + H_SYNC - 1;
localparam H_MAX = H_DISPLAY + H_BACK + H_FRONT + H_SYNC - 1; 

localparam V_SYNC_START = V_DISPLAY + V_BOTTOM;
localparam V_SYNC_END = V_DISPLAY + V_BOTTOM + V_SYNC - 1;
localparam V_MAX = V_DISPLAY + V_TOP + V_BOTTOM + V_SYNC - 1;
`endif
`ifdef VGA800X600
/* Dimensions for 800x600 @72Hz */
localparam H_DISPLAY = 800;  // horizontal display width
localparam H_FRONT = 53;      // front porch
localparam H_SYNC = 120;      // sync width
localparam H_BACK = 61;      // back porch

localparam V_SYNC = 6;       // sync width
localparam V_TOP = 21;        // top border
localparam V_DISPLAY = 600;  // vertical display width
localparam V_BOTTOM = 35;    // bottom border

localparam H_SYNC_START = H_DISPLAY + H_FRONT;
localparam H_SYNC_END = H_DISPLAY + H_FRONT + H_SYNC - 1;
localparam H_MAX = H_DISPLAY + H_BACK + H_FRONT + H_SYNC - 1; 

localparam V_SYNC_START = V_DISPLAY + V_BOTTOM;
localparam V_SYNC_END = V_DISPLAY + V_BOTTOM + V_SYNC - 1;
localparam V_MAX = V_DISPLAY + V_TOP + V_BOTTOM + V_SYNC - 1;
`endif


reg [10:0] hpos_count;
reg [9:0] vpos_count;

assign hpos = hpos_count;
assign vpos = vpos_count;

wire hpos_max = (hpos_count == H_MAX);
wire vpos_max = (vpos_count == V_MAX);

assign display_on = (hpos_count < H_DISPLAY) && (vpos_count < V_DISPLAY);

// Horizontal counter
always@(posedge clk_i)
begin
    if(rst_i)
    begin
        hpos_count <= H_SYNC_END;
        hsync_o <= 1'b0;
    end else begin
        hsync_o <= ~(hpos_count >= H_SYNC_START
                    && hpos_count <= H_SYNC_END);
        if(hpos_max)
            hpos_count <= 0;
        else
            hpos_count <= hpos_count + 1'b1;
    end
end

// Vertical counter
always@(posedge clk_i)
begin
    if(rst_i)
    begin
        vpos_count <= V_SYNC_END;
        vsync_o <= 1'b0;
    end else begin
        vsync_o <= ~(vpos_count >= V_SYNC_START
                  && vpos_count <= V_SYNC_END);
        if(hpos_max)
            if(vpos_max)
                vpos_count <= 0;
            else
                vpos_count <= vpos_count + 1'b1;
    end
end

`ifdef FORMAL

reg past_valid;

initial begin
    assume(rst);
    past_valid <= 0;
end

always@(*)
begin
    if(rst == 1'b1)
    begin
        assert(hcount_reg == `H_REG_SIZE'b0);
        assert(vcount_reg == `V_REG_SIZE'b0);
    end

end

`endif

endmodule
