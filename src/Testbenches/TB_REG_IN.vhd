-------------------------------------------------------------------------------
--
-- Title       : TB_REG_IN
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

entity TB_REG_IN is
end TB_REG_IN;

architecture TB_REG_IN_behavior of TB_REG_IN is

	-- Testbench components
	component REG_IN is
		generic(Nb : integer);
		port(
			clk : in STD_LOGIC;
			reset : in STD_LOGIC;
			enable_sipo_a : in STD_LOGIC;
			enable_sipo_b : in STD_LOGIC;
			data_in : in STD_LOGIC;
			data_out_a : out STD_LOGIC_VECTOR(Nb-1 downto 0);
			data_out_b : out STD_LOGIC_VECTOR(Nb-1 downto 0)
		);
	end component REG_IN;
	
	-- Testbench constants
	constant CLK_PERIOD : time := 10 ns;
	constant N : integer := 4;
	
	-- Testbench signals
	signal clk : STD_LOGIC := '0';
	signal reset : STD_LOGIC := '0';
	signal enable_sipo_a : STD_LOGIC := '0';
	signal enable_sipo_b : STD_LOGIC := '0';
	signal data_in : STD_LOGIC := '0';
	signal data_out_a : STD_LOGIC_VECTOR(N-1 downto 0) := (others => '0');
	signal data_out_b : STD_LOGIC_VECTOR(N-1 downto 0) := (others => '0');

begin

	-- Instantiate the REG_IN module
	TB_REG_IN : REG_IN generic map (N) port map (clk, reset, enable_sipo_a, enable_sipo_b, data_in, data_out_a, data_out_b);
	
	-- Clock process
    clk_process: process
    begin
		wait for CLK_PERIOD / 2;
		clk <= not clk;
    end process;
	
	-- Reset process
    reset_process: process
    begin
        wait for CLK_PERIOD;
		reset <= not reset;
		wait for CLK_PERIOD * 10;
		reset <= not reset;
    end process;
	
	-- Main process
    main_process: process
    begin
		
        wait for CLK_PERIOD;
		
		enable_sipo_a <= '1';
		enable_sipo_b <= '0';
		data_in <= '1';
        wait for CLK_PERIOD;
		
		data_in <= '0';
        wait for CLK_PERIOD;
		
		data_in <= '0';
        wait for CLK_PERIOD;
		
		data_in <= '1';
        wait for CLK_PERIOD; -- A read
		
		enable_sipo_a <= '0';
		enable_sipo_b <= '1';
		data_in <= '1';
        wait for CLK_PERIOD;
		
		data_in <= '1';
        wait for CLK_PERIOD;
		
		data_in <= '0';
        wait for CLK_PERIOD;
		
		data_in <= '1'; 
		wait for CLK_PERIOD; -- B read
		
		enable_sipo_a <= '0';
		enable_sipo_b <= '0';

    end process;
	
	

end TB_REG_IN_behavior;
