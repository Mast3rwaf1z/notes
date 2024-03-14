library ieee;
use ieee.std_logic_1164.all;

entity ex2 is
	port(
		leds : out std_logic_vector(3 downto 0);
		sw0 : in std_logic;
		btn0 : in std_logic
	);
end ex2;
	
architecture my_register of ex2 is
	signal output : std_logic_vector(3 downto 0);

begin

	process (btn0) begin
		if rising_edge(btn0) then
			output(3) <= output(2);
			output(2) <= output(1);
			output(1) <= output(0);
			output(0) <= sw0;
		end if;
	end process;
	
	leds <= output;
end my_register;