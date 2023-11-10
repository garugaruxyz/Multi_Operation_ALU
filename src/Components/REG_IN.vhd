-------------------------------------------------------------------------------
--
-- Title       : REG_IN
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

entity REG_IN is
	generic(Nb : integer);
	port(
		clk : in STD_LOGIC;
		reset : in STD_LOGIC;
		enable_sipo_a : in STD_LOGIC;
		enable_sipo_b : in STD_LOGIC;
		data_in : in STD_LOGIC;
		data_out_a : out STD_LOGIC_VECTOR(Nb-1 downto 0);
		data_out_b : out STD_LOGIC_VECTOR(Nb-1 downto 0)
	);
end REG_IN;

architecture REG_IN_behavior of REG_IN is

	component SIPO is
		generic(Nb : integer);	
		port(
		 	clk : in STD_LOGIC;
		 	reset : in STD_LOGIC;
			enable : in STD_LOGIC;
			data_in : in STD_LOGIC;
			data_out : out STD_LOGIC_VECTOR(Nb-1 downto 0)
		);
	end component SIPO;

begin

	sipo_a : SIPO generic map (Nb) port map (clk, reset, enable_sipo_a, data_in, data_out_a);
	sipo_b : SIPO generic map (Nb) port map (clk, reset, enable_sipo_b, data_in, data_out_b);

end REG_IN_behavior;
