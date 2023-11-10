-------------------------------------------------------------------------------
--
-- Title       : FullAdder
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

entity FullAdder is
	port(
		a : in STD_LOGIC;
		b : in STD_LOGIC;
		carry_in : in STD_LOGIC;
		sum : out STD_LOGIC;
		carry_out : out STD_LOGIC
	);
end FullAdder;

architecture FullAdder_behavior of FullAdder is

	component HalfAdder is
    	port(
			a : in STD_LOGIC; 
			b : in  STD_LOGIC;
			sum : out STD_LOGIC;
			carry_out : out STD_LOGIC
		);
    end component HalfAdder;
	
	signal sum1 : STD_LOGIC := '0';
	signal carry_out0 : STD_LOGIC := '0';
	signal carry_out1 : STD_LOGIC := '0';

begin

	ha1 : HalfAdder port map (a, b, sum1, carry_out0);
	ha2 : HalfAdder port map (sum1, carry_in, sum, carry_out1);
	carry_out <= carry_out0 or carry_out1;

end FullAdder_behavior;
