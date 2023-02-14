library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ex4_or is
	Port(
		sw0 : in STD_LOGIC; 
		sw1 : in STD_LOGIC;
		led0 : out STD_LOGIC);
end ex4_or;

architecture behavioral of ex4_or is

begin
	led0 <= sw0 or sw1;
end behavioral;