-- Registrador 4 bits
library ieee;
use ieee.std_logic_1164.all;

entity reg4bits is port (
	CLK, RST, enable: in std_logic;
	D: in std_logic_vector(3 downto 0);
	Q: out std_logic_vector(3 downto 0)
);
end reg4bits;

architecture behv of reg4bits is

begin
process(CLK, D, RST, enable)
begin
	if RST = '1' then
		Q <= "0000";
	elsif (CLK'event and CLK = '1') then
		if enable = '1' then
			Q <= D;
		end if;		
	end if;
end process;
end behv;
