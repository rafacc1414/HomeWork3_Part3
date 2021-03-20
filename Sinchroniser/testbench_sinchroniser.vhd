library ieee;
use ieee.std_logic_1164.all;
use std.env.all;
use work.mia_simple_fifo_synch_R.all;


entity testbench_Sinchroniser is
end entity testbench_Sinchroniser;

architecture tb of testbench_Sinchroniser is

  signal clk  : std_logic := '0'; 
  
  ---------------------------------------------
  ----------------WR_Ctrl----------------------
  --signal    ref_clk         :   std_logic;
  signal    areset 	        :   std_logic;
  signal    sync_reset 	    :   std_logic;
  ---------------------------------------------
  
  
  signal done : boolean := false;
  constant CLK_PERIOD : time := 1 ns; 
    
begin

  Write_Sinchroniser: Sinchroniser
  port map(ref_clk=>clk, areset =>areset, sync_reset=>sync_reset); 
    
    -- Clock Generator Process--
  clk_gen: process(clk)
  begin
    if not done then
      clk <= not clk after CLK_PERIOD/2;
    else
      clk <= '0';
    end if;
  end process clk_gen;
  
  -- Stimulus Generator Process--
  stim_gen: process
  begin
    ------------------------------------------------------------
    -----------------Inputs RISCV_Register_file SIMULATION------
	
    areset <= '1';
    wait for 2ns;
    areset <= '0';
    wait for 1ns;
    areset <= '1';
    wait for 1.5ns;
    areset <= '0';
    wait for 3.5ns;
    
    done <= true;
    report "All DONE";
    wait for CLK_PERIOD;   
    
    finish;
  end process;
  
end architecture tb;