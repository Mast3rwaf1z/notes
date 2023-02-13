library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- dårligt sprog
entity ex1 is
	Port(
		sw0 : in STD_LOGIC; 
		sw1 : in STD_LOGIC;
		sw2 : in STD_LOGIC; 
		sw3 : in STD_LOGIC;
		led0 : out STD_LOGIC;
		led1 : out STD_LOGIC;
		led2 : out STD_LOGIC;
		led3 : out STD_LOGIC);
end ex1;

architecture Behavioral of ex1 is

begin
	led0 <= NOT sw0;
	led1 <= NOT sw1;
	led2 <= NOT sw2;
	led3 <= NOT sw3;
end behavioral;