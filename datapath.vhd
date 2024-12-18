-- Datapath, fazendo a conexao entre cada componente

library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity datapath is
port (
-- Entradas de dados
SW: in std_logic_vector(9 downto 0);
CLOCK_50, CLK_1Hz: in std_logic;

-- Sinais de controle
R1, R2, E1, E2, E3, E4, E5: in std_logic;

-- Sinais de status
sw_erro, end_game, end_time, end_round: out std_logic;

-- Saidas de dados
HEX0, HEX1, HEX2, HEX3, HEX4, HEX5: out std_logic_vector(6 downto 0);
LEDR: out std_logic_vector(9 downto 0)
);
end datapath;

architecture arc of datapath is
--============================================================--
--                      COMPONENTS                            --
--============================================================--
-------------------DIVISOR DE FREQUENCIA------------------------

component Div_Freq is
port(	    
    clk: in std_logic;
    reset: in std_logic;
    CLK_1Hz: out std_logic
);
end component;

------------------------CONTADORES------------------------------

component counter_time is
port(
    Enable, reset, clock: in std_logic;
    load: in std_logic_vector(3 downto 0);
    end_time: out std_logic;
    tempo: out std_logic_vector(3 downto 0)
);
end component;

component counter0to10 is
port(
    Enable, Reset, CLOCK: in std_logic;
	Round: out std_logic_vector(3 downto 0);
	end_round: out std_logic
);
			
end component;

-------------------ELEMENTOS DE MEMORIA-------------------------

component reg4bits is 
port(
    CLK, RST, enable: in std_logic;
    D: in std_logic_vector(3 downto 0);
    Q: out std_logic_vector(3 downto 0)
);
end component;

component reg8bits is 
port (
	CLK, RST, enable: in std_logic;
	D: in std_logic_vector(7 downto 0);
	Q: out std_logic_vector(7 downto 0)
);
end component;

component reg10bits is 
port(
	CLK, RST, enable: in std_logic;
	D: in std_logic_vector(9 downto 0);
	Q: out std_logic_vector(9 downto 0)
);
end component;

component ROM is
port(
    address : in std_logic_vector(3 downto 0);
    data : out std_logic_vector(9 downto 0) 
);
end component;

---------------------MULTIPLEXADORES----------------------------


component mux2pra1_4bits is
port(
    sel: in std_logic;
	x, y: in std_logic_vector(3 downto 0);
	saida: out std_logic_vector(3 downto 0)
);
end component;

component mux2pra1_7bits is
port (
    sel: in std_logic;
	x, y: in std_logic_vector(6 downto 0);
	saida: out std_logic_vector(6 downto 0)
);
end component;

component mux2pra1_8bits is
port(
    sel: in std_logic;
	x, y: in std_logic_vector(7 downto 0);
	saida: out std_logic_vector(7 downto 0)
);
end component;

component mux2pra1_10bits is
port(
    sel: in std_logic;
	x, y: in std_logic_vector(9 downto 0);
	saida: out std_logic_vector(9 downto 0)
);
end component;

----------------------DECODIFICADOR-----------------------------

component decod7seg is
port(
    C: in std_logic_vector(3 downto 0);
    HEX: out std_logic_vector(6 downto 0)
);
end component;

-------------------COMPARADORES E SOMA--------------------------

component comp is
port (
    rom_code: in std_logic_vector(9 downto 0);
    user_code: in std_logic_vector(9 downto 0);
    output_bits: out std_logic_vector(9 downto 0)
);
end component;

component comp_4 is
port(
    soma: in std_logic_vector(3 downto 0);
    status: out std_logic
);
end component;

component soma is
port(
    seq: in std_logic_vector(9 downto 0);
    soma_out: out std_logic_vector(3 downto 0)
);
end component;

--============================================================--
--                      SIGNALS                               --
--============================================================--

-- MEUS SINAIS
signal SwInputUser, BitsInput, Code, ResultComparada, EntradaLEDS: std_logic_vector(9 downto 0);
signal BitsSelecao, SwSelecao, saida_aux_reg: std_logic_vector(7 downto 0);
signal saida_mux_eight: std_logic_vector(7 downto 0);
signal entrada1_mux_eight, entrada2_mux_eight: std_logic_vector(7 downto 0);
signal t, r, n, allOnes: std_logic_vector(6 downto 0);
signal saida_decoder_hex_4, saida_decoder_2_hex_2, saida_decoder_1_hex_2, saida_decoder_hex_1, saida_decoder_hex_0: std_logic_vector(6 downto 0);
signal saida_mux_seven_0, saida_mux_seven_1, saida_mux_seven_2, saida_mux_seven_3, saida_mux_seven_4, saida_mux_seven_5: std_logic_vector(6 downto 0);
signal Round, BitsSomadosVerifica, BitsSomadosResultado, saida_mux_four, Tempo: std_logic_vector(3 downto 0);
signal enable_mux_seven_1_and_3, enable_mux_seven_4_and_5, enable_aux_reg, end_game_interno, end_round_interno, end_time_interno, sw_acerto: std_logic;

begin


--DIV: Div_Freq port map (CLOCK_50, R2, clk_1); -- Para teste no emulador, comentar essa linha e usar o CLK_1Hz

------------------------CONTADORES------------------------------

