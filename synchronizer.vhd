
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity synchronizer is
	PORT(
		clk_i : in std_logic;
		sig_i : in std_logic;
		sig_o : out std_logic
	);
end synchronizer;

architecture Behavioral of synchronizer is

begin

process(clk_i)

	begin
		if rising_edge(clk_i) then
			sig_o <= sig_i;
		end if;
end process;

end Behavioral;