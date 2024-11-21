library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter_time is port(
        Enable, reset, clock: in std_logic;
        load: in std_logic_vector(3 downto 0);
        end_time: out std_logic;
        tempo: out std_logic_vector(3 downto 0)
);
end counter_time;

architecture bhv of counter_time is
        type STATES is (E0, E1, E2, E3, E4);
        signal EA, PE: STATES;
begin
P1: process(clock, reset)
begin
        if reset= '0' then
                EA <= E0;
        elsif clock'event and clock= '0' and Enable = '1' then
                EA <= PE;
        end if;
end process;

P2: process(EA)
begin
    case EA is
        when E0 =>
        end case;
end process;
end bhv;