CONTADOR_TEMPO: counter_time port map (
	E2, R1, CLK_1Hz,
	BitsSelecao(7 downto 4),
	end_time_interno,
	Tempo
);

CONTADOR_RODADA: counter0to10 port map (
	E3, R2, CLOCK_50,
	Round,
	end_round_interno
);

-------------------ELEMENTOS DE MEMORIA-------------------------

-- Registrador que pega as características da partida selecionadas pelo jogador (Código da ROM e dificuldade)
REG_SEL_8_BITS: reg8bits port map (
    CLOCK_50, R2, E1,
	SwSelecao,
    BitsSelecao
);

-- Registrador que pega o input do usuário a cada rodada
REG_10_BITS: reg10bits port map (
	CLOCK_50, R2, E2,
    SwInputUser,
    BitsInput
);

REG_AUX_8_BITS: reg8bits port map (
	CLOCK_50, R2, enable_aux_reg,
    saida_mux_eight,
    saida_aux_reg
);

-- Acessa a ROM e devolve o código selecionado
MY_ROM: rom port map (
    BitsSelecao(3 downto 0),
    Code
);

---------------------MULTIPLEXADORES----------------------------

MUX_EIGHT: mux2pra1_8bits port map (
	E5,
    entrada1_mux_eight, entrada2_mux_eight,
    saida_mux_eight
);

MUX_TEN: mux2pra1_10bits port map (
	E5,
    "0000000000", Code,
    EntradaLEDS
);

MUX_FOUR: mux2pra1_4bits port map (
    E2,
    BitsSelecao(7 downto 4), Tempo,
    saida_mux_four
);

--Multiplexadores de 7 bits
MUX_SEVEN_5: mux2pra1_7bits port map (
	enable_mux_seven_4_and_5,
    allOnes, t,
    saida_mux_seven_5
);

MUX_SEVEN_4: mux2pra1_7bits port map (
    enable_mux_seven_4_and_5,
    allOnes, saida_decoder_hex_4,
    saida_mux_seven_4
);

MUX_SEVEN_3: mux2pra1_7bits port map (
    enable_mux_seven_1_and_3,
    saida_mux_seven_2, r,
    saida_mux_seven_3
);

MUX_SEVEN_2: mux2pra1_7bits port map (
    E1,
    allOnes, n,
    saida_mux_seven_2
);

MUX_SEVEN_1: mux2pra1_7bits port map (
    enable_mux_seven_1_and_3,
    saida_mux_seven_0, saida_decoder_2_hex_2,
    saida_mux_seven_1
);

MUX_SEVEN_0: mux2pra1_7bits port map (
    E1,
    allOnes, saida_decoder_1_hex_2,
    saida_mux_seven_0
);
-------------------COMPARADORES E SOMA--------------------------

-- Comparador entre o input do usuário e o código da ROM selecionado
MY_COMP: comp port map (
    BitsInput,
    Code,
    ResultComparada
);

-- Soma que verifica se o jogador colocou 4 '1s' lógicos
SOMA_VERIFICA: soma port map (
    BitsInput,
    BitsSomadosVerifica
);

-- Comparador que verifica se o jogador colocou exatamente 4 '1s' lógicos
COMPARA_VERIFICA: comp_4 port map (
    BitsSomadosVerifica,
    sw_acerto
);

-- Soma que verifica se o jogador acertou o código
SOMA_RESULTADO: soma port map (
    ResultComparada,
    BitsSomadosResultado
);

-- Comparador que verifica se o jogador acertou o código
COMPARA_RESULTADO: comp_4 port map (
    BitsSomadosResultado,
    end_game_interno
);
        
---------------------DECODIFICADORES----------------------------
DECODER_HEX_4: decod7seg port map (
    saida_mux_four,
    saida_decoder_hex_4
);

DECODER_2_HEX_2: decod7seg port map (
    Round,
    saida_decoder_2_hex_2
);

DECODER_1_HEX_2: decod7seg port map (
    BitsSelecao(3 downto 0),
    saida_decoder_1_hex_2
);

DECODER_HEX_1: decod7seg port map (
    saida_aux_reg(7 downto 4),
    saida_decoder_hex_1
);

DECODER_HEX_0: decod7seg port map (
    saida_aux_reg(3 downto 0),
    saida_decoder_hex_0
);

---------------------ATRIBUICOES DIRETAS---------------------
SwSelecao <= SW(7 downto 0);
SwInputUser <= SW(9 downto 0);

allOnes <= "1111111";
t <= "0000111";
r <= "0101111";
n <= "0101011";

entrada1_mux_eight <= "1010" & BitsSomadosResultado;
entrada2_mux_eight <= "000" & end_game_interno & (not Round); 

enable_mux_seven_4_and_5 <= (E1 or E2);
enable_mux_seven_1_and_3 <= (R1 xor R2);
enable_aux_reg <= (E5 or E4);

end_game <= end_game_interno;
end_round <= end_round_interno;
end_time <= end_time_interno; 
sw_erro <= (not sw_acerto);

LEDR <= EntradaLEDS;

HEX0 <= saida_decoder_hex_0;
HEX1 <= saida_decoder_hex_1;
HEX2 <= saida_mux_seven_1;
HEX3 <= saida_mux_seven_3;
HEX4 <= saida_mux_seven_4;
HEX5 <= saida_mux_seven_5;
end arc;
