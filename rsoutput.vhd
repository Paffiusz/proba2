library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity rsoutput is
	PORT(
		clk_i : in std_logic;
		d_ready: in std_logic;
		TXD_i : in std_logic_vector(7 downto 0);
		TXD_o : out std_logic
	);

end rsoutput;

architecture Behavioral of rsoutput is


component Freqdiv is
	PORT(
		clk_i : in std_logic;
		rst_i : in std_logic;
		CLKout : out std_logic
		);
end component;

signal div_clk : std_logic;
signal temp : std_logic_vector(7 downto 0);
signal rst_in : std_logic:='0';

shared variable count : integer range 0 to 9:=0;

type state is (waiting, output);



begin

divi_clk: Freqdiv
	PORT MAP(clk_i=>clk_i,rst_i=>rst_in,CLKout => div_clk);
	
process(div_clk)

variable q : state := waiting;

	begin
		if rising_edge(div_clk) then
		
			if d_ready = '1' then
				q:=output;
				temp<=TXD_i;
			elsif count = 9 or count = 0 then
				q:=waiting;
			end if;
			
			if q = waiting then
				count := 0;
				TXD_o<='1';
			elsif q = output then
				
				case count is
					when 0 => TXD_o <= '0';
					when 1 => TXD_o <= temp(0);
					when 2 => TXD_o <= temp(1);
					when 3 => TXD_o <= temp(2);
					when 4 => TXD_o <= temp(3);
					when 5 => TXD_o <= temp(4);
					when 6 => TXD_o <= temp(5);
					when 7 => TXD_o <= temp(6);
					when 8 => TXD_o <= temp(7);
					when others=> TXD_o <= '1';
				end case;
				count:=count+1;
			end if;
		end if;
end process;

end Behavioral;

