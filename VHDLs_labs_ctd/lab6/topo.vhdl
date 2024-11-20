library ieee;
use ieee.std_logic_1164.all;

entity Topo is
port ( LEDR: out std_logic_vector(3 downto 0);
	CLOCK_50: in std_logic;
	KEY: in std_logic_vector(1 downto 0)
);
end topo;

architecture topo_beh of topo is
	signal F: std_logic_vector(3 downto 0);
	signal Clock: std_logic;

component FSM_Conta is
	port (
		clock: in std_logic;
		reset: in std_logic;
		contagem: out std_logic_vector(3 downto 0)
);
end component;

component div_freq is
	port (
		reset: in std_logic;
		clock: in std_logic;
		C1Hz: out std_logic
);
end component;

begin
L1: div_freq port map (KEY(0), CLOCK_50, Clock);
L0: FSM_Conta port map (Clock, KEY(0), F);

LEDR <= F;
end topo_beh;