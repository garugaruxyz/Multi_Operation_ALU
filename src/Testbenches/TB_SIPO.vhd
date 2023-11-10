-------------------------------------------------------------------------------
--
-- Title       : TB_SIPO
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

entity TB_SIPO is
end TB_SIPO;

architecture TB_SIPO_behavior of TB_SIPO is

	-- Testbench components
	component SIPO is
		generic(Nb : integer);	
		port(
		 	clk : in STD_LOGIC;
		 	reset : in STD_LOGIC;
			enable : in STD_LOGIC;
			data_in : in STD_LOGIC;
			data_out : out STD_LOGIC_VECTOR(Nb-1 downto 0)
		);
	end component SIPO;
	
	-- Testbench constants
	constant CLK_PERIOD : time := 10 ns;
	constant N : integer := 4;
	
	-- Testbench signals
	signal clk : STD_LOGIC := '0';
	signal reset : STD_LOGIC := '0';
	signal enable : STD_LOGIC := '0';
	signal data_in : STD_LOGIC := '0';
	signal data_out : STD_LOGIC_VECTOR(N-1 downto 0) := (others => '0');

begin

	-- Instantiate the SIPO module
    TB_SIPO : SIPO generic map (N) port map (clk, reset, enable, data_in, data_out);
	
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
		wait for CLK_PERIOD * 6;
		reset <= not reset;
    end process;
	
	-- Main process
    main_process: process
    begin
		
        wait for CLK_PERIOD;
        
        data_in <= '1';
        wait for CLK_PERIOD;
		
		data_in <= '0';
        wait for CLK_PERIOD;
		
		data_in <= '0';
        wait for CLK_PERIOD;
		
		data_in <= '1';
        wait for CLK_PERIOD;
		
		data_in <= '1';
        wait for CLK_PERIOD;
		
		data_in <= '1';
        wait for CLK_PERIOD;
		
		data_in <= '0';
        wait for CLK_PERIOD;
		
		data_in <= '1';

    end process;

end TB_SIPO_behavior;
