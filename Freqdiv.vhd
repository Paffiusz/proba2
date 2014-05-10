library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Freqdiv is
port(   clk_i : in std_logic;
		  rst_i : in std_logic;
        CLKout : out std_logic
        );
end Freqdiv;

architecture Behavioral of Freqdiv is

constant N : integer := 5208;

signal counter : integer := 0;

begin
process(clk_i) 
begin

    if rst_i = '1' then
		counter<= 0;
		CLKout<='0'; 
	 elsif rising_edge(clk_i)  then
        if(counter < N/2-1) then
            counter <= counter + 1;
            CLKout <= '1';
        elsif(counter < N-1) then
            counter <= counter + 1;
            CLKout <= '0';
        else
            CLKout <= '0';
            counter <= 0;
        end if; 
    end if;
end process;    

end Behavioral;