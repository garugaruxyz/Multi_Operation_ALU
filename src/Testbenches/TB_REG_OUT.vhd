-------------------------------------------------------------------------------
--
-- Title       : TB_REG_OUT
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

entity TB_REG_OUT is
end TB_REG_OUT;

architecture TB_REG_OUT_behavior of TB_REG_OUT is

	-- Testbench components
	component REG_OUT is
		generic(Nb : integer);
		port(
			clk : in STD_LOGIC;
			reset : in STD_LOGIC;
			enable_pipo_r : in STD_LOGIC;
			data_in : in STD_LOGIC_VECTOR(Nb-1 downto 0);
			data_out : out STD_LOGIC_VECTOR(Nb-1 downto 0)
		);
	end component REG_OUT;
	
	-- Testbench constants
	constant CLK_PERIOD : time := 10 ns;
	constant N : integer := 4;
	
	-- Testbench signals
	signal clk : STD_LOGIC := '0';
	signal reset : STD_LOGIC := '0';
	signal enable_pipo_r : STD_LOGIC := '0';
	signal data_in : STD_LOGIC_VECTOR(N-1 downto 0) := (others => '0');
	signal data_out : STD_LOGIC_VECTOR(N-1 downto 0) := (others => '0');

begin

	-- Instantiate the REG_IN module
	TB_REG_OUT : REG_OUT generic map (N) port map (clk, reset, enable_pipo_r, data_in, data_out);
	
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
		wait for CLK_PERIOD * 6;
		reset <= not reset;
    end process;
	
	-- Main process
    main_process: process
    begin
		
        wait for CLK_PERIOD;
		
		enable_pipo_r <= '1';
		data_in <= "1010";
        wait for CLK_PERIOD;
		
		data_in <= "0001";
		wait for CLK_PERIOD;
		
		enable_pipo_r <= '0';
		data_in <= "1111";
        wait for CLK_PERIOD;

    end process;

end TB_REG_OUT_behavior;
