library ieee;
use ieee.std_logic_1164.all;
use std.env.all;
use work.mia_simple_fifo_synch_R.all;



entity testbench_WR_Controller is
end entity testbench_WR_Controller;

architecture tb of testbench_WR_Controller is

  signal clk  : std_logic := '0'; 
  
  ---------------------------------------------
  ----------------WR_Ctrl----------------------
  signal    wr_rst     :     std_logic:= '0';
  signal    RD_bit	   :     std_logic := '1';
  signal    we         :     std_logic := '0';
  signal    we_out     :     std_logic;
  ---------------------------------------------
  
  
  signal done : boolean := false;
  constant CLK_PERIOD : time := 1 ns; 
    
begin

  WR_Controller: WR_Ctrl
  port map(clk=>clk, wr_rst =>wr_rst, RD_bit=>RD_bit ,we => we,we_out=>we_out); 
    
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
    for i in 0 to 1 loop
      RD_bit <= not(RD_bit);
	  we <= '1';
      wait for 3*CLK_PERIOD;
      
      wr_rst <= not(wr_rst);
      wait for 1*CLK_PERIOD;
    end loop;   
    

    
    done <= true;
    report "All DONE";
    wait for CLK_PERIOD;   
    
    finish;
  end process;
  
end architecture tb;
