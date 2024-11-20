-- Armazena as opções das sequências, dependendo no valor que for escolhido, será escolhida uma sequência aleatória, que deve ser preenchida pelo aluno

-----------------------------------
library ieee;
use ieee.std_logic_1164.all;
------------------------------------
entity ROM is
  port ( address : in std_logic_vector(3 downto 0);
         data : out std_logic_vector(9 downto 0) );
end entity;

architecture Rom_Arch of ROM is
  type memory is array (00 to 15) of std_logic_vector(9 downto 0);
  constant my_Rom : memory := (
	00 => "0001010101",
	01 => "1000100101",
  02 => "1100110000",
	03 => "1010101000",
	04 => "1111000000",
	05 => "0000001111",
	06 => "0101000111",
	07 => "0000111100",
	08 => "1001010100",
	09 => "0010101010",
	10 => "0110110000",
	11 => "1100000101",
	12 => "0001101010",
	13 => "1001011000",
	14 => "0011110000",
	15 => "1000111000");
begin
   process (address)
   begin
     case address is
        when "0000" => data <= my_rom(00);
        when "0001" => data <= my_rom(01);
        when "0010" => data <= my_rom(02);
        when "0011" => data <= my_rom(03);
        when "0100" => data <= my_rom(04);
        when "0101" => data <= my_rom(05);
        when "0110" => data <= my_rom(06);
        when "0111" => data <= my_rom(07);
        when "1000" => data <= my_rom(08);
        when "1001" => data <= my_rom(09);
        when "1010" => data <= my_rom(10);
        when "1011" => data <= my_rom(11);
	when "1100" => data <= my_rom(12);
	when "1101" => data <= my_rom(13);
	when "1110" => data <= my_rom(14);
	when "1111" => data <= my_rom(15);
        when others => data <= "0001010101";
       end case;
  end process;
end architecture Rom_Arch;
