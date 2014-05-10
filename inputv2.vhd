library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity inputv2 is
	PORT(
		clk_i : in std_logic;
		RXD_i : in std_logic;
		d_ready : out std_logic;
		led:out std_logic;
		d_clk : inout std_logic;
		rs_data_o : out std_logic_vector(7 downto 0)
	);
end inputv2;

architecture Behavioral of inputv2 is

component synchronizer is
	PORT(
		clk_i : IN STD_LOGIC;
		sig_i : IN STD_LOGIC;
		sig_o : OUT STD_LOGIC
		);
end component;

component Freqdiv is
	PORT(
		clk_i : in std_logic;
		rst_i : in std_logic;
		CLKout : out std_logic
		);
end component;

signal div_clk : std_logic;
signal sync_RXD : std_logic;
signal t_ready : std_logic:='0';
signal rst_c : std_logic:='1';
signal rs_word : std_logic_vector(7 downto 0):=(others=>'0');
signal push_count : integer:=0;

shared variable count : integer range 0 to 10:=0;


type state is (waiting, input, push);
shared variable q : state :=waiting;

begin

divi_clk: Freqdiv
	PORT MAP(clk_i=>clk_i,rst_i=>rst_c,CLKout => div_clk);
d_clk<=div_clk;

synch_RXD: synchronizer
	PORT MAP(  clk_i=>clk_i, sig_i=>RXD_i, sig_o=>sync_RXD);

process(clk_i)


--	begin
--		if rising_edge(clk_i) then
--			d_ready<=t_ready;
--			if q = waiting then
--
--				led<='0';
--				if sync_RXD = '0' then
--					q := push;
--					t_ready<='0';
--				end if;
--				
--			elsif q = push then
--				push_count<=push_count+1;
--				if push_count = 2604 then
--					q := input;
--					rst_c<='0';
--				end if;
--				
--			elsif q = input then
--				led<='1';
--				push_count <= 0;
--				if count = 10 then
--					q:=waiting;
--					t_ready<='1';
--					rst_c<='1';
--					rs_data_o<=rs_word( 7 downto 0);
--				end if;
				
			end if;
		end if;
end process;

process (div_clk)
	begin
		if rising_edge(div_clk) then
		
			if q = input then
				if count>=1 and count<=8 then
					rs_word(count-1)<=sync_RXD;
				end if;
				count:=count+1;
			elsif q = waiting then
				count:=0; 
			end if;
			
		end if;
end process;


end Behavioral;

