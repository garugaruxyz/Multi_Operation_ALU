-------------------------------------------------------------------------------
--
-- Title       : SIPO
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

entity SIPO is
	generic(Nb : integer);	
	port(
	 	clk : in STD_LOGIC;
	 	reset : in STD_LOGIC;
		enable : in STD_LOGIC;
		data_in : in STD_LOGIC;
		data_out : out STD_LOGIC_VECTOR(Nb-1 downto 0)
	);
end SIPO;

architecture SIPO_behavior of SIPO is

	component DFlipFlop
		port(
	 		clk : in STD_LOGIC;
	 		reset : in STD_LOGIC;
			enable : in STD_LOGIC;
			d : in STD_LOGIC;
			q : out STD_LOGIC
	   	);
	end component DFlipFLop;

	signal q_signal : STD_LOGIC_VECTOR(Nb-1 downto 0);

begin

	ff1 : DFlipFlop port map(clk, reset, enable, data_in, q_signal(0));
	
	g1 : for k in Nb-1 downto 1 generate
		ffi : DFlipFlop port map(clk, reset, enable, q_signal(k-1), q_signal(k));
	end generate;
		
	data_out <= q_signal;

end SIPO_behavior;
