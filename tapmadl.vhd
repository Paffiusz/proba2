library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity tapmadl is
	PORT(
		clk_i : in std_logic;
		RXD_i : in std_logic;
		led:out std_logic;
		TXD_o : out std_logic
	);
end tapmadl;

architecture Behavioral of tapmadl is

component inputv2 is
	PORT(
		clk_i : in std_logic;
		RXD_i : in std_logic;
		d_ready : out std_logic;
		led:out std_logic;
		d_clk : inout std_logic;
		rs_data_o : out std_logic_vector(7 downto 0)
	);
end component;

component rsoutput is
	port(
		clk_i : in std_logic;
		d_ready: in std_logic;
		TXD_i : in std_logic_vector(7 downto 0);
		TXD_o : out std_logic
	);
end component;

component adder is
	port(
		clk_i : in std_logic;
		sig_i : in std_logic_vector(7 downto 0);
		added_sig_o : out std_logic_vector(7 downto 0)
	);
end component;

signal d_clk : std_logic:='0';
signal d_ready : std_logic := '0';
signal rs_data : std_logic_vector(7 downto 0):=(others=>'0');
signal rs_data_added : std_logic_vector(7 downto 0):=(others=>'0');

begin

	ou: inputv2	port map(
			clk_i=>clk_i,
			RXD_i=>RXD_i,
			d_ready=>d_ready,
			d_clk=>d_clk,
			led=>led,
			rs_data_o=>rs_data
		);

	addo: adder port map(
		clk_i=>clk_i,
		sig_i=>rs_data,
		added_sig_o=>rs_data_added
	);
	
	outo: rsoutput port map(
			clk_i=>clk_i,
			d_ready=>d_ready,
			TXD_i=>rs_data_added,
			TXD_o=>TXD_o
	);
end Behavioral;

