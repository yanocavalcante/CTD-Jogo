library ieee;
use ieee.std_logic_1164.all;

entity counter0to10 is port(
    Enable, Reset, CLOCK: in std_logic;
    Round: out std_logic_vector(3 downto 0);
    end_round: out std_logic
);
end counter0to10;

architecture bhv of counter0to10 is
        type STATES is (E0, E1, E2, E3, E4, E5, E6, E7, E8, E9);
        signal EA, PE: STATES;
begin
P1: process(clock, reset)
begin
        if reset= '0' then
                EA <= E0;
        elsif clock'event and clock= '0' then
                EA <= PE;
        end if;
end process;

P2: process(EA)
begin
        case EA is
        when E0 =>
                Round <= "0001";
                PE <= E1;
                end_round <= '0';
        when E1 =>
                Round <= "0010";
                PE <= E2;
                end_round <= '0';
        when E2 =>
                Round <= "0011";
                PE <= E3;
                end_round <= '0';
        when E3 =>
                Round <= "0100";
                PE <= E4;
                end_round <= '0';
        when E4 =>
                Round <= "0101";
                PE <= E5;
                end_round <= '0';
        when E5 =>
                Round <= "0110";
                PE <= E6;
                end_round <= '0';
        when E6 =>
                Round <= "0111";
                PE <= E7;
                end_round <= '0';
        when E7 =>
                Round <= "1000";
                PE <= E8;
                end_round <= '0';
        when E8 =>
                Round <= "1001";
                PE <= E9;
                end_round <= '0';
        when E9 =>
                Round <= "1010";
                end_round <= '1';
        end case;
end process;
end bhv;
