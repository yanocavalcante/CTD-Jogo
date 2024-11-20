library IEEE;
use IEEE.Std_Logic_1164.all;
use IEEE.std_logic_unsigned.all; -- necessário para o +

entity topo is
port (SW: in std_logic_vector(9 downto 0);
LEDR: out std_logic_vector(3 downto 0);
HEX0: out std_logic_vector(6 downto 0)
);
end topo;

architecture circuito1 of topo is

component mux is
port (W: in std_logic;
X: in std_logic;
Y: in std_logic;
Z: in std_logic;
sel: in std_logic;
S: out std_logic
);
end component;

component sum is
port (A: in std_logic;
B: in std_logic;
F: out std_logic
);
end component;

component decoder is
port (C: in std_logic;
HEX0: out std_logic
);
end component;

begin
A <= SW(2 downto 0);
B <= SW(6 downto 4);
Control <= SW(9 downto 8);

F1 <= (A & ‘0’);
F2 <= A + F1;
F3 <= A + B;
F4 <= A + B & ‘0’;

MUX: mux port map(F1, F2, F3, F4, Control, F);
SUM: sum port map(F1, F, G);
DEC: dec port map(G, HEX0);

LEDR <= G;
end circuito1;