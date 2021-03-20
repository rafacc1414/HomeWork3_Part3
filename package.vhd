library ieee;
use ieee.std_logic_1164.all;

package mia_simple_fifo_synch_R is

component WR_Ctrl IS
   PORT
   (
      CLK           : IN   std_logic;
      
      wr_rst        : IN   std_logic;
	  RD_bit		: IN   std_logic;
      we            : IN   std_logic;
      
      we_out        : OUT  std_logic
   );
END component WR_Ctrl;

component RD_Ctrl IS
   PORT
   (
      CLK           : IN   std_logic;
      
      rd_rst        : IN   std_logic;
	  WR_bit		: IN   std_logic;
      
      re_out        : OUT  std_logic
           
   );
END component RD_Ctrl;
    
 

component ram_infer IS
   PORT
   (
      rd_clk        : IN   std_logic;
      wr_clk        : IN   std_logic;
      
      wr_en         : IN   std_logic;
      rd_en         : IN   std_logic;
      data          : IN   std_logic_vector (15 DOWNTO 0);
      write_address	: IN   std_logic_vector (9 DOWNTO 0); -- 10 bits = 1024 directions
      read_address	: IN   std_logic_vector (9 DOWNTO 0); -- 10 bits = 1024 directions
      
      q				: OUT  std_logic_vector (15 DOWNTO 0)
   );
end component ram_infer;

component d_ff is
	port (  
    		CLK     : in  std_logic;
    		D 	    : in  std_logic;		
    		rst 	: in  std_logic;		    -- enable
		  	Q 	    : out std_logic
       );
end component d_ff;


component Sinchroniser is
	port (  
    		ref_clk         : in  std_logic;
    		areset 	        : in  std_logic;		
		  	sync_reset 	    : out std_logic
       );
end component Sinchroniser;

component FSM_Address IS
   PORT
   (
      CLK            : IN   std_logic;
      rst            : IN   std_logic;
	  enable		 : IN   std_logic;
      
      address_out    : OUT  std_logic_vector(9 Downto 0)
      
      
   );
END component FSM_Address;


end package mia_simple_fifo_synch_R;