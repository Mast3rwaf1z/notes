library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity segments is
	port(
		digit0 : out std_logic_vector(0 to 6);
		digit1 : out std_logic_vector(0 to 6);
		digit2 : out std_logic_vector(0 to 6);
		digit3 : out std_logic_vector(0 to 6);
		digit4 : out std_logic_vector(0 to 6);
		digit5 : out std_logic_vector(0 to 6);
		clk : in std_logic;
		ctrl : inout std_logic
	);
end segments;

architecture arch of segments is 
	signal counter : std_logic_vector(0 to 23);
	signal carry : std_logic := '0';
	signal temp : std_logic := '0';
	type segment_t is array(0 to 5) of std_logic_vector(6 downto 0);
	signal segments : segment_t;
begin
	process(clk) is begin
		if falling_edge(clk) then
			if counter = "111111111111111111111111" then
				counter <= "000000000000000000000000";
			end if;
			
			counter <= std_logic_vector(unsigned(counter) + 1);
			
			for i in 0 to 5 loop
				case counter(i*4 to (i*4) + 3) is
					when "0000" => segments(i) <= "0000001"; -- 0
					when "0001" => segments(i) <= "1001111"; -- 1
					when "0010" => segments(i) <= "0010010"; -- 2
					when "0011" => segments(i) <= "0000110"; -- 3
					when "0100" => segments(i) <= "1001100"; -- 4
					when "0101" => segments(i) <= "0100100"; -- 5
					when "0110" => segments(i) <= "0100000"; -- 6
					when "0111" => segments(i) <= "0001111"; -- 7
					when "1000" => segments(i) <= "0000000"; -- 8
					when "1001" => segments(i) <= "0000100"; -- 9
					when "1010" => segments(i) <= "0001000"; -- A
					when "1011" => segments(i) <= "1100000"; -- B
					when "1100" => segments(i) <= "0110001"; -- C
					when "1101" => segments(i) <= "1000010"; -- D
					when "1110" => segments(i) <= "0110000"; -- E
					when "1111" => segments(i) <= "0111000"; -- F
				end case;
			end loop;
				
			digit0 <= segments(5);
			digit1 <= segments(4);
			digit2 <= segments(3);
			digit3 <= segments(2);
			digit4 <= segments(1);
			digit5 <= segments(0);
			
		end if;
	end process;
	
	ctrl <= not clk;
	
end architecture arch;