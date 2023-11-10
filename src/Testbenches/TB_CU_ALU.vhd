-------------------------------------------------------------------------------
--
-- Title       : TB_CU_ALU
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

entity TB_CU_ALU is
end TB_CU_ALU;

architecture TB_CU_ALU_behavior of TB_CU_ALU is

	-- Testbench components
	component CU_ALU is
		port(
			clk : in STD_LOGIC;
			reset : in STD_LOGIC;
			enable : in STD_LOGIC;
			read_completed : in STD_LOGIC;
			count_o : in STD_LOGIC;
			operation_code : in STD_LOGIC_VECTOR(2 downto 0);
			write_completed : in STD_LOGIC;
			enable_o : out STD_LOGIC;
			reset_counter : out STD_LOGIC;
			op_a : out STD_LOGIC_VECTOR(1 downto 0);
			op_b : out STD_LOGIC_VECTOR(1 downto 0);
			operation_completed : out STD_LOGIC;
			state : out STD_LOGIC_VECTOR(5 downto 0)
		);
	end component CU_ALU;
	
	-- Testbench constant
	constant CLK_PERIOD : time := 10 ns;
	
	-- Testbench signals
	signal clk : STD_LOGIC := '0';
	signal reset : STD_LOGIC := '0';
	signal enable : STD_LOGIC := '0';
	signal read_completed : STD_LOGIC := '0';
	signal count_o : STD_LOGIC := '0';
	signal operation_code : STD_LOGIC_VECTOR(2 downto 0) := (others => '0');
	signal write_completed : STD_LOGIC := '0';
	signal enable_o : STD_LOGIC := '0';
	signal reset_counter : STD_LOGIC := '0';
	signal op_a : STD_LOGIC_VECTOR(1 downto 0) := (others => '0');
	signal op_b : STD_LOGIC_VECTOR(1 downto 0) := (others => '0');
	signal operation_completed : STD_LOGIC := '0';
	signal state : STD_LOGIC_VECTOR(5 downto 0) := (others => '0');
	
begin

	-- Instantiate the CU_ALU module
	TB_CU_ALU : CU_ALU port map (clk, reset, enable, read_completed, count_o, operation_code, write_completed, enable_o, reset_counter, op_a, op_b, operation_completed, state);
	
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
		wait for CLK_PERIOD * 12;
		enable <= not enable;
    end process;
	
	-- Reset process
    reset_process: process
    begin
        wait for CLK_PERIOD;
		reset <= not reset;
		wait for CLK_PERIOD * 15;
		reset <= not reset;
    end process;
	
	-- Main process
    main_process: process
    begin

		wait for CLK_PERIOD;
		
		read_completed <= '0';
		wait for CLK_PERIOD;
		
		read_completed <= '1';
		wait for CLK_PERIOD * 3;
		
		count_o <= '1';
		wait for CLK_PERIOD;
		
		count_o <= '0';
		operation_code <= "000";
		wait for CLK_PERIOD * 2;
		
		write_completed <= '1';
		wait for CLK_PERIOD;
		
		write_completed <= '0';
		wait for CLK_PERIOD * 2;
		
		count_o <= '1';
		wait for CLK_PERIOD;
		
		count_o <= '0';
		operation_code <= "010";
		wait for CLK_PERIOD * 2;
		
		write_completed <= '1';
		wait for CLK_PERIOD;
		
		write_completed <= '0';
		
	end process;
	
end TB_CU_ALU_behavior;
