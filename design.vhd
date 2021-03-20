-- Code your design here
library IEEE;
use IEEE.std_logic_1164.all;
USE ieee.numeric_std.ALL;
use work.mia_simple_fifo_synch_R.all;

entity mia_simple_fifo_synch is
port
( 
         wr_rst    : in std_logic; -- Asynchronous reset. Include a reset synchronizer for this!
         wr_clk    : in std_logic;
         wr_en     : in std_logic;
         wr_data   : in std_logic_vector(15 downto 0);
         wr_busy   : out std_logic;
         
         rd_rst    : in std_logic; -- Asynchronous reset. Include a reset synchronizer for this!
         rd_clk    : in std_logic;
         rd_valid  : out std_logic; -- Qualifies rd_data as valid. Pulses for 1 clock cycle when the data changes.
         rd_data   : out std_logic_vector(15 downto 0)
);

END mia_simple_fifo_synch;

ARCHITECTURE rtl OF mia_simple_fifo_synch IS
signal wr_rst_sync : std_logic;
signal rd_rst_sync : std_logic;

signal rd_bit      : std_logic;
signal wr_bit      : std_logic;

signal we_out      : std_logic;
signal re_out      : std_logic;

signal wr_address  : std_logic_vector(9 Downto 0);
signal rd_address  : std_logic_vector(9 Downto 0);

signal Mux_in_1    : std_logic_vector(15 downto 0);
signal rd_valid_i  : std_logic;
BEGIN

  Write_RST_Sinchroniser: Sinchroniser
    port map(ref_clk=>wr_clk, areset =>wr_rst, sync_reset=>wr_rst_sync); 
  Read_RST_Sinchroniser: Sinchroniser
    port map(ref_clk=>rd_clk, areset =>rd_rst, sync_reset=>rd_rst_sync); 
  
  WR_CTRL1: WR_Ctrl
    port map(clk=>wr_clk, wr_rst =>wr_rst_sync, RD_bit=>rd_bit ,we => wr_en,we_out=>we_out);
  RD_CTRL1: RD_Ctrl
    port map(clk=>rd_clk, rd_rst =>rd_rst_sync, WR_bit=>wr_bit ,re_out=>re_out);    
    
  -- It will sinchronise the we_out bit with the read clock to introduce it in the read controller
  Write_Bit_Sinchroniser: Sinchroniser
    port map(ref_clk=>rd_clk, areset =>we_out, sync_reset=>wr_bit); 
  -- It will sinchronise the rd_out bit with the write clock to introduce it in the write controller  
  Read_Bit_Sinchroniser: Sinchroniser
    port map(ref_clk=>wr_clk, areset =>re_out, sync_reset=>rd_bit);   
    
    
   SDPRAM: ram_infer
    port map(
             rd_clk=>rd_clk, wr_clk => wr_clk,
             wr_en => we_out, rd_en => re_out,
             data => wr_data,
             write_address => wr_address, read_address =>rd_address, 
             q => rd_data
             );
             
             
             
    wr_busy <= we_out;      
    
   Write_FSM: FSM_Address
     port map(CLK=>wr_clk,rst => wr_rst_sync, enable =>we_out, address_out=>wr_address);
     
   Read_FSM: FSM_Address
     port map(CLK=>rd_clk,rst => rd_rst_sync, enable =>re_out, address_out=>rd_address);
             
    
    Registers: for i in 0 to 15 generate
        FF_Out:d_ff
        port map(clk=>rd_clk, D => rd_data(i), rst=>'1', Q=>Mux_in_1(i));
    end generate Registers;
    
    process(rd_data)
    begin
        if (rd_data/=Mux_in_1) then
           rd_valid_i <= '1';
        else
           rd_valid_i <= '0';
        end if;
        
    end process;
    
    FF_Out:d_ff
    port map(clk=>rd_clk, D => rd_valid_i, rst=>'1', Q=>rd_valid);
           
        	
    
END rtl;