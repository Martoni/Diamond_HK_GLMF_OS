/* (0) */
`timescale 1ns/1ns

//`define DUMPVARS

//`define VGA640X480
`define VGA800X600

/* (1) module sans entrée/sortie */
module RgbVideo_tb;

/* (2) Signaux de connexions */
reg clk_i = 0;
reg rst_i;
wire red_o;
wire green_o;
wire blue_o;
wire vsync_o;
wire hsync_o;

/* (3) Instanciation du top*/
RgbVideo top(
    .clk_i  (clk_i  ),
    .rst_i  (rst_i  ),
    .red_o  (red_o  ),
    .green_o(green_o),
    .blue_o (blue_o ),
    .vsync_o(vsync_o),
    .hsync_o(hsync_o)
);

/* (4) Horloge */
always #1 clk_i <= !clk_i;

/* (5) banc de test principal*/
initial
begin
`ifdef DUMPVARS
    $dumpfile("RgbVideo_tb.vcd");
    $dumpvars(0, top); 
`endif

    $display("%0t, Début de test", $time);
    /* (6) */
    rst_i = 1'b1;
    #5;
    rst_i = 1'b0;
    #2;
    /* (7) */
    while(!vsync_o) #1;
    #1;
    while(vsync_o) #1;
    #2;
    $display("%0t, vsync_o %1d", $time, vsync_o);
    $display("%0t, Fin de test", $time);
    $finish;
end

/* (6) Enregistrement de l'image */
integer fimg;
integer linecount=0;
integer columncount=0;

initial
begin
    /* (7) attente de la sortie du reset */
    @(negedge rst_i) #1;
    $display("Ouverture de l'image");
    fimg = $fopen("/tmp/icarus_img.ppm", "w");

    /* enregistrement de l'entête de l'image */
    $fwrite(fimg, "P3\n");
    $fwrite(fimg, "# icarus_img.ppm\n");
`ifdef VGA640X480
    $fwrite(fimg, "688 494\n");
`endif
`ifdef VGA800X600
    $fwrite(fimg, "914 656\n");
`endif
    $fwrite(fimg, "1\n");

    /* (8) attente de la montée de vsync_o */
    while(vsync_o != 1'b1) #1;

    /* (9) écriture d'une image */
    while(vsync_o == 1'b1)
    begin
        @(posedge clk_i)
        begin
            if(hsync_o)
                begin
                    if(linecount != 0)
                        /* (10) */
                        $fwrite(fimg, "%d %d %d  ", red_o, green_o, blue_o);
                    columncount = columncount + 1;
                end
            else if(columncount != 0)
                begin
                    $fwrite(fimg, "\n");
                    linecount = linecount + 1;
                    $write("line %0d column %0d\15", linecount, columncount);
                    $fflush();
                    columncount = 0;
                end
            end
        end
        $display("");
        $display("Fermeture de l'image");
        $fclose(fimg);
    end

endmodule /* RgbVideo_tb */
