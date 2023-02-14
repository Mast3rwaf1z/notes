library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ex4_xor is
	Port(
		sw0 : in STD_LOGIC; 
		sw1 : in STD_LOGIC;
		led0 : out STD_LOGIC);
end ex4_xor;

architecture behavioral of ex4_xor is

begin
	led0 <= sw0 xor sw1;
end behavioral;