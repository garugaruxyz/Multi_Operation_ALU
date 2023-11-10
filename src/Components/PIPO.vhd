-------------------------------------------------------------------------------
--
-- Title       : PIPO
-- Design      : MO_ALU
-- Author      : e.papa6@campus.unimib.it & d.gargaro@campus.unimib.it
-- Company     : Universita' degli Studi di Milano Bicocca
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity PIPO is
	generic(Nb : integer);	
	port(
	 	clk : in STD_LOGIC;
	 	reset : in STD_LOGIC;
		enable : in STD_LOGIC;
		data_in : in STD_LOGIC_VECTOR(Nb-1 downto 0);
		data_out : out STD_LOGIC_VECTOR(Nb-1 downto 0)
	);
end PIPO;

architecture PIPO_behavior of PIPO is

	component DFlipFlop
		port(
	 		clk : in STD_LOGIC;
	 		reset : in STD_LOGIC;
			enable : in STD_LOGIC;
			d : in STD_LOGIC;
			q : out STD_LOGIC
		);		
	end component DFlipFlop;

	signal q_signal_in : STD_LOGIC_VECTOR(Nb-1 downto 0);
	signal q_signal_out : STD_LOGIC_VECTOR(Nb-1 downto 0);
	
begin

	g1 : for k in Nb-1 downto 0 generate
		ffi : DFlipFlop port map(clk, reset, enable, q_signal_in(k), q_signal_out(k));
	end generate;
	
	data_out <= q_signal_out;
	q_signal_in <= data_in;

end PIPO_behavior;
