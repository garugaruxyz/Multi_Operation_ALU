-------------------------------------------------------------------------------
--
-- Title       : TB_6_MO_ALU
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

entity TB_6_MO_ALU is
end TB_6_MO_ALU;

architecture TB_6_MO_ALU_behavior of TB_6_MO_ALU is

	-- Testbench components
	component MO_ALU is
		generic (Nb : integer);
		port(
			clk : in STD_LOGIC;
			reset : in STD_LOGIC;
			enable : in STD_LOGIC;
			data_in : in STD_LOGIC;
			control_bit : in STD_LOGIC;
			a : out STD_LOGIC_VECTOR(Nb-1 downto 0);
			b : out STD_LOGIC_VECTOR(Nb-1 downto 0);
			result : out STD_LOGIC_VECTOR(Nb-1 downto 0);
			state_reg_in : out STD_LOGIC_VECTOR(5 downto 0);
			state_alu : out STD_LOGIC_VECTOR(5 downto 0);
			state_reg_out : out STD_LOGIC_VECTOR(5 downto 0)
		);
	end component MO_ALU;
	
	-- Testbench constant
	constant CLK_PERIOD : time := 10 ns;
	constant N : integer := 4;
	
	-- Testbench signals
	signal clk : STD_LOGIC := '0';
	signal reset : STD_LOGIC := '0';
	signal enable : STD_LOGIC := '0';
	signal data_in : STD_LOGIC := '0';
	signal control_bit : STD_LOGIC := '0';
	signal a : STD_LOGIC_VECTOR(N-1 downto 0) := (others => '0');
	signal b : STD_LOGIC_VECTOR(N-1 downto 0) := (others => '0');
	signal result : STD_LOGIC_VECTOR(N-1 downto 0) := (others => '0');
	signal state_reg_in : STD_LOGIC_VECTOR(5 downto 0) := (others => '0');
	signal state_alu : STD_LOGIC_VECTOR(5 downto 0) := (others => '0');
	signal state_reg_out : STD_LOGIC_VECTOR(5 downto 0) := (others => '0');

begin

	-- Instantiate the MO_ALU module
	TB_MO_ALU : MO_ALU generic map (N) port map (clk, reset, enable, data_in, control_bit, a, b, result, state_reg_in, state_alu, state_reg_out);
	
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
		wait for CLK_PERIOD * 20;
		enable <= not enable;
    end process;
	
	-- Reset process
    reset_process: process
    begin
        wait for CLK_PERIOD;
		reset <= not reset;
		wait for CLK_PERIOD * 22;
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
		
		data_in <= '1';
		wait for CLK_PERIOD; 
		data_in <= '0';
		wait for CLK_PERIOD;
		data_in <= '1';
		wait for CLK_PERIOD;
		data_in <= '1';
		wait for CLK_PERIOD; -- End read A -- A = "1011" = -5
		
		data_in <= '0';
		wait for CLK_PERIOD; 
		data_in <= '1';
		wait for CLK_PERIOD;
		data_in <= '0';
		wait for CLK_PERIOD;
		data_in <= '0';
		wait for CLK_PERIOD; -- End read B -- B = "0100" = 4

		data_in <= '0';		
		wait for CLK_PERIOD;
		
		control_bit <= '0';
		wait for CLK_PERIOD;
		control_bit <= '1';
		wait for CLK_PERIOD;
		control_bit <= '1';
		wait for CLK_PERIOD; -- End read OP -- OP = "011" = ERROR
	
		wait for CLK_PERIOD * 2; -- Wait for Result to be written
		
		control_bit <= '1';
		wait for CLK_PERIOD;
		control_bit <= '1';
		wait for CLK_PERIOD;
		control_bit <= '1';
		wait for CLK_PERIOD; -- End read OP -- OP = "111" = ERROR
		
		control_bit <= '0';
		
	end process;

end TB_6_MO_ALU_behavior;
