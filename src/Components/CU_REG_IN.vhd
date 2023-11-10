-------------------------------------------------------------------------------
--
-- Title       : CU_REG_IN
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

entity CU_REG_IN is
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
end CU_REG_IN;

architecture CU_REG_IN_behavior of CU_REG_IN is

	type statetype is (STANDBY, READ_A, READ_B, READ_DONE); 
	signal currentstate, nextstate : statetype;
	
begin

	cu_main : process(currentstate, control_bit, count_a, count_b)
	
		variable outs : STD_LOGIC_VECTOR(3 downto 0);
		variable outs_state : STD_LOGIC_VECTOR (5 downto 0);
	
	begin
		
		case currentstate is
			when STANDBY => outs := "0000"; outs_state := "000000";
				case control_bit is
					when '1' => nextstate <= READ_A;
					when others => nextstate <= STANDBY;
				end case;
			when READ_A => outs := "1010"; outs_state := "000001";
				case count_a is
					when '1' => nextstate <= READ_B;
					when others => nextstate <= READ_A;
				end case;
			when READ_B => outs := "0110"; outs_state := "000010";
				case count_b is
					when '1' => nextstate <= READ_DONE;
					when others => nextstate <= READ_B;
				end case;
			when READ_DONE => outs := "0001"; outs_state := "000011";
				nextstate <= READ_DONE;
		end case;
		
		enable_a <= outs(3);
		enable_b <= outs(2);
		reset_counter <= outs(1);
		read_completed <= outs(0);
		state <= outs_state;
		
	end process;
	
	cu_reset : process(clk, reset, enable)
	begin
		if reset='0' then
   			currentstate <= STANDBY;
   		elsif rising_edge(clk) and enable = '1' then
            currentstate <= nextstate;
		end if;
	end process;
	
end CU_REG_IN_behavior;
