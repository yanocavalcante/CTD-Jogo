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
    -- Decodificação para os números de 0 a 9 e a letra A
    HEX <= "0000001" when C = "0000" else -- 0
            "1001111" when C = "0001" else -- 1
            "0010010" when C = "0010" else -- 2
            "0000110" when C = "0011" else -- 3
            "1001100" when C = "0100" else -- 4
            "0100100" when C = "0101" else -- 5
            "0100000" when C = "0110" else -- 6
            "0001111" when C = "0111" else -- 7
            "0000000" when C = "1000" else -- 8
            "0000100" when C = "1001" else -- 9
            "0001000" when C = "1010" else -- A
            "1111111"; -- Estado padrão (todos apagados)
end decod;
