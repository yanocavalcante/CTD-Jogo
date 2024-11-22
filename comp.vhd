library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity comp is
    port (
        rom_code : in STD_LOGIC_VECTOR(9 downto 0);  -- Vetor de 10 bits de entrada (rom_code)
        user_code : in STD_LOGIC_VECTOR(9 downto 0); -- Vetor de 10 bits de entrada (user_code)
        output_bits : out STD_LOGIC_VECTOR(9 downto 0)  -- Vetor de 10 bits de saída
    );
end comp;

architecture comparator of comp is
begin
    -- Comparação bit a bit entre rom_code e user_code
    output_bits <= (rom_code and user_code); -- Realiza a operação AND bit a bit

end comparator;
