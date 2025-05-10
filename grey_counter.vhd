library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity grey_counter is
    Port (
        clk : in std_logic;
        rst : in std_logic;
        X : in std_logic;
        Q : out std_logic_vector(1 downto 0)
    );
end grey_counter;

architecture Behavioral of grey_counter is
    type state_type is (Q0, Q1, Q2, Q3);
    signal current_state, next_state : state_type;
	 signal test: std_logic;
begin
    process(clk, rst)
    begin
        if rst = '0' then
            current_state <= Q0;
        elsif rising_edge(clk) then
            current_state <= next_state;
        end if;
    end process;

    process(current_state, X)
    begin
        case current_state is
            when Q0 => 
                if X = '1' then
                    next_state <= Q1;
                else
                    next_state <= Q2;
                end if;
            when Q1 => 
                if X = '1' then
                    next_state <= Q3;
                else
                    next_state <= Q0;
                end if;
            when Q2 => 
                if X = '1' then
                    next_state <= Q0;
                else
                    next_state <= Q3;
                end if;
            when Q3 => 
                if X = '1' then
                    next_state <= Q2;
                else
                    next_state <= Q1;
                end if;
            when others => 
                next_state <= Q0;
        end case;
    end process;
	 
	 with current_state select
    Q <= "00" when Q0,
          "01" when Q1,
          "10" when Q2,
          "11" when Q3,
          "00" when others;
end Behavioral;