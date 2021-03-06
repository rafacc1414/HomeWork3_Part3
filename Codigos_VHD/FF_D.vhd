-----------------------------------
-- Model of a simple D Flip-Flop --
-----------------------------------
-- library declaration
library IEEE;
use IEEE.std_logic_1164.all;
use work.mia_simple_fifo_synch_R.all;


-- entity
entity d_ff is
	port (  
    		CLK     : in  std_logic;
    		D 	    : in  std_logic;		
    		rst 	: in  std_logic;		    -- enable
		  	Q 	    : out std_logic
       );
end d_ff;

-- architecture
architecture my_d_ff of d_ff is
signal S	: std_logic:= '0';			--Intermidieate Signal
begin
  dff: process(CLK)
  begin
    if (rising_edge(CLK)) then
    	if(rst = '1') then
    		S <= D;
        else
        	S <= '0';
        end if;
  end if;
  end process dff;
  
  Q <= S;
  
end my_d_ff;