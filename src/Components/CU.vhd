-------------------------------------------------------------------------------
--
-- Title       : CU
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

entity CU is
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
end CU;

architecture CU_behavior of CU is

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
	
	component NbCounter is
		generic(Nb : integer);
		port(
			clk : in STD_LOGIC;
			reset : in STD_LOGIC;
			enable : in STD_LOGIC;
			out_count : out STD_LOGIC
		);
	end component NbCounter;
	
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
	
	signal reset_counter_reg : STD_LOGIC := '0';
	signal enable_reg_a : STD_LOGIC := '0';
	signal count_a : STD_LOGIC := '0';
	signal enable_reg_b : STD_LOGIC := '0';
	signal count_b : STD_LOGIC := '0';
	signal reset_counter_op : STD_LOGIC := '0';
	signal enable_reg_op : STD_LOGIC := '0';
	signal count_op : STD_LOGIC := '0';
	signal operation_code : STD_LOGIC_VECTOR(2 downto 0) := (others => '0');
	signal data_read : STD_LOGIC := '0';
	signal data_wrote : STD_LOGIC := '0';
	signal op_done : STD_LOGIC := '0';
	
begin

	counter_a : NbCounter generic map (Nb) port map (clk, reset_counter_reg, enable_reg_a, count_a);
	counter_b : NbCounter generic map (Nb) port map (clk, reset_counter_reg, enable_reg_b, count_b);
	counter_op : NbCounter generic map (3) port map (clk, reset_counter_op, enable_reg_op, count_op);
	
	sipo_op : SIPO generic map (3) port map (clk, reset, enable_reg_op, control_bit, operation_code);
	
	fsm_reg_in : CU_REG_IN port map (clk, reset, enable, control_bit, count_a, count_b, enable_reg_a, enable_reg_b, reset_counter_reg, data_read, state_reg_in);
	fsm_alu : CU_ALU port map (clk, reset, enable, data_read, count_op, operation_code, data_wrote, enable_reg_op, reset_counter_op, op_a, op_b, op_done, state_alu);
	fsm_reg_out : CU_REG_OUT port map (clk, reset, enable, op_done, enable_r, data_wrote, state_reg_out);
	
	enable_a <= enable_reg_a;
	enable_b <= enable_reg_b;
	
end CU_behavior;
