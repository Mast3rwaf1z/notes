# Topic 4

## Ex2

```vhdl
library ieee;
use ieee.std_logic_1164.all;

entity ex2 is
	port(
		leds : out std_logic_vector(3 downto 0);
		sw0 : in std_logic;
		btn0 : in std_logic
	);
end ex2;
	
architecture my_register of ex2 is
	signal output : std_logic_vector(3 downto 0);

begin

	process (btn0) begin
		if rising_edge(btn0) then
			output(3) <= output(2);
			output(2) <= output(1);
			output(1) <= output(0);
			output(0) <= sw0;
		end if;
	end process;
	
	leds <= output;
end my_register;
```

## Ex3

```Vhdl
library ieee;
use ieee.std_logic_1164.all;

entity ex3 is
	port(
		readEnable, writeEnable : in std_logic; --buttons
		sw0, sw1, sw2, sw3 : in std_logic; --switches
		led0, led1, led2, led3 : out std_logic --leds
	);
end ex3;
	
architecture memory of ex3 is
	signal memory : std_logic_vector(3 downto 0);

begin
	process(writeEnable) begin
		if rising_edge(writeEnable) then
			memory(0) <= sw0;
			memory(1) <= sw1;
			memory(2) <= sw2;
			memory(3) <= sw3;
		end if;
	end process;
		
	process(readEnable) begin
		if rising_edge(readEnable) then
			led0 <= memory(0);
			led1 <= memory(1);
			led2 <= memory(2);
			led3 <= memory(3);
		end if;
	end process;
end memory;
```

## Ex4

The memory block can be extended using a few multiplexers and using addresses

<img src="/home/mast3r/git/notes/6th_semester/digitalDesign/exam/t4e4.jpg">

