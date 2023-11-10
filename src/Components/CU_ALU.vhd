-------------------------------------------------------------------------------
--
-- Title       : CU_ALU
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

entity CU_ALU is
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
end CU_ALU;

architecture CU_ALU_behavior of CU_ALU is

	type statetype is (STANDBY, READ_OPERATION, OPERATION, A_PLUS_B, A_MINUS_B, B_MINUS_A, CA2_A, CA2_B, A_PLUS_B_DONE, A_MINUS_B_DONE, B_MINUS_A_DONE, CA2_A_DONE, CA2_B_DONE); 
	signal currentstate, nextstate : statetype;

begin

	cu_main : process(currentstate, read_completed, count_o, operation_code, write_completed)
	
		variable outs : STD_LOGIC_VECTOR(6 downto 0);
		variable outs_state : STD_LOGIC_VECTOR(5 downto 0);
	
	begin
		
		case currentstate is
			when STANDBY => outs := "0000000"; outs_state := "010000";
				case read_completed is
					when '1' => nextstate <= READ_OPERATION;
					when others => nextstate <= STANDBY;
				end case;
			when READ_OPERATION => outs := "1100000"; outs_state := "010001";
				case count_o is
					when '1' => nextstate <= OPERATION;
					when others => nextstate <= READ_OPERATION;
				end case;
			when OPERATION => outs := "0000000"; outs_state := "010010";
				case operation_code is
					when "000" => nextstate <= A_PLUS_B;
					when "001" => nextstate <= A_MINUS_B;
					when "010" => nextstate <= B_MINUS_A;
					when "101" => nextstate <= CA2_B;
					when "110" => nextstate <= CA2_A;
					when others => nextstate <= READ_OPERATION;
				end case;
			when A_PLUS_B => outs := "0001011"; outs_state := "010011";
				nextstate <= A_PLUS_B_DONE;
			when A_MINUS_B => outs := "0001101"; outs_state := "010100";
				nextstate <= A_MINUS_B_DONE;
			when B_MINUS_A => outs := "0010011"; outs_state := "010101";
				nextstate <= B_MINUS_A_DONE;
			when CA2_B => outs := "0000101"; outs_state := "010110";
				nextstate <= CA2_B_DONE;
			when CA2_A => outs := "0010001"; outs_state := "010111";
				nextstate <= CA2_A_DONE;
			when A_PLUS_B_DONE => outs := "0001010"; outs_state := "011000";
				case write_completed is
					when '1' => nextstate <= READ_OPERATION;
					when others => nextstate <= A_PLUS_B_DONE;
				end case;
			when A_MINUS_B_DONE => outs := "0001100"; outs_state := "011001";
				case write_completed is
					when '1' => nextstate <= READ_OPERATION;
					when others => nextstate <= A_MINUS_B_DONE;
				end case;
			when B_MINUS_A_DONE => outs := "0010010"; outs_state := "011010";
				case write_completed is
					when '1' => nextstate <= READ_OPERATION;
					when others => nextstate <= B_MINUS_A_DONE;
				end case;
			when CA2_B_DONE => outs := "0000100"; outs_state := "011011";
				case write_completed is
					when '1' => nextstate <= READ_OPERATION;
					when others => nextstate <= CA2_B_DONE;
				end case;
			when CA2_A_DONE => outs := "0010000"; outs_state := "011100";
				case write_completed is
					when '1' => nextstate <= READ_OPERATION;
					when others => nextstate <= CA2_A_DONE;
				end case;
		end case;
		
		enable_o <= outs(6);
		reset_counter <= outs(5);
		op_a <= outs(4 downto 3);
		op_b <= outs(2 downto 1);
		operation_completed <= outs(0);
		state <= outs_state;
		
	end process;
	
	cu_reset : process(clk, reset)
	begin
		if reset='0' then
   			currentstate <= STANDBY;
   		elsif rising_edge(clk) and enable = '1' then
            currentstate <= nextstate;
		end if;
	end process;

end CU_ALU_behavior;
