library IEEE;
use IEEE.Std_Logic_1164.all;
use IEEE.std_logic_unsigned.all; -- necessário para o +


entity soma is
port (
	seq: in std_logic_vector(9 downto 0);
	soma_out: out std_logic_vector(3 downto 0)
);
end soma;

architecture circuito of soma is
begin
soma_out <=  ("000" & seq(0)) + ("000" & seq(1)) + ("000" & seq(2)) + ("000" & seq(3)) + ("000" & seq(4)) + ("000" & seq(5)) + ("000" & seq(6)) + ("000" & seq(7)) + ("000" & seq(8)) + ("000" & seq(9));
end circuito;