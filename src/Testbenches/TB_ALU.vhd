-------------------------------------------------------------------------------
--
-- Title       : TB_ALU
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

entity TB_ALU is
end TB_ALU;

architecture TB_ALU_behavior of TB_ALU is

	-- Testbench components
	component ALU is
		generic (Nb : integer);
		port(
			a : in STD_LOGIC_VECTOR(Nb-1 downto 0);
			b : in STD_LOGIC_VECTOR(Nb-1 downto 0);
			op_a : in STD_LOGIC_VECTOR(1 downto 0);
			op_b : in STD_LOGIC_VECTOR(1 downto 0);
			r : out STD_LOGIC_VECTOR(Nb-1 downto 0)
		);
	end component ALU;
	
	-- Testbench constant
	constant CLK_PERIOD : time := 10 ns;
	constant N : integer := 4;
	
	-- Testbench signals
	signal a : STD_LOGIC_VECTOR(N-1 downto 0) := (others => '0');
	signal b : STD_LOGIC_VECTOR(N-1 downto 0) := (others => '0');
	signal op_a : STD_LOGIC_VECTOR(1 downto 0) := (others => '0');
	signal op_b : STD_LOGIC_VECTOR(1 downto 0) := (others => '0');
	signal r : STD_LOGIC_VECTOR(N-1 downto 0) := (others => '0');

begin
	
	-- Instantiate the ALU module
	TB_ALU : ALU generic map (N) port map (a, b, op_a, op_b, r);
	
	-- Main process
	main_process: process
	begin
		
		wait for CLK_PERIOD;
		
		a <= "0010";
		b <= "0101";
		op_a <= "01";
		op_b <= "01";
		wait for CLK_PERIOD;
		
		op_a <= "01";
		op_b <= "10";
		wait for CLK_PERIOD;

		op_a <= "10";
		op_b <= "01";
		wait for CLK_PERIOD;
		
		op_a <= "10";
		op_b <= "00";
		wait for CLK_PERIOD;
		
		op_a <= "00";
		op_b <= "10";
		
	end process;
	
	

end TB_ALU_behavior;
