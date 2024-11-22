--Bloco de controle, tem a descrição de funcionamento da máquina de estados. Garante que tudo funciona como deve, saídas e transições de um estado para outro.

library ieee;
use ieee.std_logic_1164.all;

entity controle is
port
(
BTN1, BTN0, clock_50: in std_logic;
sw_erro, end_game, end_time, end_round: in std_logic;
R1, R2, E1, E2, E3, E4, E5: out std_logic
);
end entity;

architecture arc of controle is
	type State is (Start, Setup, Play, Count_Round, Check, Waits, Result); --Aqui temos os estados
	signal EA, PE: State := Start; 						-- PE: proximo estado, EA: estado atual 

begin
P1: process(clock_50, BTN0)
begin
	if BTN0= '0' then
		EA <= Start;
	elsif clock_50'event and clock_50= '0' then
		EA <= PE;
	end if;
end process;

P2: process(BTN1, EA, sw_erro, end_game, end_time, end_round)
begin
	case EA is
		when Start =>
			 R1 <= '1';
			 R2 <= '1';
			 E1 <= '0';
			 E2 <= '0';
			 E3 <= '0';
			 E4 <= '0';
			 E5 <= '0';
			 if BTN1 = '0' then
				PE <= Setup;
			 else
				PE <= Start;
			 end if;
		 
		when Setup =>
			 R1 <= '0';
			 R2 <= '0';
			 E1 <= '1';
			 E2 <= '0';
			 E3 <= '0';
			 E4 <= '0';
			 E5 <= '0';
			 if BTN1 = '1' then
				PE <= Setup;
			 else
			   PE <= Play;
			 end if;
		
		when Play =>
			 R1 <= '0';
			 R2 <= '0';
			 E1 <= '0';
			 E2 <= '1';
			 E3 <= '0';
			 E4 <= '0';
			 E5 <= '0';
			 if end_time = '0' and BTN1 = '1' then
				PE <= Play;
			 elsif end_time = '0' and BTN1 = '0' then
				PE <= Count_Round;
			 else
				PE <= Result;
			 end if;

		when Count_Round =>
			 R1 <= '0';
			 R2 <= '0';
			 E1 <= '0';
			 E2 <= '0';
			 E3 <= '1';
			 E4 <= '0';
			 E5 <= '0';
			 PE <= Check;

		when Check =>
			 R1 <= '0';
			 R2 <= '0';
			 E1 <= '0';
			 E2 <= '1';
			 E3 <= '0';
			 E4 <= '0';
			 E5 <= '0';
			 if not(sw_erro = '1' or end_round = '1' or end_game = '1') then
				PE <= Waits;
			 else
				PE <= Result;
			 end if;

		when Waits =>
			 R1 <= '1';
			 R2 <= '0';
			 E1 <= '0';
			 E2 <= '0';
			 E3 <= '0';
			 E4 <= '1';
			 E5 <= '0';
		
			 if BTN1 = '0' then
				PE <= Play;
			 end if;

		when Result =>
			 R1 <= '0';
			 R2 <= '0';
			 E1 <= '0';
			 E2 <= '0';
			 E3 <= '0';
			 E4 <= '0';
			 E5 <= '1';
			 if BTN1 = '0' then
				PE <= Start;
			 end if;
		end case;		
end process;
end arc;