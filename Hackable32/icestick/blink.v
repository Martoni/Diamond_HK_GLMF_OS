// Author: Fabien Marteau <mail@fabienm.eu
// Creation Date : 14/09/2019
module blink (
    // Horloge
    input clock,
    output led
);

// Icestick clock : 12Mhz
parameter clock_freq = 12_000_000; // clock frequency
localparam MAX_COUNT = clock_freq;
localparam MAX_COUNT_UPPER = $clog2(MAX_COUNT) - 1;

reg [MAX_COUNT_UPPER:0] counter;
reg led_reg;

assign led = led_reg;

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
