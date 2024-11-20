library IEEE;
use IEEE.std_Logic_1164.all;
use IEEE.std_logic_unsigned.all; -- necessário para o +

entity topo is
port (CLK_500Hz:in std_logic;
SW: in std_logic_vector(9 downto 0);
KEY: in std_logic_vector(1 downto 0);
LEDR: out std_logic_vector(3 downto 0);
HEX0: out std_logic_vector(6 downto 0)
);
end topo;

architecture circuito1 of topo is
	signal A: std_logic_vector(2 downto 0);
	signal B: std_logic_vector(6 downto 4);
	signal Control: std_logic_vector(9 downto 8);
	signal F1, F2, F3, F4: std_logic_vector(3 downto 0);
	signal F, G, H: std_logic_vector(3 downto 0);	
	
component mux is
port (W: in std_logic_vector(3 downto 0);
X: in std_logic_vector(3 downto 0);
Y: in std_logic_vector(3 downto 0);
Z: in std_logic_vector(3 downto 0);
sel: in std_logic_vector(1 downto 0);
S: out std_logic_vector(3 downto 0)
);
end component;

component sum is
port (A: in std_logic_vector(3 downto 0);
B: in std_logic_vector(3 downto 0);
G: out std_logic_vector(3 downto 0)
);
end component;

component decoder is
port (C: in std_logic_vector(3 downto 0);
HEX0: out std_logic_vector(6 downto 0)
);
end component;

component registrador is
port (D: in std_logic_vector(3 downto 0);
EN: in std_logic;
CLK: in std_logic;
RST: in std_logic;
Q: out std_logic_vector(3 downto 0)
);
end component;

begin
A <= SW(2 downto 0);
B <= SW(6 downto 4);
Control <= SW(9 downto 8);

F1 <= '0' & A;
--A
F2 <= A & '0';
--2A
F3 <= '0' & B;
--B
F4 <= B & '0';

MUXER: mux port map(F1, F2, F3, F4, Control, F);
SUMER: sum port map(F1, F, G);
REGER: registrador port map(G, KEY(1), CLK_500Hz, KEY(0), H);
DECER: decoder port map(H, HEX0);

LEDR <= G;
end circuito1;