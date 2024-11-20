library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity Datapath is port (
	m: in std_logic_vector(6 downto 0);
	r: out std_logic_vector(6 downto 0);
	clock, Tw, Tc: in std_logic;
	Tm: out std_logic);
end Datapath;

architecture arqdtp of Datapath is
signal tot: std_logic_vector(6 downto 0);
begin

-- Registrador e Somador:
process(clock,Tc,Tw)
begin
if (Tc = '1') then
tot <= "0000000";
elsif (clock'event AND clock = '1') then
if (Tw = '1') then
tot <= tot + 1;
end if;
end if;
end process;
r <= tot;
-- Comparador:
Tm <= '1' when (tot < m) else
'0';
end arqdtp;