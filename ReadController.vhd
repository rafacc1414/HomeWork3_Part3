-- Code your design here
library IEEE;
use IEEE.std_logic_1164.all;
USE ieee.numeric_std.ALL;
use work.mia_simple_fifo_synch_R.all;

ENTITY RD_Ctrl IS
   PORT
   (
      CLK           : IN   std_logic;
      
      rd_rst        : IN   std_logic;
	  WR_bit		: IN   std_logic;
      
      re_out        : OUT  std_logic
      
      
   );
END RD_Ctrl;

ARCHITECTURE rtl OF RD_Ctrl IS
 	type state_type is (STA,STB,STC);		-- STATE A, STATE B, STATE C
	signal PS,NS : state_type;				-- PS = Current State  
    signal S     : std_logic;
BEGIN

sync_proc: process(CLK,NS)
begin
	if(rising_edge(CLK)) then
    	if (rd_rst = '1') then
            PS <= STA;
        else
         	PS <= NS;
        end if;
	end if;
end process sync_proc;

comb_proc: process(PS,WR_bit)
begin
-- we_out: the Moore output
	S <= '0';  -- pre-assign the outputs
    case PS is
        when STA => -- items regarding state ST0
        	S <= '0';
            if (WR_bit = '0') then NS <= STB; 
            else NS <= STA;
            end if;
        when STB => -- items regarding state ST1
        	S <= '1';
            if (WR_bit = '1') then NS <= STA;
            else NS <= STB;
            end if;
        when others => -- the catch all condition
             S <= '0';
             NS <= STA;
	end case;
end process comb_proc;

re_out <= S;

   
END rtl;