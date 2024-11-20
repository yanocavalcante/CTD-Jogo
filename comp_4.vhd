LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY comp_4 IS
    PORT (
        input: IN STD_LOGIC_VECTOR(3 DOWNTO 0); 
        output: OUT STD_LOGIC
    );
END comp_4;

ARCHITECTURE comparator OF comp_4 IS
BEGIN
    output <= '1' when input = '0100' else '0';
END comparator;
