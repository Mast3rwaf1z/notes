library ieee;
use ieee.std_logic_1164.all;

entity ex3 is
	port(
		readEnable, writeEnable : in std_logic; --buttons
		sw0, sw1, sw2, sw3 : in std_logic; --switches
		led0, led1, led2, led3 : out std_logic --leds
	);
end ex3;
	
architecture memory of ex3 is
	signal memory : std_logic_vector(3 downto 0);

begin
	process(writeEnable) begin
		if rising_edge(writeEnable) then
			memory(0) <= sw0;
			memory(1) <= sw1;
			memory(2) <= sw2;
			memory(3) <= sw3;
		end if;
	end process;
		
	process(readEnable) begin
		if rising_edge(readEnable) then
			led0 <= memory(0);
			led1 <= memory(1);
			led2 <= memory(2);
			led3 <= memory(3);
		end if;
	end process;
end memory;