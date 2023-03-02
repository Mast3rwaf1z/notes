library ieee;
use ieee.std_logic_1164.all;

entity ex3 is
	port (
		clk : in std_logic;
		light : out std_logic_vector(0 to 2); -- 0: red, 1: yellow, 2: green
		led0 : out std_logic
	);
end entity ex3;

architecture rtl of ex3 is
	type state_type is (r, g, ry, y);
	signal state : state_type := r;
	signal counter : integer := 1;
	signal timer : std_logic := '0';
	constant frequency : integer := 50000000; -- Hz (cycles/second)
begin
    
	process(clk) is begin
		if rising_edge(clk) then
			if counter = frequency*2 then
				timer <= not timer;
				counter <= 0;
			else
				counter <= counter + 1;
			end if;
		end if;
	end process;

	process(timer) is begin
		if rising_edge(timer) then
			case state is
				when r =>
					light <= "110";
					state <= ry;
				when ry =>
					light <= "001";
					state <= g;
				when g =>
					light <= "010";
					state <= y;
				when y =>
					light <= "100";
					state <= r;
			end case;
		end if;
	end process;
	
	led0 <= timer;
end architecture rtl;