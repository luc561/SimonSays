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
use IEEE.MATH_REAL.ALL;

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
           Enable1 : out  STD_LOGIC;
           SevenD : out  STD_LOGIC_VECTOR (7 downto 0);
			SD : out  STD_LOGIC_VECTOR (7 downto 0);
		
			Sout : out STD_LOGIC);
end phases;

		
architecture Behavioral of phases is

signal counter, counternext : STD_LOGIC_VECTOR (7 downto 0);
type statetype is (preone, pretwo, prethree, zero, one, two, win, over, zerowaitstate, onewaitstate,twowaitstate);
signal state, nextstate: statetype;

begin
Enable1 <= '0';
--state register

process(clk, reset, button1, button2, button3, button4, button5) 
variable i:integer:=0; 
begin

if(reset ='0') then
state <= preone;
SevenD <= "11111111";
elsif (clk' event and clk='1') then
if i<4000000 then
i:=i+1;
elsif i=4000000 then
i:=i+1;
state <= nextstate;
SevenD <= counter;
elsif i>4000000 and i<8000000 then
i:=i+1;
elsif i=8000000 then
i:=i+1;
state <= nextstate;
SevenD <= counter;
elsif i>8000000 and i<12000000 then
i:=i+1;
elsif i=12000000 then
i:=i+1;
state <= nextstate;
SevenD <= counter;
elsif i=12000001 then
state <= zero;
SevenD <= counter;
i:=i+1;
end if;
end if;
end process;

process(state) 

begin
case (state) is
when preone =>
counter <= "11111001";
nextstate <= pretwo;

when pretwo =>
counter <= "10100100";
nextstate <= prethree;

when prethree =>
counter <= "10110000";
nextstate  <=zero;

when zero =>
counter <= "11000000";
if(button1 ='0') then nextstate<=zerowaitstate;
elsif(button2='0') or (button3='0')then nextstate<=over;
elsif(button1='1') then nextstate<=zero;
end if;

when zerowaitstate =>
counter <= "11000000";
if(button1 ='1') then nextstate<=one;
else
nextstate <=zerowaitstate;
end if;


when one =>
counter <= "11000000";
if(button2='0') then nextstate<=onewaitstate;
elsif(button3='0') or (button1 ='0')then nextstate<=over;
elsif (button2='1') then nextstate<=one;
end if;

when onewaitstate =>
counter <= "11000000";
if(button2 ='1') then nextstate<=two;
else
nextstate <=onewaitstate;
end if;


when two =>
counter <= "11000000";
if(button3='0') then nextstate<=twowaitstate;
elsif(button2='0') or (button1='0')then nextstate<=over;
elsif (button3='1') then nextstate<=two;
end if;

when twowaitstate =>
counter <= "11000000";
if(button3='1') then nextstate<=win;
else
nextstate <=twowaitstate;
end if;

when over =>
counter <= "10001001";
nextstate <= over;


when win =>
counter <= "11000000";
nextstate <= win;




end case;
end process;
Sout <= '1' when state=win else'0';






end Behavioral;
