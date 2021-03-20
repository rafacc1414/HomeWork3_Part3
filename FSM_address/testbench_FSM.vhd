library ieee;
use ieee.std_logic_1164.all;
use std.env.all;
use work.mia_simple_fifo_synch_R.all;



entity testbench_FMS_Address is
end entity testbench_FMS_Address;

architecture tb of testbench_FMS_Address is

  signal clk  : std_logic := '0'; 
  
  ---------------------------------------------
  ----------------WR_Ctrl----------------------
  --signal    ref_clk         :   std_logic;
  signal    enable		   :    std_logic;
  signal    address_out    :    std_logic_vector(9 Downto 0);
  ---------------------------------------------
  
  
  signal done : boolean := false;
  constant CLK_PERIOD : time := 1 ns; 
    
begin

  Write_FSM: FSM_Address
  port map(CLK=>clk, enable =>enable, address_out=>address_out); 
    
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
	
    enable <= '1';
    wait for 2* CLK_PERIOD;
    enable <= '0';
    wait for CLK_PERIOD;
    enable <= '1';
    wait for CLK_PERIOD;
    enable <= '0';
    wait for CLK_PERIOD;
    
    done <= true;
    report "All DONE";
    wait for CLK_PERIOD;   
    
    finish;
  end process;
  
end architecture tb;