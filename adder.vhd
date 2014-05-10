library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity adder is
	PORT(
		clk_i : in std_logic;
		sig_i : in std_logic_vector(7 downto 0);
		added_sig_o : out std_logic_vector(7 downto 0)
	);
end adder;

architecture Behavioral of adder is

begin

process(clk_i)

	begin
		if rising_edge(clk_i) then
			added_sig_o <= sig_i + 32;
		end if;
		
end process;

end Behavioral;