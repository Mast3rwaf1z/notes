library ieee;
use ieee.std_logic_1164.all;

entity ex2 is
	port(
		led0, led1, led2, led3 : out std_logic;
		sw0 : in std_logic;
		btn0 : in std_logic
	);
end ex2;
	
architecture my_register of ex2 is
	signal out_A, out_B, out_C, out_D : std_logic;

begin

	process (btn0) begin
		if rising_edge(btn0) then
			out_D <= out_C;
			out_C <= out_B;
			out_B <= out_A;
			out_A <= sw0;
		end if;
	end process;
	
	
	led0 <= out_A;
	led1 <= out_B;
	led2 <= out_C;
	led3 <= out_D;
	
	

end my_register;