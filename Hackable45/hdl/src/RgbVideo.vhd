-- SimpleVga generator
-- 640 x 480 with 25Mhz clock
-- Widely inspired by fpga4fun :
-- https://www.fpga4fun.com/PongGame.html

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

-- (1)
entity RgbVideo is
    generic(SQWIDTH: natural := 2;
            HWIDTH: natural := 640;
            VWIDTH: natural := 480);
    port(
        -- (2)
        clk_i: in std_logic;
        rst_i: in std_logic;
        -- VGA output
        red_o   : out std_logic;
        green_o : out std_logic;
        blue_o  : out std_logic;
        vsync_o : out std_logic;
        hsync_o : out std_logic);
end entity RgbVideo;

architecture RgbVideo_1 of RgbVideo is

    signal display_on: std_logic;
    signal hpos: std_logic_vector(10 downto 0);
    signal vpos: std_logic_vector(9 downto 0);

    signal square: std_logic;

begin

    -- (3)
    hvsync_conn : entity work.HVSync(HVSync_1)
    port map(
        clk_i      => clk_i,
        rst_i      => rst_i,
        hsync_o    => hsync_o,
        vsync_o    => vsync_o,
        display_on => display_on,
        hpos       => hpos,
        vpos       => vpos);

    -- (4)
    square <= '1' when (
           (unsigned(hpos) <= SQWIDTH)
        or ((unsigned(hpos) <= (HWIDTH - 1)) and
            (unsigned(hpos) >= (HWIDTH - SQWIDTH - 1)))
        or (unsigned(vpos) <= SQWIDTH)
        or ((unsigned(vpos) <= VWIDTH - 1) and
            (unsigned(vpos) >= VWIDTH - SQWIDTH - 1))
    ) else '0';

    -- (5)
    red_o <= '1' when (display_on = '1') and ((hpos(4) = '1') or square = '1') else '0';
    green_o <= '1' when (display_on = '1') and ((hpos(5) = '1') or square = '1') else '0';
    blue_o <= '1' when (display_on = '1') and ((hpos(6) = '1') or square = '1') else '0';

end architecture;
