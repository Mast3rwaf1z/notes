library ieee;
use ieee.std_logic_1164.all;

entity segments is
	port(
		digit0 : out std_logic_vector(0 to 6);
		digit1 : out std_logic_vector(0 to 6);
		digit2 : out std_logic_vector(0 to 6);
		digit3 : out std_logic_vector(0 to 6);
		digit4 : out std_logic_vector(0 to 6);
		digit5 : out std_logic_vector(0 to 6);
		clk : in std_logic
	);
end segments;

architecture arch of segments is 
	signal counter : std_logic_vector(0 to 23);
	signal carry : std_logic := '0';
	signal temp : std_logic := '0';
	signal b0, b1, b2, b3 : std_logic;
	signal segment : std_logic_vector(6 downto 0);
begin
	process(clk) is begin
		if rising_edge(clk) then
			if counter = "111111111111111111111111" then
				counter <= "000000000000000000000000";
			end if;
			carry <= '1';
			for i in 0 to 23 loop
				temp <= counter(i) and carry;
				counter(i) <= counter(i) xor carry;
				carry <= temp;
			end loop;
			for i in 0 to 5 loop
				b0 <= counter(i*4);
				b1 <= counter((i*4)+1);
				b2 <= counter((i*4)+2);
				b3 <= counter((i*4)+3);
			
				segment(0) <= b0 or b2 or (b1 and b3) or (not b1 and not b3);
				segment(1) <= (not b1) or (not b2 and not b3) or (b2 and b3);
				segment(2) <= b1 or not b2 or b3;
				segment(3) <= (not b1 and not b3) or (b2 and not b3) or (b1 and not b2 and b3) or (not b1 and b2) or b0;
				segment(4) <= (not b1 and not b3) or (b2 and not b3);
				segment(5) <= b0 or (not b2 and not b3) or (b1 and not b2) or (b1 and not b3);
				segment(6) <= b0 or (b1 and not b2) or (not b1 and b2) or (b2 and not b3);
				
				case i is
					when 0 => digit0 <= segment;
					when 1 => digit1 <= segment;
					when 2 => digit2 <= segment;
					when 3 => digit3 <= segment;
					when 4 => digit4 <= segment;
					when 5 => digit5 <= segment;
				end case;
			end loop;
		end if;
	end process;
	
end architecture arch;