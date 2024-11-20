library IEEE;
use IEEE.Std_Logic_1164.all;

entity mux is
port (W: in std_logic_vector(3 downto 0);
X: in std_logic_vector(3 downto 0);
sel: in std_logic;
S: out std_logic_vector(3 downto 0)
);
end mux;

architecture selection of mux is
begin

S <= W when sel = "0" else
	X;
end selection;
