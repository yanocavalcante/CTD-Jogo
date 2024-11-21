LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY comp_4 IS
    PORT (
        soma: IN STD_LOGIC_VECTOR(3 DOWNTO 0); 
        status: OUT STD_LOGIC
    );
END comp_4;

ARCHITECTURE comparator OF comp_4 IS
BEGIN
    status <= '1' when soma = '0100' else '0';
END comparator;
