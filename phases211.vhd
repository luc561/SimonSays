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
type statetype is (preone, pretwo, prethree, clear, zero, one, two, win, over, zerowaitstate, onewaitstate,twowaitstate);
signal state, nextstate: statetype;

begin
Enable1 <= '0';
--state register

process(clk, reset, button1, button2, button3, button4, button5) 
variable i:integer:=0; 
begin

if (reset = '0') then state <= preone;
elsif (clk' event and clk='1') then

case (state) is
when preone =>
if i<5000000 then
i:=i+1;
elsif i= 5000000 then
SevenD <= "11111001";
state <= pretwo;
i:=0;
end if;



when pretwo =>
if i<5000000 then
i:=i+1;
elsif i=5000000 then
SevenD <= "10100100";
state <= prethree;
i:=0;
end if;



when prethree =>
if i<5000000 then
i:=i+1;
elsif i=5000000 then
SevenD <= "10110000";
i:=0;
state <=clear;

end if;


when clear =>
if i<5000000 then
i:=i+1;
elsif i=5000000 then
SevenD <= "11000000";
i:=0;
state  <=zero;
end if;

when zero =>
if(button1 ='0') then state<=zerowaitstate;
elsif(button2='0') or (button3='0')then state<=over;
elsif(button1='1') then state<=zero;
end if;

when zerowaitstate =>
--counter <= "11000000";
if(button1 ='1') then state<=one;
else
state <=zerowaitstate;
end if;


when one =>
--counter <= "11000000";
if(button2='0') then state<=onewaitstate;
elsif(button3='0') or (button1 ='0')then state<=over;
elsif (button2='1') then state<=one;
end if;

when onewaitstate =>
--counter <= "11000000";
if(button2 ='1') then state<=two;
else
state <=onewaitstate;
end if;


when two =>
--counter <= "11000000";
if(button3='0') then state<=twowaitstate;
elsif(button2='0') or (button1='0')then state<=over;
elsif (button3='1') then state<=two;
end if;

when twowaitstate =>
--counter <= "11000000";
if(button3='1') then state<=win;
else
state <=twowaitstate;
end if;

when over =>
SevenD <= "10001001";
state <= over;


when win =>
SevenD <= "11100011";
state <= win;




end case;
end if;
end process;


Sout <= '1' when state=win else'0';






end Behavioral;
