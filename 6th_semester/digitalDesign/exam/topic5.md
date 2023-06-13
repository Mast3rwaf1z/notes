# Topic 5

## Ex2

```vhdl
library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity ex2 is
	port(
		leds : out std_logic_vector(0 to 7);
		clk : in std_logic
		
	);
end ex2;


architecture counter of ex2 is
	signal cnt0 : integer;
	signal memory : std_logic_vector(23 downto 0);

begin
	process(clk) begin
		if rising_edge(clk) then
			cnt0 <= cnt0 + 1;
		end if;
	end process;
	
	memory <= std_logic_vector(to_signed(cnt0, memory'length));

    leds <= memory(24-8 to 24-1);
	
end counter;
```

## Ex3

```vhdl
library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity ex3 is
	port(
		led0, led1, led2, led3, led4, led5 : out std_logic;
		btn0 : in std_logic;
		clk : in std_logic
		
	);
end ex3;


architecture counter of ex3 is
	signal cnt0 : integer := 0;
	signal memory : std_logic_vector(5 downto 0);

begin
	process(btn0) begin
		if rising_edge(btn0) then
			if cnt0 = 59 then
				cnt0 <= 0;
			else
				cnt0 <= cnt0 + 1;
			end if;
		end if;
	end process;
	
	memory <= std_logic_vector(to_signed(cnt0, memory'length));
	
	led0 <= memory(0);
	led1 <= memory(1);
	led2 <= memory(2);
	led3 <= memory(3);
	led4 <= memory(4);
	led5 <= memory(5);
	
end counter;
```

