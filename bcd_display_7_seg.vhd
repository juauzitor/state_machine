library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bcd_display_7_seg is
    Port (
        Q : in std_logic_vector(1 downto 0);
        seg: out std_logic_vector(6 downto 0)
    );
end bcd_display_7_seg;

architecture Behavioral of bcd_display_7_seg is
begin    
    with Q select
    seg <=  "1000000" when "00", -- 0
            "1111001" when "01", -- 1
            "0100100" when "10", -- 2
            "0110000" when "11", -- 3
            "1111111" when others; -- Apagado
	 
end Behavioral;