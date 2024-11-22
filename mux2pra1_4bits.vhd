library IEEE;
use IEEE.Std_Logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity mux2pra1_4bits is
port (
	sel: in std_logic;
	x, y: in std_logic_vector(3 downto 0);
	saida: out std_logic_vector(3 downto 0)
);
end mux2pra1_4bits;

architecture selection of mux2pra1_4bits is
begin

saida <= x when sel = '0' else
	y;
end selection;
