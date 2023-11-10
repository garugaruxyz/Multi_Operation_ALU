-------------------------------------------------------------------------------
--
-- Title       : CU_REG_OUT
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

entity CU_REG_OUT is
	port(
		clk : in STD_LOGIC;
		reset : in STD_LOGIC;
		enable : in STD_LOGIC;
		operation_completed : in STD_LOGIC;
		enable_r : out STD_LOGIC;
		write_completed : out STD_LOGIC;
		state : out STD_LOGIC_VECTOR(5 downto 0)
	);
end CU_REG_OUT;

architecture CU_REG_OUT_behavior of CU_REG_OUT is

	type statetype is (STANDBY, WRITE_R, WRITE_DONE); 
	signal currentstate, nextstate : statetype;

begin

	cu_main : process(currentstate, operation_completed)
	
		variable outs : STD_LOGIC_VECTOR(1 downto 0);
		variable outs_state : STD_LOGIC_VECTOR(5 downto 0);
	
	begin
		
		case currentstate is
			when STANDBY =>	outs := "00"; outs_state := "100000";
				case operation_completed is
					when '1' => nextstate <= WRITE_R;
					when others => nextstate <= STANDBY;
				end case;
			when WRITE_R =>	outs := "10"; outs_state := "100001";
				nextstate <= WRITE_DONE;
			when WRITE_DONE => outs := "01"; outs_state := "100010";
				nextstate <= STANDBY;
		end case;
		
		enable_r <= outs(1);
		write_completed <= outs(0);
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

end CU_REG_OUT_behavior;
