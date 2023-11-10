-------------------------------------------------------------------------------
--
-- Title       : ALU
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

entity ALU is
	generic (Nb : integer);
	port(
		a : in STD_LOGIC_VECTOR(Nb-1 downto 0);
		b : in STD_LOGIC_VECTOR(Nb-1 downto 0);
		op_a : in STD_LOGIC_VECTOR(1 downto 0);
		op_b : in STD_LOGIC_VECTOR(1 downto 0);
		r : out STD_LOGIC_VECTOR(Nb-1 downto 0)
	);
end ALU;


architecture ALU_behavior of ALU is

	component CA2 is
		generic (Nb : integer := 8);	
		port(
			 data_in : in STD_LOGIC_VECTOR(Nb-1 downto 0);
			 data_out : out STD_LOGIC_VECTOR(Nb-1 downto 0)
		);
	end component CA2;
	
	component Mux1x3 is
		generic (Nb : integer);	
		port(
		 	selector : in STD_LOGIC_VECTOR(1 downto 0);
		 	data_in_0 : in STD_LOGIC_VECTOR(Nb-1 downto 0);
			data_in_1 : in STD_LOGIC_VECTOR(Nb-1 downto 0);
			data_in_2 : in STD_LOGIC_VECTOR(Nb-1 downto 0);
			data_out : out STD_LOGIC_VECTOR(Nb-1 downto 0)
		);
	end component Mux1x3;
	
	component NbAdder is
		generic (Nb : integer);	
		port(
		 	a : in STD_LOGIC_VECTOR(Nb-1 downto 0);
			b : in STD_LOGIC_VECTOR(Nb-1 downto 0);
			r : out STD_LOGIC_VECTOR(Nb-1 downto 0)
		);
	end component NbAdder;
	
	signal ca : STD_LOGIC_VECTOR(Nb-1 downto 0) := (others => '0');
	signal cb : STD_LOGIC_VECTOR(Nb-1 downto 0) := (others => '0');
	signal zero : STD_LOGIC_VECTOR(Nb-1 downto 0) := (others => '0');
	signal a_out : STD_LOGIC_VECTOR(Nb-1 downto 0) := (others => '0');
	signal b_out : STD_LOGIC_VECTOR(Nb-1 downto 0) := (others => '0');

begin

	ca2_a : CA2 generic map (Nb) port map (a, ca);
	ca2_b : CA2 generic map (Nb) port map (b, cb);
	
	mux_a : Mux1x3 generic map (Nb) port map (op_a, zero, a, ca, a_out);
	mux_b : Mux1x3 generic map (Nb) port map (op_b, zero, b, cb, b_out);
	
	adder : NbAdder generic map (Nb) port map (a_out, b_out, r);

end ALU_behavior;
