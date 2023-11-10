-------------------------------------------------------------------------------
--
-- Title       : TB_CU
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

entity TB_CU is
end TB_CU;

architecture TB_CU_behavior of TB_CU is

	-- Testbench components
	component CU is
		generic (Nb : integer);
		port(
			clk : in STD_LOGIC;
			reset : in STD_LOGIC;
			enable : in STD_LOGIC;
			control_bit : in STD_LOGIC;
			enable_a : out STD_LOGIC;
			enable_b : out STD_LOGIC;
			op_a : out STD_LOGIC_VECTOR(1 downto 0);
			op_b : out STD_LOGIC_VECTOR(1 downto 0);
			enable_r : out STD_LOGIC;
			state_reg_in : out STD_LOGIC_VECTOR(5 downto 0);
			state_alu : out STD_LOGIC_VECTOR(5 downto 0);
			state_reg_out : out STD_LOGIC_VECTOR(5 downto 0)
		);
	end component CU;
	
	-- Testbench constant
	constant CLK_PERIOD : time := 10 ns;
	constant N : integer := 4;
	
	-- Testbench signals
	signal clk : STD_LOGIC := '0';
	signal reset : STD_LOGIC := '0';
	signal enable : STD_LOGIC := '0';
	signal control_bit : STD_LOGIC := '0';
	signal enable_a : STD_LOGIC := '0';
	signal enable_b : STD_LOGIC := '0';
	signal op_a : STD_LOGIC_VECTOR(1 downto 0) := (others => '0');
	signal op_b : STD_LOGIC_VECTOR(1 downto 0) := (others => '0');
	signal enable_r : STD_LOGIC := '0';
	signal state_reg_in : STD_LOGIC_VECTOR(5 downto 0) := (others => '0');
	signal state_alu : STD_LOGIC_VECTOR(5 downto 0) := (others => '0');
	signal state_reg_out : STD_LOGIC_VECTOR(5 downto 0) := (others => '0');

begin

	-- Instantiate the CU module
	TB_CU : CU generic map (N) port map (clk, reset, enable, control_bit, enable_a, enable_b, op_a, op_b, enable_r, state_reg_in, state_alu, state_reg_out);
	
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
		wait for CLK_PERIOD * 28;
		enable <= not enable;
    end process;
	
	-- Reset process
    reset_process: process
    begin
        wait for CLK_PERIOD;
		reset <= not reset;
		wait for CLK_PERIOD * 30;
		reset <= not reset;
    end process;
	
	-- Main process
    main_process: process
    begin

		wait for CLK_PERIOD;
		
		control_bit <= '0';
		wait for CLK_PERIOD;
		
		control_bit <= '1';
		wait for CLK_PERIOD;
		
	end process;
	
end TB_CU_behavior;
