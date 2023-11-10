-------------------------------------------------------------------------------
--
-- Title       : HalfAdder
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

entity HalfAdder is
	port(
		a : in STD_LOGIC;
		b : in STD_LOGIC;
		sum : out STD_LOGIC;
		carry_out : out STD_LOGIC
	);
end HalfAdder;

architecture HalfAdder_behavior of HalfAdder is

begin

	sum <= a xor b;
	carry_out <= a and b;
	
end HalfAdder_behavior;
