-------------------------------------------------------------------------------
--
-- Title       : TB_NbCounter
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

entity TB_NbCounter is
end TB_NbCounter;

architecture TB_NbCounter_behavior of TB_NbCounter is

	-- Testbench components
	component NbCounter is
		generic(Nb : integer);
		port(
			clk : in STD_LOGIC;
			reset : in STD_LOGIC;
			enable : in STD_LOGIC;
			out_count : out STD_LOGIC
		);
	end component NbCounter;
	
	-- Testbench constant
	constant CLK_PERIOD : time := 10 ns;
	constant N : integer := 4;
	
	-- Testbench signals
	signal clk : STD_LOGIC := '0';
	signal reset : STD_LOGIC := '0';
	signal enable : STD_LOGIC := '0';
	signal out_count : STD_LOGIC := '0';
	
begin

	-- Instantiate the NbCounter module
	TB_NbCounter : NbCounter generic map (N) port map (clk, reset, enable, out_count);
	
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
		wait for CLK_PERIOD * 6;
		enable <= not enable;
    end process;
	
	-- Reset process
    reset_process: process
    begin
        wait for CLK_PERIOD;
		reset <= not reset;
		wait for CLK_PERIOD * 8;
		reset <= not reset;
    end process;
	
	-- Main process
    main_process: process
    begin

		wait for CLK_PERIOD;
		
	end process;

end TB_NbCounter_behavior;
