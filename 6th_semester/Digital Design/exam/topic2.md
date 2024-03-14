# Topic 2

## Ex1

```vhdl
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity ex1 is
	Port(
        sws : in std_logic_vector(0 to 3);
        leds : out std_logic_vector(0 to 3));
end ex1;

architecture Behavioral of ex1 is

begin
    leds <= not sws;
end behavioral;
```

## Ex2

```vhdl
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
```

## Ex3

```vhdl
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ex3 is
	port(
		sw0 : in STD_LOGIC;
		sw1 : in STD_LOGIC;
		led0 : out STD_LOGIC);
end ex3;
	
architecture behavioral of ex3 is

begin
	led0 <= sw0 and sw1;
end behavioral;
```

