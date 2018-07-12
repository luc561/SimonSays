----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:00:10 06/21/2018 
-- Design Name: 
-- Module Name:    phases - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity phases is
    Port ( button1 : in  STD_LOGIC;
           button2 : in  STD_LOGIC;
           button3 : in  STD_LOGIC;
           button4 : in  STD_LOGIC;
           button5 : in  STD_LOGIC;
			  clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
<<<<<<< HEAD
           Seven_Segment_Enable : out  STD_LOGIC_VECTOR (1 downto 0);
			  SevenD : out  STD_LOGIC_VECTOR (7 downto 0);
			  Sout : out STD_LOGIC);
=======
           Enable1 : out  STD_LOGIC;
			  Enable2 : out  STD_LOGIC;
           SevenD : out  STD_LOGIC_VECTOR (7 downto 0);
			SD : out  STD_LOGIC_VECTOR (7 downto 0);
		
			Sout : out STD_LOGIC);
>>>>>>> 75e2274b1eff6982f846f7a3d6e9fb40607fbf1b
end phases;

		
architecture Behavioral of phases is


type statetype is (preone, pretwo, prethree, zero, one, two, win, over, zerowaitstate, onewaitstate,twowaitstate);
signal refresh_clk : std_logic := '1';
signal state, nextstate: statetype;
signal digit_sel : unsigned(1 downto 0);
signal bcd : integer := 0;
signal Seven_Segment_Display_output : std_logic_vector (7 downto 0) := (others => '0');
signal bcd0, bcd1, bcd2 : integer := 0;

begin

--state register

process(clk, reset, button1, button2, button3, button4, button5) 
variable i:integer:=0; 
variable refresh_count : integer :=0; 
begin

