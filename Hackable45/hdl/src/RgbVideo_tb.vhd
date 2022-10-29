library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- (1)
use std.textio.all;
use std.env.finish;

-- (2)
entity RgbVideo_tb is
end RgbVideo_tb;

architecture simu of RgbVideo_tb is
    constant CLK_PER: time := 2 ns;

    signal clk_s  : std_logic;  
    signal rst_s  : std_logic;
    signal red_s  : std_logic;
    signal green_s: std_logic;
    signal blue_s : std_logic;
    signal vsync_s: std_logic;
    signal hsync_s: std_logic;

begin

    -- (3) Horloge
    clock_p : process
    begin
        clk_s <= '0';
        wait for CLK_PER/2;
        clk_s <= '1';
        wait for CLK_PER/2;
    end process clock_p;

    -- (4) Instanciation du module vidéo
    dut : entity work.RgbVideo(RgbVideo_1)
    port map (
        clk_i  => clk_s, 
        rst_i  => rst_s, 
        red_o  => red_s, 
        green_o=> green_s, 
        blue_o => blue_s, 
        vsync_o=> vsync_s, 
        hsync_o=> hsync_s);

    -- (5) banc de test principal
    tb_p : process
    begin
        -- Reset
        rst_s <= '1';
        wait for 5*CLK_PER/2;
        rst_s <= '0';
        wait for CLK_PER;
        
        wait until falling_edge(vsync_s);
        wait for CLK_PER/2;
        wait until rising_edge(vsync_s);
        wait for CLK_PER;
        finish; -- (6) 
    end process tb_p;

    -- (7) Enregistrement de l'image
    record_img_p : process
        file file_handler : text open write_mode is "/tmp/ghdl_img.ppm";
        variable row : line;
        variable v_data_write : integer;
        variable linecount : integer := 0;
        variable columncount : integer := 0;
        -- (8) Entête de l'image
        constant ppm_head_format : string := "P3";
        constant ppm_head_filename: string := "# ghdl_img.ppm";
        constant ppm_head_dim : string := "688 494";
        constant ppm_head_max : string := "1";
        variable red_str :   string(2 downto 1);
        variable green_str : string(2 downto 1);
        variable blue_str :  string(2 downto 1);
    begin
        report "Test begin" severity Note;
        -- (9) écriture de l'entête
        write(row, ppm_head_format, right, ppm_head_format'length);
        writeline(file_handler, row);
        write(row, ppm_head_filename, right, ppm_head_filename'length);
        writeline(file_handler, row);
        write(row, ppm_head_dim, right, ppm_head_dim'length);
        writeline(file_handler, row);
        write(row, ppm_head_max, right, ppm_head_max'length);
        writeline(file_handler, row);

        -- écriture d'une image
        wait until rising_edge(vsync_s);

        report "Write image" severity Note;
        while vsync_s = '1' loop
            wait until rising_edge(clk_s);
            if hsync_s = '1' then
                -- (10)
                if linecount /= 0 then
                    red_str := "1 " when red_s = '1' else "0 ";
                    green_str := "1 " when green_s = '1' else "0 ";
                    blue_str := "1 " when blue_s = '1' else "0 ";
                    write(row, red_str, right, 2);
                    write(row, green_str, right, 2);
                    write(row, blue_str, right, 2);
                    writeline(file_handler, row);
                end if;
                columncount := columncount + 1;
            elsif columncount /= 0 then
                linecount := linecount + 1;
                report "line " & integer'image(linecount)
                               & " column "
                               & integer'image(columncount)
                    severity Note;
                columncount := 0;
            end if;
        end loop;
        finish;
    end process record_img_p;


end architecture;
