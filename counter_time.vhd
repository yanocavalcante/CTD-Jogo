library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity counter_time is port(
        Enable, reset, clock: in std_logic;
        load: in std_logic_vector(3 downto 0);
        end_time: out std_logic;
        tempo: out std_logic_vector(3 downto 0)
);
end counter_time;

architecture arqdtp of counter_time is
signal tot: std_logic_vector(3 downto 0);

begin
-- Registrador e Somador:
process(clock, reset, Enable)
begin
	if (reset = '1') then
	tot <= "0000";
	elsif (clock'event AND clock = '1') then
			if (Enable = '1') then
				tot <= tot + 1;
			end if;
	end if;
end process;
tempo <= tot;
-- Comparador:
end_time <= '1' when (tot > load) else
'0';
end arqdtp;