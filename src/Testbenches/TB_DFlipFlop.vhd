-------------------------------------------------------------------------------
--
-- Title       : TB_DFlipFlop
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

entity TB_DFlipFlop is
end TB_DFlipFlop;

architecture TB_DFlipFlop_behavior of TB_DFlipFlop is

	-- Testbench components
	component DFlipFlop is
		port(
	 		clk : in STD_LOGIC;
	 		reset : in STD_LOGIC;
			enable : in STD_LOGIC;
			d : in STD_LOGIC;
			q : out STD_LOGIC
		);
	end component DFlipFlop;
	
	-- Testbench constants
	constant CLK_PERIOD : time := 10 ns;
	
	-- Testbench signals
	signal clk : STD_LOGIC := '0';
	signal reset : STD_LOGIC := '0';
	signal enable : STD_LOGIC := '0';
	signal d : STD_LOGIC := '0';
	signal q : STD_LOGIC := '0';

begin

	-- Instantiate the DFlipFlop module
	TB_DFlipFlop : DFlipFlop port map (clk, reset, enable, d, q);
	
	-- Clock process
    clk_process: process
    begin
		wait for CLK_PERIOD / 2;
		clk <= not clk;
    end process;
	
	-- Enable process
    enable_process: process
    begin
        wait for CLK_PERIOD * 2;
		enable <= not enable;
		wait for CLK_PERIOD * 4;
		enable <= not enable;
    end process;
	
	-- Reset process
    reset_process: process
    begin
        wait for CLK_PERIOD;
		reset <= not reset;
		wait for CLK_PERIOD * 3;
		reset <= not reset;
    end process;
	
	-- Main process
	main_process: process
    begin
		
		wait for CLK_PERIOD;
		
		d <= '1';
		wait for CLK_PERIOD;
		
		d <= '0';

    end process;

end TB_DFlipFlop_behavior;
