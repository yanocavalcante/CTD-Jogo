library ieee;
use ieee.std_logic_1164.all;

entity Controle is port (
c, Tm, clock, reset: in std_logic;
Tc, Tw: out std_logic);
end Controle;

architecture controlador of controle is
	type STATES is (Init, Espera, Conta);
	signal EA, PE: STATES;
begin
P1: process(clock, reset)
begin
	if reset= '0' then
		EA <= Init;
	elsif clock'event and clock= '0' then
		EA <= PE;
	end if;
end process;

P2: process(EA, c, Tm)
begin
	case EA is
	when Init =>
		Tc <= '1';
		Tw <= '0';
		PE <= Espera;
		
	when Espera =>
		Tc <= '0';
		Tw <= '0';
		if (Tm = '0') then
					PE <= Init;
		else
			if c = '1' then
				PE <= Conta;
			else 
				PE <= Espera;
			end if;
		end if;

	when Conta =>
		Tc <= '0';
		Tw <= '1';
		PE <= Espera;

	end case;
end process;
end controlador;