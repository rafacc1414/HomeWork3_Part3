-- Code your design here
library IEEE;
use IEEE.std_logic_1164.all;
USE ieee.numeric_std.ALL;
use work.mia_simple_fifo_synch_R.all;


ENTITY ram_infer IS
   PORT
   (
      rd_clk        : IN   std_logic;
      wr_clk        : IN   std_logic;
      
      wr_en         : IN   std_logic;
      rd_en         : IN   std_logic;
      data          : IN   std_logic_vector (15 DOWNTO 0);
      write_address	: IN   std_logic_vector (9 DOWNTO 0); -- 10 bits = 1024 directions
      read_address	: IN   std_logic_vector (9 DOWNTO 0); -- 10 bits = 1024 directions
      
      q				:OUT  std_logic_vector (15 DOWNTO 0)
   );
END ram_infer;
ARCHITECTURE rtl OF ram_infer IS
   TYPE mem IS ARRAY(0 TO 1023) OF std_logic_vector(15 DOWNTO 0);
   SIGNAL ram_block : mem;
   attribute syn_ramstyle : string;
   attribute syn_ramstyle of ram_block : signal is "no_rw_check";
BEGIN

WRITE:PROCESS (wr_clk)
   BEGIN
      IF (wr_clk'event AND wr_clk = '1' AND wr_en = '1') THEN
        ram_block(to_integer(unsigned(write_address))) <= data; --WRITE
      END IF;
   END PROCESS WRITE;

READ:PROCESS (rd_clk)
   BEGIN
      IF (rd_clk'event AND rd_clk = '1' and rd_en = '1') THEN
         q <= ram_block(to_integer(unsigned(read_address))); -- READ
      END IF;
   END PROCESS READ;

   
END rtl;