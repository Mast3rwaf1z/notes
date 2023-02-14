LiBRARY IEEE;
use IEEE.STD_LOGIC_1164.ALL;

EnTITY ex2 Is
	PoRT(
		sw0 : In STD_LOGIC; 
		sw1 : In STD_LOGIC;
		sw2 : In STD_LOGIC; 
		sw3 : In STD_LOGIC;
		led0 : OuT STD_LOGIC
	);
EnD ex2;

ArCHITECTURE Behavioral Of ex2 Is

BeGIN
	led0 <= (sw0 and sw1) or not (sw2 and sw3);
EnD behavioral;