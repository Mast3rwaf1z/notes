library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity CPU is
	port (
		clk : in std_logic;
		leds : out std_logic_vector(0 to 7);
		opcode : in std_logic_vector(0 to 7)
	);
end entity CPU;

architecture arch of CPU is
	type memory_t is array(0 to 3) of std_logic_vector(0 to 7);
	signal memory : memory_t;
	signal a : std_logic_vector(0 to 7);
	signal b : std_logic_vector(0 to 7);
	signal carry : std_logic;
	
	begin
		process(clk) is begin
			if rising_edge(clk) then
				a <= memory(to_integer(unsigned(opcode(2 to 3))));
				b <= memory(to_integer(unsigned(opcode(4 to 5))));
				
				if opcode(0 to 1) = "00" then -- add
					carry <= '0';
				
					for i in 0 to 7 loop
						memory(to_integer(unsigned(opcode(6 to 7))))(i) <= (a(i) xor b(i)) xor carry;
						carry <= (a(i) and b(i)) or ((a(i) xor b(i)) and carry);
					end loop;
					
				elsif opcode(0 to 1) = "01" then -- sub
					carry <= '0';
				
					for i in 0 to 7 loop
						memory(to_integer(unsigned(opcode(6 to 7))))(i) <= (a(i) xor b(i)) xor carry;
						carry <= (a(i) and b(i)) or ((a(i) xor b(i)) and carry);
					end loop;
				elsif opcode(0 to 1) = "10" then -- copy
				
					memory(to_integer(unsigned(opcode(6 to 7)))) <= a;
				
				elsif opcode(0 to 1) = "11" then -- incr
					carry <= '1';
				
					for i in 0 to 7 loop
						memory(to_integer(unsigned(opcode(6 to 7))))(i) <= (a(i) xor b(i));
						carry <= a(i) and b(i);
					end loop;
				end if;
				leds <= memory(to_integer(unsigned(opcode(6 to 7))));
			end if;
		end process;
end architecture arch;
					
					
					