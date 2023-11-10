-------------------------------------------------------------------------------
--
-- Title       : TB_NbAdder
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

entity TB_NbAdder is
end TB_NbAdder;

architecture TB_NbAdder_behavior of TB_NbAdder is

	-- Testbench components
	component NbAdder is
		generic (Nb : integer);	
		port(
		 	a : in STD_LOGIC_VECTOR(Nb-1 downto 0);
			b : in STD_LOGIC_VECTOR(Nb-1 downto 0);
			r : out STD_LOGIC_VECTOR(Nb-1 downto 0)
		);
	end component NbAdder;
	
	-- Testbench constant
	constant CLK_PERIOD : time := 10 ns;
	constant N : integer := 4;
	
	-- Testbench signals
	signal a : STD_LOGIC_VECTOR(N-1 downto 0) := (others => '0');
	signal b : STD_LOGIC_VECTOR(N-1 downto 0) := (others => '0');
	signal r : STD_LOGIC_VECTOR(N-1 downto 0) := (others => '0');

begin

	-- Instantiate the NbAdder module
    NbAdder_tb : NbAdder generic map (N) port map (a, b, r);
	
	-- Main process
    main_process: process
    begin

		wait for CLK_PERIOD;
		
		a <= "0100";
		b <= "0001";
		wait for CLK_PERIOD;
		
		a <= "1000";
		b <= "0111";
		wait for CLK_PERIOD;
		
        a <= "0101";
		b <= "0100";
        wait for CLK_PERIOD;
		
		a <= "0010";
		b <= "0110";
        wait for CLK_PERIOD;
		
		a <= "0110";
		b <= "0010";
        wait for CLK_PERIOD;
		
		a <= "0110";
		b <= "0110";
        wait for CLK_PERIOD;
		
		a <= "1000";
		b <= "1000";
		wait for CLK_PERIOD;
		
		a <= "1100";
		b <= "1000";
		wait for CLK_PERIOD;
		
		a <= "1000";
		b <= "1100";
		wait for CLK_PERIOD;
		
		a <= "1010";
		b <= "1010";
		
    end process;

end TB_NbAdder_behavior;
