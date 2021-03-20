-- Code your design here
library IEEE;
use IEEE.std_logic_1164.all;
USE ieee.numeric_std.ALL;
use work.mia_simple_fifo_synch_R.all;


-- entity
entity Sinchroniser is
	port (  
    		ref_clk         : in  std_logic;
    		areset 	        : in  std_logic;		
		  	sync_reset 	    : out std_logic
       );
end Sinchroniser;

-- architecture
architecture rtl of Sinchroniser is
signal S	: std_logic:= '0';			--Intermidieate Signal
begin

  FF1:d_ff
    port map(clk=>ref_clk, D => '1', rst=>areset, Q=>S);
  FF2:d_ff
    port map(clk=>ref_clk, D => S, rst=>areset, Q=>sync_reset);    
end rtl;