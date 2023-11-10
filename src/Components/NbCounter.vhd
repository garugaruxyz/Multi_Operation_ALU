-------------------------------------------------------------------------------
--
-- Title       : NbCounter
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

entity NbCounter is
	generic(Nb : integer);
	port(
		clk : in STD_LOGIC;
		reset : in STD_LOGIC;
		enable : in STD_LOGIC;
		out_count : out STD_LOGIC
	);
end NbCounter;
									
architecture NbCounter_behavior of NbCounter is
begin

	process (clk, reset)
	
		variable count : integer := 0;
	
	begin 
		if reset = '0' then
			count := 0;
			out_count <= '0';
		elsif rising_edge(clk) and enable = '1' then 
			if (count = Nb-2) then
				count := 0;
				out_count <= '1';
			else
				count := count + 1;
				out_count <= '0';
			end if;
		end if;
	end process;

end NbCounter_behavior;
