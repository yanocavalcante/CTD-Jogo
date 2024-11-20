library iee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity comp is
    Port (
        rom_code : in STD_LOGIC_VECTOR(9 downto 0); 
        user_code : in STD_LOGIC_VECTOR(9 downto 0); 
        output_bits : out STD_LOGIC_VECTOR(9 downto 0) 
    );
end comp;

architecture comparator of comp is
begin
    begin
        for i in 0 to 9 loop
            output_bits(i) <= rom_code(i) and user_code(i) 
        end loop;
end comparator;
