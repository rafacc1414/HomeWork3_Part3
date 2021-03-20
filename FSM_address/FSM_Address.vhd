-- Code your design here
library IEEE;
use IEEE.std_logic_1164.all;
USE ieee.numeric_std.ALL;
use work.mia_simple_fifo_synch_R.all;

ENTITY FMS_Address IS
   PORT
   (
      CLK            : IN   std_logic;
      rst            : IN   std_logic;
	  enable		 : IN   std_logic;
      
      address_out    : OUT  std_logic_vector(9 Downto 0)
      
      
   );
END FMS_Address;

ARCHITECTURE rtl OF FMS_Address IS
 	type state_type is (STA,STB,STC);		-- STATE A, STATE B, STATE C
	signal PS,NS : state_type;				-- PS = Current State  
    signal S     : std_logic_vector(9 Downto 0);
BEGIN

sync_proc: process(CLK,NS)
begin
	if(rising_edge(CLK)) then
    	if (rst = '0') then
            PS <= STC;
        else
         	PS <= NS;
        end if;
	end if;
end process sync_proc;

comb_proc: process(PS,enable)
variable my_int : integer range 0 to 1024;
begin

	S <= "0000000000";  -- pre-assign the output
    case PS is
        when STA => 
        	S <= S;
            if (enable = '1') then NS <= STB; 
            else NS <= STA;
            end if;
        when STB => 
        	my_int := (to_integer(unsigned(S)) + 1 );
            S <= std_logic_vector(to_unsigned(my_int, S'length));
            if (enable = '0') then NS <= STA;
            else NS <= STB;
            end if;
        when STC => 
            S <= "0000000000";
            if (enable = '0') then NS <= STA;
            else NS <= STB;
            end if;
        when others => -- the catch all condition
             S <= S;
             NS <= STA;
	end case;
end process comb_proc;

address_out <= S;

   
END rtl;