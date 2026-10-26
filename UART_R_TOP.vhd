library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity UART_R_TOP is
port(
	i_clk: in  std_logic;
	UART_RX_PIN: in std_logic;
	HEX0: out std_logic_vector(6 downto 0); 
   HEX1: out std_logic_vector(6 downto 0)
	);
end entity UART_R_TOP;

architecture RTL of UART_R_TOP is

signal w_RX_DV: std_logic;
signal w_RX_Byte: std_logic_vector (7 downto 0);
signal r_latched_data : std_logic_vector(7 downto 0) := (others => '0');

begin

UART_RX_Inst : entity work.UART_R
	port map(
	i_clk => i_clk,
	i_RX_serial => UART_RX_PIN,
	o_RX_DV => w_RX_DV,
	o_RX_Byte => w_RX_Byte
	);
	
Data_latch: process(i_clk)
begin
	if rising_edge(i_clk) then
		if(w_RX_DV = '1') then
			r_latched_data <= w_RX_Byte;
		end if;
	end if;
end process;

Hex_Decoder_0 : entity work.HEX_TO_7SEG
	port map (
        i_Hex => r_Latched_Data(3 downto 0),
        o_Seg => HEX0
    );

Hex_Decoder_1 : entity work.HEX_TO_7SEG
	port map (
        i_Hex => r_Latched_Data(7 downto 4),
        o_Seg => HEX1
    );

end architecture RTL;