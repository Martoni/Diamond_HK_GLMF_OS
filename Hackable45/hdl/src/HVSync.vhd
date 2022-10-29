-- Horizontal, vertical VGA signals generation
--for 640 x 480 VGA
--inspired from fpga4fun
--and Stephen Hugg book "Designing Video Game Hardware in Verilog"

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity HVSync is
    port(
        clk_i: in std_logic;
        rst_i: in std_logic;
        hsync_o    : out std_logic;
        vsync_o    : out std_logic;
        display_on : out std_logic;
        hpos       : out std_logic_vector(10 downto 0);
        vpos       : out std_logic_vector(9 downto 0));
end entity HVSync;

architecture HVSync_1 of HVSync is
    
    constant H_DISPLAY: natural := 640;  -- horizontal display width
    constant H_FRONT: natural := 8;     -- front porch
    constant H_SYNC: natural := 96;     -- sync width
    constant H_BACK: natural := 40;      -- back porch

    constant V_SYNC: natural := 4;       -- sync width
    constant V_TOP: natural := 4;       -- top border
    constant V_DISPLAY: natural := 480;  -- vertical display width
    constant V_BOTTOM: natural := 14;    -- bottom border

    constant H_SYNC_START: natural := H_DISPLAY + H_FRONT;
    constant H_SYNC_END: natural := H_DISPLAY + H_FRONT + H_SYNC - 1;
    constant H_MAX: natural := H_DISPLAY + H_BACK + H_FRONT + H_SYNC - 1;

    constant V_SYNC_START: natural := V_DISPLAY + V_BOTTOM;
    constant V_SYNC_END: natural := V_DISPLAY + V_BOTTOM + V_SYNC - 1;
    constant V_MAX: natural := V_DISPLAY + V_TOP + V_BOTTOM + V_SYNC - 1;

    signal hpos_count: natural range 0 to (2**11)-1;
    signal vpos_count: natural range 0 to (2**10)-1;

    signal hpos_max: std_logic;
    signal vpos_max: std_logic;

begin

    hpos <= std_logic_vector(to_unsigned(hpos_count, 11));
    vpos <= std_logic_vector(to_unsigned(vpos_count, 10));

    hpos_max <= '1' when hpos_count = H_MAX else '0';
    vpos_max <= '1' when vpos_count = V_MAX else '0';

    display_on <= '1' when (hpos_count < H_DISPLAY) and (vpos_count < V_DISPLAY)
                                else '0';

    -- Horizontal counter
    process(clk_i, rst_i)
    begin
        if (rst_i = '1') then
            hpos_count <= H_SYNC_END;
            hsync_o <= '0';
        elsif(rising_edge(clk_i)) then
            if (hpos_count >= H_SYNC_START) and (hpos_count <= H_SYNC_END) then
                hsync_o <= '0';
            else
                hsync_o <= '1';
            end if;
            if(hpos_max = '1') then
                hpos_count <= 0;
            else
                hpos_count <= hpos_count + 1;
            end if;
        end if;
    end process;

    -- vertical counter
    process(clk_i, rst_i)
    begin
        if(rst_i = '1') then
            vpos_count <= V_SYNC_END;
            vsync_o <= '0';
        elsif(rising_edge(clk_i)) then
            if((vpos_count >= V_SYNC_START) and (vpos_count <= V_SYNC_END)) then
                vsync_o <= '0';
            else
                vsync_o <= '1';
            end if;

            if(hpos_max = '1') then
                if(vpos_max = '1') then
                    vpos_count <= 0;
                else
                    vpos_count <= vpos_count + 1;
                end if;
            end if;
        end if; 
    end process;

end architecture;
