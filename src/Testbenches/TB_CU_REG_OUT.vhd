-------------------------------------------------------------------------------
--
-- Title       : TB_CU_REG_OUT
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

entity TB_CU_REG_OUT is
end TB_CU_REG_OUT;

architecture TB_CU_REG_OUT_behavior of TB_CU_REG_OUT is

	-- Testbench components
	component CU_REG_OUT is
		port(
			clk : in STD_LOGIC;
			reset : in STD_LOGIC;
			enable : in STD_LOGIC;
			operation_completed : in STD_LOGIC;
			enable_r : out STD_LOGIC;
			write_completed : out STD_LOGIC;
			state : out STD_LOGIC_VECTOR(5 downto 0)
		);
	end component CU_REG_OUT;
	
	-- Testbench constant
	constant CLK_PERIOD : time := 10 ns;
	
	-- Testbench signals
	signal clk : STD_LOGIC := '0';
	signal reset : STD_LOGIC := '0';
	signal enable : STD_LOGIC := '0';
	signal operation_completed : STD_LOGIC := '0';
	signal enable_r : STD_LOGIC := '0';
	signal write_completed : STD_LOGIC := '0';
	signal state : STD_LOGIC_VECTOR(5 downto 0) := (others => '0');

begin

	-- Instantiate the CU_REG_OUT module
	TB_CU_REG_OUT : CU_REG_OUT port map (clk, reset, enable, operation_completed, enable_r, write_completed, state);
	
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
		
		operation_completed <= '0';
		wait for CLK_PERIOD;
		
		operation_completed <= '1';
		wait for CLK_PERIOD;
		
		operation_completed <= '0';
		wait for CLK_PERIOD * 2; 
		
		operation_completed <= '0';
		
	end process;

end TB_CU_REG_OUT_behavior;
