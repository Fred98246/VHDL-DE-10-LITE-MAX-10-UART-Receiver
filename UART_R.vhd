library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity UART_R is
port(
	i_clk: in std_logic;
	i_RX_serial:in std_logic;
	o_RX_DV: out std_logic;
	o_RX_Byte: out std_logic_vector(7 downto 0)
);
end entity UART_R;

architecture RTL of UART_R is

type t_SM_Main is (S_RX_Idle, S_RX_Start_bit, S_RX_Data_bit, S_RX_Stop_bit, S_RX_Cleanup);

constant g_clks_per_bit : integer := 434;
signal r_SM_Main: t_SM_Main := S_RX_Idle;
signal r_clk_count: integer range 0 to g_clks_per_bit-1 := 0;
signal r_bit_index: integer range 0 to 7 := 0;
signal r_RX_Byte: std_logic_vector(7 downto 0):= (others => '0');
signal r_RX_DV: std_logic := '0';

begin

UART_RX: process(i_clk)
begin
	if rising_edge (i_clk) then
	
		case r_SM_Main is
		
			when S_RX_Idle =>
				r_RX_DV <='0';
				r_clk_count <= 0;
				r_bit_index <= 0;
				
				if(i_RX_Serial = '0') then
					r_SM_Main <= S_RX_Start_bit;
				else 
					r_SM_Main <= S_RX_Idle;
				end if;
			
			when S_RX_Start_bit =>
				if(r_clk_count = (g_clks_per_bit-1)/2) then
					if(i_RX_Serial = '0') then
						r_clk_count <=0;
						r_SM_Main <= S_RX_Data_bit;
					else
						r_SM_Main <= S_RX_Idle;
				end if;
				else
					r_clk_count <= r_clk_count + 1;
					r_SM_Main <= S_RX_Start_bit;
				end if;
					
			when S_RX_Data_bit =>
			
			if (r_clk_count < g_clks_per_bit-1) then
				r_clk_count <= r_clk_count + 1;
				r_SM_Main <= S_RX_Data_bit;
			else 
				r_clk_count<=0;
				r_RX_Byte(r_bit_index) <= i_RX_serial;
				if(r_bit_index<7) then
					r_bit_index <= r_bit_index + 1;
					r_SM_Main <= S_RX_Data_bit;
				else
					r_bit_index <= 0;
					r_SM_Main <= S_RX_Stop_bit;
				end if;
			end if;
			
			when S_RX_Stop_bit =>
				if(r_clk_count < g_clks_per_bit-1) then
					r_clk_count <= r_clk_count + 1;
					r_SM_Main <= S_RX_Stop_bit;
				else 
					r_clk_count <= 0;
					r_RX_DV <= '1';
					r_SM_Main <= S_RX_Cleanup;
				end if;
			
			when S_RX_Cleanup =>
				r_SM_Main <= S_RX_Idle;
				r_RX_DV <= '0';
				
			
			when others =>
				r_SM_Main <= S_RX_Idle;
				
		end case;
	end if;
end process;
			
	o_RX_DV <= r_RX_DV;
	o_RX_Byte <= r_RX_Byte;
	
end architecture RTL;