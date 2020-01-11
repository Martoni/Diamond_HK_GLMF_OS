// Author: Fabien Marteau <mail@fabienm.eu
// Creation Date : 14/09/2019
module blink (
    // Horloge
    input clock,
	input PLL_LOCKED,
	output PLL_RSTN,
    output led
);

// FireAnt
parameter clock_freq = 33_333_333; // clock_x
localparam MAX_COUNT = clock_freq;
localparam MAX_COUNT_UPPER = $clog2(MAX_COUNT);

reg [MAX_COUNT_UPPER:0] counter;
reg led_reg;


assign led = led_reg;
assign PLL_RSTN = 1'b1;

always@(posedge clock)
begin
    if(counter < MAX_COUNT/2)
        led_reg <= 1;
    else
        led_reg <= 0;

    if(counter >= MAX_COUNT)
        counter <= 0;
    else
        counter <= counter + 1;
end

endmodule
