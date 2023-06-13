library ieee;
use ieee.std_logic_1164.all;

entity ex4 is
    port(
        a : in std_logic;
        b : in std_logic;
        clk : in std_logic;
		  light: out std_logic_vector(0 to 2)
    );
end entity ex4;

architecture arch of ex4 is
	type state_type is (entering, exiting, idle, finishing);
	signal state : state_type := idle;
	signal sensors : std_logic_vector(0 to 1);
begin
    process(clk) is begin
        if rising_edge(clk) then
				sensors <= not a & not b;
            case state is
                when idle =>
                    light(0) <= '0';
						  light(1) <= '0';

                    if sensors = "10" then
                        state <= entering;
                    elsif sensors = "01" then
                        state <= exiting;
                    end if;
                when entering =>
                    light(0) <= '1';
                    if sensors = "01" then
                        state <= finishing;
                    end if;
                when exiting =>
                    light(1) <= '1';
                    if sensors = "10" then
                        state <= finishing;
                    end if;
                when finishing =>
                    if sensors = "00" then
                        state <= idle;
                    end if;
            end case;
			end if;
		end process;
end architecture arch;