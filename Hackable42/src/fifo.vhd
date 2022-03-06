library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity fifo is
generic(FIFO_SIZE: natural := 3;
        DATA_SIZE: natural := 8);
port(
    clk : in std_logic;
    rst : in std_logic;
    s_data_i : in std_logic_vector(DATA_SIZE-1 downto 0);
    s_valid_i : in std_logic;
    s_ready_o : out std_logic;

    empty_o : out std_logic;

    m_data_o : out std_logic_vector(DATA_SIZE-1 downto 0);
    m_valid_o : out std_logic;
    m_ready_i : in std_logic;

    full_o : out std_logic
);
end entity fifo;

architecture fifo_1 of fifo is

    type t_circbuf_array is array(natural range 0 to (2**FIFO_SIZE)-1)
        of std_logic_vector(DATA_SIZE-1 downto 0);
    signal circbuf : t_circbuf_array;

    signal wr_fifo : natural range 0 to (2**FIFO_SIZE)-1;
    signal rd_fifo : natural range 0 to (2**FIFO_SIZE)-1;

begin

    -- pointer incrementation management
    process(clk, rst)
    begin
        if(rst) then
            wr_fifo <= 0;
            rd_fifo <= 0;
        elsif(rising_edge(clk)) then
            if(s_valid_i and s_ready_o) then
                circbuf(wr_fifo) <= s_data_i;
                wr_fifo <= wr_fifo + 1;
            end if;
            if(m_ready_i and m_valid_o) then
                m_data_o <= circbuf(rd_fifo);
                rd_fifo <= rd_fifo + 1;
            end if;
        end if;
    end process;

    full_o  <= '1' when (wr_fifo = rd_fifo - 1) or
               ((wr_fifo = 2**FIFO_SIZE-1) and (rd_fifo = 0)) else '0';
    empty_o <= '1' when (rd_fifo = wr_fifo) else '0';

    s_ready_o <= '1' when (not full_o) else '0';
    m_valid_o <= '1' when (not empty_o) else '0';

end architecture fifo_1;
