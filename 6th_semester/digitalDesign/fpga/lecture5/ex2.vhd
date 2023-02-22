library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity ex2 is
	port(
		led0, led1, led2, led3, led4, led5, led6, led7 : out std_logic;
		clk : in std_logic
		
	);
end ex2;


architecture counter of ex2 is
	signal cnt0 : integer;
	signal memory : std_logic_vector(23 downto 0);

begin
	process(clk) begin
		if rising_edge(clk) then
			cnt0 <= cnt0 + 1;
		end if;
	end process;
	
	memory <= std_logic_vector(to_signed(cnt0, memory'length));
	
	led0 <= memory(24-8);
	led1 <= memory(24-7);
	led2 <= memory(24-6);
	led3 <= memory(24-5);
	led4 <= memory(24-4);
	led5 <= memory(24-3);
	led6 <= memory(24-2);
	led7 <= memory(24-1);
	
end counter;