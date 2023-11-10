-------------------------------------------------------------------------------
--
-- Title       : TB_CA2
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

entity TB_CA2 is
end TB_CA2;

architecture TB_CA2_behavior of TB_CA2 is

	-- Testbench components
	component CA2 is
		generic (Nb : integer);	
		port(
			 data_in : in STD_LOGIC_VECTOR(Nb-1 downto 0);
			 data_out : out STD_LOGIC_VECTOR(Nb-1 downto 0)
		);
	end component CA2;
	
	-- Testbench constant
	constant CLK_PERIOD : time := 10 ns;
	constant N : integer := 4;
	
	-- Testbench signals
	signal data_in : STD_LOGIC_VECTOR(N-1 downto 0) := (others => '0');
	signal data_out : STD_LOGIC_VECTOR(N-1 downto 0) := (others => '0');
	
begin

	-- Instantiate the CA2 module
	TB_CA2 : CA2 generic map (N) port map (data_in, data_out);
	
	-- Main process
    main_process: process
    begin
		
		wait for CLK_PERIOD;
		
		data_in <= "0000";
		wait for CLK_PERIOD;
		
		data_in <= "0001";
		wait for CLK_PERIOD;
		
		data_in <= "1010";
		wait for CLK_PERIOD;
		
		data_in <= "1000";
		
	end process;

end TB_CA2_behavior;
