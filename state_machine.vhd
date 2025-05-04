-- Arquivo: gray_counter.vhd
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity state_machine is
    Port (
        clk : in std_logic;
        rst : in std_logic;
        X : in std_logic;
        Q : out std_logic_vector(1 downto 0)
    );
end state_machine;

architecture Behavioral of state_machine is
    type state_type is (S0, S1, S2, S3); -- Definição dos estados [[2]]
    signal current_state, next_state : state_type;
begin

    -- Processo de registro de estado (sequencial)
    process(clk, rst)
    begin
        if rst = '1' then
            current_state <= S0;
        elsif rising_edge(clk) then
            current_state <= next_state;
        end if;
    end process;

    -- Lógica de próximo estado (combinacional)
    process(current_state, X)
    begin
        case current_state is
            when S0 => 
                if X = '1' then
                    next_state <= S1;
                else
                    next_state <= S3;
                end if;
            when S1 => 
                if X = '1' then
                    next_state <= S2;
                else
                    next_state <= S0;
                end if;
            when S2 => 
                if X = '1' then
                    next_state <= S3;
                else
                    next_state <= S1;
                end if;
            when S3 => 
                if X = '1' then
                    next_state <= S0;
                else
                    next_state <= S2;
                end if;
            when others => 
                next_state <= S0;
        end case;
    end process;

    -- Lógica de saída (combinacional - Máquina de Moore)
    process(current_state)
    begin
        case current_state is
            when S0 => Q <= "00"; -- Código Gray para 0 [[7]]
            when S1 => Q <= "01"; -- Código Gray para 1
            when S2 => Q <= "11"; -- Código Gray para 2
            when S3 => Q <= "10"; -- Código Gray para 3
            when others => Q <= "00";
        end case;
    end process;

end Behavioral;