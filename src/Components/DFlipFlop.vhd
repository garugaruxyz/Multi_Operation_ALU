-------------------------------------------------------------------------------
--
-- Title       : DFlipFlop
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

entity DFlipFlop is
	port(
	 	clk : in STD_LOGIC;
	 	reset : in STD_LOGIC;
		enable : in STD_LOGIC;
		d : in STD_LOGIC;
		q : out STD_LOGIC
	);
end DFlipFlop;

architecture DFlipFlop_behavior of DFlipFlop is

begin
	
	process(clk, reset)
 	begin 
     	if reset='0' then 
   			q <= '0';
		elsif rising_edge(clk) and enable = '1' then
   			q <= d; 
  		end if;      
 	end process;

end DFlipFlop_behavior;
