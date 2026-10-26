library ieee;
use ieee.std_logic_1164.all;

entity HEX_TO_7SEG is
port(
	i_Hex: in std_logic_vector(3 downto 0);
	o_Seg: out std_logic_vector(6 downto 0)
);
end entity HEX_TO_7SEG;

architecture RTL of HEX_TO_7SEG is

begin
	process(i_Hex)
	begin
		case i_Hex is
            when x"0" => 
					o_Seg <= "1000000"; -- 40
            when x"1" => 
					o_Seg <= "1111001"; -- 79
            when x"2" => 
					o_Seg <= "0100100"; -- 24
            when x"3" => 
					o_Seg <= "0110000"; -- 30
            when x"4" => 
					o_Seg <= "0011001"; -- 19
            when x"5" => 
					o_Seg <= "0010010"; -- 12
            when x"6" => 
					o_Seg <= "0000010"; -- 02
            when x"7" => 
					o_Seg <= "1111000"; -- 78
            when x"8" => 
					o_Seg <= "0000000"; -- 00
            when x"9" => 
					o_Seg <= "0010000"; -- 10
            when x"A" => 
					o_Seg <= "0001000"; -- 08
            when x"B" => 
					o_Seg <= "0000011"; -- 03
            when x"C" => 
					o_Seg <= "1000110"; -- 46
            when x"D" => 
					o_Seg <= "0100001"; -- 21
            when x"E" => 
					o_Seg <= "0000110"; -- 06
            when x"F" => o_Seg <= "0001110"; -- 0E
            when others => 
					o_Seg <= "1111111"; -- Todo apagado
        end case;
	end process;

end architecture RTL;