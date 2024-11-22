-- Registrador 10 bits
library ieee;
use ieee.std_logic_1164.all;

entity reg10bits is port (
	CLK, RST, enable: in std_logic;
	D: in std_logic_vector(9 downto 0);
	Q: out std_logic_vector(9 downto 0)
);
end reg10bits;

architecture behv of reg10bits is

begin
process(CLK, D, RST)
begin
	if RST = '1' then
		Q <= "0000000000";
	elsif (CLK'event and CLK = '1') then
		if enable = '1' then
			Q <= D;
		end if;		
	end if;
end process;
end behv;
