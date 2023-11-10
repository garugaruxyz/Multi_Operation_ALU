-------------------------------------------------------------------------------
--
-- Title       : CA2
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

entity CA2 is
	generic (Nb : integer);	
	port(
		 data_in : in STD_LOGIC_VECTOR(Nb-1 downto 0);
		 data_out : out STD_LOGIC_VECTOR(Nb-1 downto 0)
	);
end CA2;

architecture CA2_behavior of CA2 is

	component NbAdder is
		generic (Nb : integer);	
		port(
		 	a : in STD_LOGIC_VECTOR(Nb-1 downto 0);
			b : in STD_LOGIC_VECTOR(Nb-1 downto 0);
			r : out STD_LOGIC_VECTOR(Nb-1 downto 0)
		);
	end component NbAdder;
	
	signal ndata_in : STD_LOGIC_VECTOR(Nb-1 downto 0) := (others => '0');
	signal one : STD_LOGIC_VECTOR(Nb-1 downto 0) := (others => '0');
	signal cdata_in : STD_LOGIC_VECTOR(Nb-1 downto 0) := (others => '0');
	signal lowest : STD_LOGIC_VECTOR(Nb-1 downto 0) := (others => '1');

begin

	ca : NbAdder generic map (Nb) port map (ndata_in, one, cdata_in);
	
	ndata_in <= not data_in;
	one(0) <= '1';
	
	process (cdata_in) 
	
	begin 
		if (data_in = lowest) then
			data_out <= (others => '0');
		else
			data_out <= cdata_in;
		end if;
	end process;
	
	
	
end CA2_behavior;
