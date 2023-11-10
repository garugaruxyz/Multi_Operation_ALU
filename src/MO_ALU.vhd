-------------------------------------------------------------------------------
--
-- Title       : MO_ALU
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

entity MO_ALU is
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
end MO_ALU;

architecture MO_ALU_behavior of MO_ALU is

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
	
	signal enable_a : STD_LOGIC := '0';
	signal enable_b : STD_LOGIC := '0';
	signal reg_data_out_a : STD_LOGIC_VECTOR(Nb-1 downto 0) := (others => '0');
	signal reg_data_out_b : STD_LOGIC_VECTOR(Nb-1 downto 0) := (others => '0');
	signal op_a : STD_LOGIC_VECTOR(1 downto 0) := (others => '0');
	signal op_b : STD_LOGIC_VECTOR(1 downto 0) := (others => '0');
	signal alu_data_out : STD_LOGIC_VECTOR(Nb-1 downto 0) := (others => '0');
	signal enable_r : STD_LOGIC := '0';

begin

	r_in : REG_IN generic map (Nb) port map (clk, reset, enable_a, enable_b, data_in, reg_data_out_a, reg_data_out_b);
	op_alu : ALU generic map (Nb) port map (reg_data_out_a, reg_data_out_b, op_a, op_b, alu_data_out);
	r_out : REG_OUT generic map (Nb) port map (clk, reset, enable_r, alu_data_out, result);
	
	fsm : CU generic map (Nb) port map (clk, reset, enable, control_bit, enable_a, enable_b, op_a, op_b, enable_r, state_reg_in, state_alu, state_reg_out);
	
	a <= reg_data_out_a;
	b <= reg_data_out_b;

end MO_ALU_behavior;