if (reset = '0') then state <= preone;
elsif (clk' event and clk='1') then


if refresh_count = 1200 then
   refresh_clk <= not refresh_clk;
   refresh_count := 1;
	else
	refresh_count := refresh_count + 1;
end if;
  
case (state) is
when preone =>
bcd0 <= 0;
bcd1 <= 1;
if i<12500000 then
i:=i+1;
<<<<<<< HEAD
elsif i=12500000 then
=======
elsif i= 5000000 then
Enable1 <= '0';
Enable2 <= '1';
SevenD <= "11111001";
>>>>>>> 75e2274b1eff6982f846f7a3d6e9fb40607fbf1b
state <= pretwo;
i:=0;
end if;


when pretwo =>
bcd0 <= 0;
bcd1 <= 2;
if i<12500000 then
i:=i+1;
<<<<<<< HEAD
elsif i=12500000 then
=======
elsif i=5000000 then
Enable1 <= '0';
Enable2 <= '1';
SevenD <= "10100100";
>>>>>>> 75e2274b1eff6982f846f7a3d6e9fb40607fbf1b
state <= prethree;
i:=0;
end if;


when prethree =>
bcd0 <= 0;
bcd1 <= 3;
if i<12500000 then
i:=i+1;
<<<<<<< HEAD
elsif i=12500000 then
state <=zero;
=======
elsif i=5000000 then
Enable1 <= '0';
Enable2 <= '1';
SevenD <= "10110000";
state <=clear;
>>>>>>> 75e2274b1eff6982f846f7a3d6e9fb40607fbf1b
i:=0;
end if;


<<<<<<< HEAD
when zero =>
bcd0 <= 6;
bcd1 <= 0;
=======
when clear =>
if i<5000000 then
i:=i+1;
elsif i=5000000 then
Enable2 <= '0';
Enable1 <= '1';
SevenD <= "10000010";
i:=0;
end if;
if i<5000000 then
i:=i+1;
elsif i=5000000 then
Enable2 <= '1';
Enable1 <= '0';
SevenD <= "11000000";
i:=0;
end if;
if i<5000000 then
i:=i+1;
elsif i=5000000 then
Enable1 <= '1';  
i:=0;
end if;
state  <=zero;


when zero =>
Enable2 <= '0';
Enable1 <= '1';
SevenD <= "10000010";
if i<5000000 then
i:=i+1;
elsif i=5000000 then
Enable2 <= '1';
Enable1 <= '0';
SevenD <= "11000000";
i:=0;
end if;
if i<5000000 then
i:=i+1;
elsif i=5000000 then
i:=0;
end if;
>>>>>>> 75e2274b1eff6982f846f7a3d6e9fb40607fbf1b
if(button1 ='0') then state<=zerowaitstate;
elsif(button2='0') or (button3='0')then state<=over;
elsif(button1='1') then state<=zero;
end if;

when zerowaitstate =>
<<<<<<< HEAD
bcd0 <= 6;
bcd1 <= 0;
=======
Enable2 <= '0';
Enable1 <= '1';
SevenD <= "10000010";
if i<5000000 then
i:=i+1;
elsif i=5000000 then
Enable2 <= '1';
Enable1 <= '0';
SevenD <= "11000000";
i:=0;
end if;
if i<5000000 then
i:=i+1;
elsif i=5000000 then
Enable1 <= '1'; 
i:=0;
end if;
>>>>>>> 75e2274b1eff6982f846f7a3d6e9fb40607fbf1b
if(button1 ='1') then state<=one;
else
state <=zerowaitstate;
end if;


when one =>
<<<<<<< HEAD
bcd0 <= 6;
bcd1 <= 0;
=======
Enable2 <= '0';
Enable1 <= '1';
SevenD <= "10000010";
if i<5000000 then
i:=i+1;
elsif i=5000000 then
Enable2 <= '1';
Enable1 <= '0';
SevenD <= "11000000";
i:=0;
end if;
if i<5000000 then
i:=i+1;
elsif i=5000000 then
Enable1 <= '1'; 
i:=0;
end if;
>>>>>>> 75e2274b1eff6982f846f7a3d6e9fb40607fbf1b
if(button2='0') then state<=onewaitstate;
elsif(button3='0') or (button1 ='0')then state<=over;
elsif (button2='1') then state<=one;
end if;

when onewaitstate =>
<<<<<<< HEAD
bcd0 <= 6;
bcd1 <= 0;
=======
Enable2 <= '0';
Enable1 <= '1';
SevenD <= "10000010";
if i<5000000 then
i:=i+1;
elsif i=5000000 then
Enable2 <= '1';
Enable1 <= '0';
SevenD <= "11000000";
i:=0;
end if;
if i<5000000 then
i:=i+1;
elsif i=5000000 then
Enable1 <= '1'; 
i:=0;
end if;
>>>>>>> 75e2274b1eff6982f846f7a3d6e9fb40607fbf1b
if(button2 ='1') then state<=two;
else
state <=onewaitstate;
end if;


when two =>
<<<<<<< HEAD
bcd0 <= 6;
bcd1 <= 0;
=======
Enable2 <= '0';
Enable1 <= '1';
SevenD <= "10000010";
if i<5000000 then
i:=i+1;
elsif i=5000000 then
Enable2 <= '1';
Enable1 <= '0';
SevenD <= "11000000";
i:=0;
end if;
if i<5000000 then
i:=i+1;
elsif i=5000000 then
Enable1 <= '1'; 
i:=0;
end if;
>>>>>>> 75e2274b1eff6982f846f7a3d6e9fb40607fbf1b
if(button3='0') then state<=twowaitstate;
elsif(button2='0') or (button1='0')then state<=over;
elsif (button3='1') then state<=two;
end if;

when twowaitstate =>
<<<<<<< HEAD
bcd0 <= 6;
bcd1 <= 0;
=======
Enable2 <= '0';
Enable1 <= '1';
SevenD <= "10000010";
if i<5000000 then
i:=i+1;
elsif i=5000000 then
Enable2 <= '1';
Enable1 <= '0';
SevenD <= "11000000";
i:=0;
end if;
if i<5000000 then
i:=i+1;
elsif i=5000000 then
Enable1 <= '1'; 
i:=0;
end if;
>>>>>>> 75e2274b1eff6982f846f7a3d6e9fb40607fbf1b
if(button3='1') then state<=win;
else
state <=twowaitstate;
end if;

when over =>
<<<<<<< HEAD
bcd0 <= 9;
bcd1 <= 9;
=======
Enable1 <= '0';
Enable2 <= '0';
SevenD <= "10001001";

>>>>>>> 75e2274b1eff6982f846f7a3d6e9fb40607fbf1b
state <= over;


when win =>
<<<<<<< HEAD
bcd0 <= 8;
bcd1 <= 8;
=======
Enable1 <= '0';
Enable2 <= '0';
SevenD <= "11100011";
>>>>>>> 75e2274b1eff6982f846f7a3d6e9fb40607fbf1b
state <= win;




end case;
end if;
end process;


process(refresh_clk) --period of clk is 0.0001 seconds.

begin

 if(refresh_clk' event and refresh_clk='1') then
  digit_sel <= digit_sel + 1;
 
 end if;  

end process;

 -- multiplexer to select a BCD digit
   with digit_sel select
        bcd <= bcd0 when "00",
               bcd1 when "01",
					bcd0 when "10",
               bcd1 when "11",
               bcd2 when others;
     
 -- activate selected digit's anode
   with digit_sel select
        Seven_Segment_Enable <= "10" when "00",
                                "01" when "01",
										  "10" when "10",
                                "01" when "11",
                                "11" when others;

   with bcd select

Seven_Segment_Display_output(7 downto 0) <= B"11000000" when 0,
         B"11111001" when 1,
         B"10100100" when 2,
         B"10110000" when 3,
         B"10011000" when 4,
         B"01001000" when 5,
         B"10000010" when 6,
         B"00011110" when 7,
         B"11100011" when 8,--u win
         B"10001001" when 9,--X game over
         B"11111111" when others;
          
-- send data to seven segment display.
 
SevenD(7 downto 0) <= Seven_Segment_Display_output(7 downto 0);  


Sout <= '1' when state=win else'0';






end Behavioral;
