# Topic 7

## Ex3

```vhdl
library ieee;
use ieee.std_logic_1164.all;

entity ex3 is
	port (
		clk : in std_logic;
		light : out std_logic_vector(0 to 2); -- 0: red, 1: yellow, 2: green
		led0 : out std_logic
	);
end entity ex3;

architecture rtl of ex3 is
	type state_type is (r, g, ry, y);
	signal state : state_type := r;
	signal counter : integer := 1;
	signal timer : std_logic := '0';
	constant frequency : integer := 50000000; -- Hz (cycles/second)
begin
    
	process(clk) is begin
		if rising_edge(clk) then
			if counter = frequency*2 then
				timer <= not timer;
				counter <= 0;
			else
				counter <= counter + 1;
			end if;
		end if;
	end process;

	process(timer) is begin
		if rising_edge(timer) then
			case state is
				when r =>
					light <= "110";
					state <= ry;
				when ry =>
					light <= "001";
					state <= g;
				when g =>
					light <= "010";
					state <= y;
				when y =>
					light <= "100";
					state <= r;
			end case;
		end if;
	end process;
	
	led0 <= timer;
end architecture rtl;
```

## Ex4

### 1

<img src="/home/mast3r/git/notes/6th_semester/digitalDesign/exam/t7e4.jpg">

### 2

```vhdl
entity ex42 is
    port(
        a : in std_logic;
        b : in std_logic;
        enter : out std_logic;
        exit : out std_logic;
        clk : in std_logic
    );
end entity ex42;

architecture arch of ex42 is
    signal state : (entering, leaving, idle, finishing);
begin
    process(clk) is begin
        if rising_edge(clk) then
            case state is
                when idle =>
                    enter <= '0';
                    exit <= '0';

                    if a & b = "10" then
                        state = entering;
                    if a & b = "01" then
                        state = leaving;
                    end if;
                when entering =>
                    enter <= '1';
                    if a & b = "01" or a & b = "01" then
                        state <= finishing;
                    end if
                when leaving =>
                    exit <= '1';
                    if a & b "11" or a & b = "00" then
                        state <= finishing;
                    end if;
                when finishing =>
                    if a & b = "00" then
                        state <= idle;
                    end if
            end case;
end architecture arch;
```

### 3

```vhdl
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all

entity ex43 is
    port(
        inc : in std_logic;
        dec : in std_logic
    );
end entity ex43

architecture arch of ex43 is
    signal counter : integer;

begin
    process(inc) is begin
        if rising_edge(inc) then
            counter <= counter + 1;
        end if;
    end process;

    process(dec) is begin
        if counter = 0 then
            counter <= 0;
        elsif rising_edge(dec) then
            counter <= counter - 1;
        end if;
    end process;
end architecture arch;
```

### 4
```Vhdl
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ex44 is
    port(
        digit0 : out std_logic_vector(0 to 6);
        digit1 : out std_logic_vector(0 to 6);
        digit2 : out std_logic_vector(0 to 6);
        digit3 : out std_logic_vector(0 to 6);
        digit4 : out std_logic_vector(0 to 6);
        digit5 : out std_logic_vector(0 to 6);
        a : in std_logic;
        b : in std_logic;
        clk : in std_logic;
		  light: out std_logic_vector(0 to 2)
    );
end entity ex44;

architecture arch of ex44 is
	type state_type is (entering, exiting, idle, finishing);
	signal state : state_type := idle;
	signal sensors : std_logic_vector(0 to 1);
	signal counter : integer;
	signal inc : std_logic;
	signal dec : std_logic;
   type segment_t is array(0 to 5) of std_logic_vector(6 downto 0);
   signal segments : segment_t;
begin
    process(clk) is begin
        if rising_edge(clk) then
				sensors <= not a & not b;
            case state is
                when idle =>
                    light(0) <= '0';
						  light(1) <= '0';

                    if sensors = "10" then
                        state <= entering;
								inc <= '1';
								inc <= '0';
                    elsif sensors = "01" then
                        state <= exiting;
								dec <= '1';
								dec <= '0';
                    end if;
                when entering =>
                    light(0) <= '1';
                    if sensors = "01" then
                        state <= finishing;
                    end if;
                when exiting =>
                    light(1) <= '1';
                    if sensors = "10" then
                        state <= finishing;
                    end if;
                when finishing =>
                    if sensors = "00" then
                        state <= idle;
                    end if;
            end case;
				
				for i in 0 to 5 loop
					case std_logic_vector(to_unsigned(counter, (6*4)))((i*4) + 3 downto i*4) is
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
		
    process(inc, dec) is begin
        if rising_edge(inc) then
            counter <= counter + 1;
        elsif rising_edge(dec) then
				if counter = 0 then
					counter <= 0;
				else
					counter <= counter - 1;
				end if;
        end if;
    end process;
	 
end architecture arch;
```