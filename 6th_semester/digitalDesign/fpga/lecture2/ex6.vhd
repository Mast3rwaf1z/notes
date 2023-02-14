library ieee;
use ieee.std_logic_1164.all;

entity ex6 is
	port(
		sw0, sw1, sw2, sw3, sw4, sw5, sw6, sw7 : in std_logic;
		led0,	led1,	led2,	led3,	led4 : out std_logic
	);
end ex6;

architecture behavioral of ex6 is

signal c0, c1, c2, c3 : std_logic;


begin
	led0 <= sw0 xor sw4;
	c0 <= sw0 and sw4;
	led1 <= sw1 xor sw5 xor c0;
	c1 <= (sw1 and sw5) or (sw1 and c0) or (sw5 and c0);
	led2 <= sw2 xor sw6 xor c1;
	c2 <= (sw2 and sw6) or (sw2 and c1) or (sw6 and c1);
	led3 <= sw3 xor sw7 xor c2;
	c3 <= (sw3 and sw7) or (sw3 and c2) or (sw7 and c2);
	led4 <= c3;
end behavioral;