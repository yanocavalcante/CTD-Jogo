library ieee;
use ieee.std_logic_1164.all;

entity MachineManager is port (
   KEY: in std_logic_vector(3 downto 0);
   SW: in std_logic_vector(9 downto 0);
   CLOCK_50: in std_logic;
   LEDR: out std_logic_vector(9 downto 0) );
end MachineManager;

architecture arqmachine of MachineManager is
	signal m, r: std_logic_vector(6 downto 0); --m = valor máximo da contagem  --r = saída da contagem
	signal c, C1Hz: std_logic; --c = pause da conatgem  --C1Hz = relógio de 1Hz
-- Incluir signals se preciso
	signal Tw, Tc, Tm: std_logic;
	signal reset: std_logic;
	
-- Declarar componentes
component Datapath is
		port(m : in std_logic_vector(6 downto 0);
			r : out std_logic_vector(6 downto 0);
			clock, Tw, Tc: in std_logic;
			Tm: out std_logic
);
end component;
	
component Controle is
		port(c, Tm, clock, reset: in std_logic;
			Tc, Tw: out std_logic
);
end component;
		
component div_freq is        port(reset: in std_logic;               clock: in std_logic;               C1Hz: out std_logic);end component;

begin
	m <= SW(6 downto 0);
	c <= KEY(1);
	reset <= KEY(0);
	
	FREQ: div_freq port map(reset, CLOCK_50, C1Hz);
	CONTROLADOR: Controle port map(c, Tm, CLOCK_50, reset, Tc, Tw);
	DATA: Datapath port map(m, r, C1Hz, Tw, Tc, Tm);
	LEDR(6 downto 0) <= r;
	
	
	-- Incluir instancias de Datapath e Controle e conectá-las...
	

	
end arqmachine;

