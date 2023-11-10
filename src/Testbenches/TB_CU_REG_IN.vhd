-------------------------------------------------------------------------------
--
-- Title       : TB_CU_REG_IN
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

entity TB_CU_REG_IN is
end TB_CU_REG_IN;

architecture TB_CU_REG_IN_behavior of TB_CU_REG_IN is

	-- Testbench components
	component CU_REG_IN is
		port(
			clk : in STD_LOGIC;
			reset : in STD_LOGIC;
			enable : in STD_LOGIC;
			control_bit : in STD_LOGIC;
			count_a : in STD_LOGIC;
			count_b : in STD_LOGIC;
			enable_a : out STD_LOGIC;
			enable_b : out STD_LOGIC;
			reset_counter : out STD_LOGIC;
			read_completed : out STD_LOGIC;
			state : out STD_LOGIC_VECTOR(5 downto 0)
		);
	end component CU_REG_IN;
	
	-- Testbench constant
	constant CLK_PERIOD : time := 10 ns;
	
	-- Testbench signals
	signal clk : STD_LOGIC := '0';
	signal reset : STD_LOGIC := '0';
	signal enable : STD_LOGIC := '0';
	signal control_bit : STD_LOGIC := '0';
	signal count_a : STD_LOGIC := '0';
	signal count_b : STD_LOGIC := '0';
	signal enable_a : STD_LOGIC := '0';
	signal enable_b : STD_LOGIC := '0';
	signal reset_counter : STD_LOGIC := '0';
	signal read_completed : STD_LOGIC := '0';
	signal state : STD_LOGIC_VECTOR(5 downto 0) := (others => '0');

begin
	
	-- Instantiate the CU_REG_IN module
	TB_CU_REG_IN : CU_REG_IN port map (clk, reset, enable, control_bit, count_a, count_b, enable_a, enable_b, reset_counter, read_completed, state);
	
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
		wait for CLK_PERIOD * 10;
		enable <= not enable;
    end process;
	
	-- Reset process
    reset_process: process
    begin
        wait for CLK_PERIOD;
		reset <= not reset;
		wait for CLK_PERIOD * 12;
		reset <= not reset;
    end process;
	
	-- Main process
    main_process: process
    begin

		wait for CLK_PERIOD;
		
		control_bit <= '0';
		count_a <= '0';
		count_b <= '0';
		wait for CLK_PERIOD;
		
		control_bit <= '1';		
		wait for CLK_PERIOD * 4;
		
		count_a <= '1';
		wait for CLK_PERIOD * 4;
		
		count_b <= '1';
		wait for CLK_PERIOD;
		
		count_a <= '0';
		count_b <= '0';
		
	end process;
	
end TB_CU_REG_IN_behavior;
