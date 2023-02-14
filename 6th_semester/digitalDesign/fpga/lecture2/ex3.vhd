library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ex3 is
	port(
		sw0 : in STD_LOGIC;
		sw1 : in STD_LOGIC;
		led0 : out STD_LOGIC);
end ex3;
	
architecture behavioral of ex3 is

begin
	led0 <= sw0 and sw1;
end behavioral;