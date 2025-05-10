library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity state_machine is
    port (
        sys_clk : in  std_logic;  -- Clock do sistema (50 MHz)
        rst     : in  std_logic;  -- Reset (ativo alto)
        X       : in  std_logic;  -- Entrada da máquina de estados
		  blink_led: out std_logic;
		  seg: out std_logic_vector(6 downto 0)
    );
end state_machine;

architecture Structural of state_machine is
    component clock_divider is
        port (
            sys_clk  : in  std_logic;
            rst      : in  std_logic;
            slow_clk : out std_logic;
				blink_led: out std_logic
        );
    end component;

    component grey_counter is
        port (
            clk     : in  std_logic;
            rst     : in  std_logic;
            X       : in  std_logic;
            Q       : out std_logic_vector(1 downto 0)
        );
    end component;
	 
	 component bcd_display_7_seg is
			port(
				Q : in std_logic_vector(1 downto 0);
				seg : out std_logic_vector(6 downto 0)
			);
	end component;
	
    signal slow_clock: std_logic;  -- Clock de 1 Hz
	 signal Q: std_logic_vector(1 downto 0);  -- Saída da máquina de estados
begin
    -- Instância do Clock Divider
    clock_div: clock_divider
        port map (
            sys_clk  => sys_clk,
            rst      => rst,
            slow_clk => slow_clock,
				blink_led => blink_led
        );

    -- Instância da Máquina de Estados
    sm: grey_counter
        port map (
            clk => slow_clock,
            rst => rst,
            X   => X,
				Q   => Q
        );
	
	display: bcd_display_7_seg
			port map (
				Q => Q,
				seg => seg
			);
end Structural;