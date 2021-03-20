-- Code your design here
library IEEE;
use IEEE.std_logic_1164.all;
USE ieee.numeric_std.ALL;
use work.mia_simple_fifo_synch_R.all;

ENTITY WR_Ctrl IS
   PORT
   (
      CLK           : IN   std_logic;
      
      wr_rst        : IN   std_logic;
	  RD_bit		: IN   std_logic;
      we            : IN   std_logic;
      
      we_out        : OUT  std_logic
      
      
   );
END WR_Ctrl;

ARCHITECTURE rtl OF WR_Ctrl IS
 	type state_type is (STA,STB,STC);		-- STATE A, STATE B, STATE C
	signal PS,NS : state_type;				-- PS = Current State  
    signal S     : std_logic;
BEGIN

sync_proc: process(CLK,NS)
begin
	if(rising_edge(CLK)) then
    	if (wr_rst = '1') then
            PS <= STA;
        else
         	PS <= NS;
        end if;
	end if;
end process sync_proc;

comb_proc: process(PS,RD_bit,we)
begin
-- we_out: the Moore output
	S <= '0';  -- pre-assign the outputs
    case PS is
        when STA => -- items regarding state ST0
        	S <= '0';
            if (RD_bit = '0') then NS <= STB; 
            else NS <= STA;
            end if;
        when STB => -- items regarding state ST1
        	S <= we;
            if (RD_bit = '1') then NS <= STA;
            else NS <= STB;
            end if;
        when others => -- the catch all condition
             S <= '0';
             NS <= STA;
	end case;
end process comb_proc;

we_out <= S;

   
END rtl;