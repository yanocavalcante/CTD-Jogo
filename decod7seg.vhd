library IEEE;
use IEEE.Std_Logic_1164.all;

entity decod7seg is
    port(
        C: in std_logic_vector(3 downto 0); -- Seletor de 4 bits
        HEX: out std_logic_vector(6 downto 0) -- Saída para o display de 7 segmentos
    );
end decod7seg;

architecture decod of decod7seg is
begin
    HEX <= "1000000" when C = "0000" else -- 0
            "1001111" when C = "0001" else -- 1
            "0010010" when C = "0010" else -- 2
            "0110000" when C = "0011" else -- 3
            "1001100" when C = "0100" else -- 4
            "0100100" when C = "0101" else -- 5
            "0100000" when C = "0110" else -- 6
            "0001111" when C = "0111" else -- 7
            "0000000" when C = "1000" else -- 8
            "0000100" when C = "1001" else -- 9
            "0001000" when C = "1010" else -- A
            "0000011" when C = "1011" else -- b
            "1000110" when C = "1100" else -- C
            "0100001" when C = "1101" else -- d
            "0000110" when C = "1110" else -- E
            "0001110" when C = "1111" else -- F
            "1111111"; -- Estado padrão (todos apagados)
end decod;
