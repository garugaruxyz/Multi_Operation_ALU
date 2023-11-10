-------------------------------------------------------------------------------
--
-- Title       : REG_OUT
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

entity REG_OUT is
	generic(Nb : integer);
	port(
		clk : in STD_LOGIC;
		reset : in STD_LOGIC;
		enable_pipo_r : in STD_LOGIC;
		data_in : in STD_LOGIC_VECTOR(Nb-1 downto 0);
		data_out : out STD_LOGIC_VECTOR(Nb-1 downto 0)
	);
end REG_OUT;

architecture REG_OUT_behavior of REG_OUT is

	component PIPO is
		generic(Nb : integer);	
		port(
		 	clk : in STD_LOGIC;
		 	reset : in STD_LOGIC;
			enable : in STD_LOGIC;
			data_in : in STD_LOGIC_VECTOR(Nb-1 downto 0);
			data_out : out STD_LOGIC_VECTOR(Nb-1 downto 0)
		);
	end component PIPO;

begin

	pipo_result : PIPO generic map (Nb) port map (clk, reset, enable_pipo_r, data_in, data_out);

end REG_OUT_behavior;
