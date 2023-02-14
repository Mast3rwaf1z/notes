library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ex5 is
	Port(
		sw0 : in STD_LOGIC; 
		sw1 : in STD_LOGIC;
		led0 : out STD_LOGIC;
		led1 : out STD_LOGIC);
end ex5;

architecture behavioral of ex5 is

begin
	led0 <= sw0 xor sw1;
	led1 <= sw0 and sw1;
end behavioral;