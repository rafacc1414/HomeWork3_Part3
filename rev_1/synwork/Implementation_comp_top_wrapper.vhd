--
-- Synopsys
-- Vhdl wrapper for top level design, written on Sat Mar 20 18:41:19 2021
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.mia_simple_fifo_synch_r.all;

entity wrapper_for_mia_simple_fifo_synch is
   port (
      wr_rst : in std_logic;
      wr_clk : in std_logic;
      wr_en : in std_logic;
      wr_data : in std_logic_vector(15 downto 0);
      wr_busy : out std_logic;
      rd_rst : in std_logic;
      rd_clk : in std_logic;
      rd_valid : out std_logic;
      rd_data : out std_logic_vector(15 downto 0)
   );
end wrapper_for_mia_simple_fifo_synch;

architecture rtl of wrapper_for_mia_simple_fifo_synch is

component mia_simple_fifo_synch
 port (
   wr_rst : in std_logic;
   wr_clk : in std_logic;
   wr_en : in std_logic;
   wr_data : in std_logic_vector (15 downto 0);
   wr_busy : out std_logic;
   rd_rst : in std_logic;
   rd_clk : in std_logic;
   rd_valid : out std_logic;
   rd_data : out std_logic_vector (15 downto 0)
 );
end component;

signal tmp_wr_rst : std_logic;
signal tmp_wr_clk : std_logic;
signal tmp_wr_en : std_logic;
signal tmp_wr_data : std_logic_vector (15 downto 0);
signal tmp_wr_busy : std_logic;
signal tmp_rd_rst : std_logic;
signal tmp_rd_clk : std_logic;
signal tmp_rd_valid : std_logic;
signal tmp_rd_data : std_logic_vector (15 downto 0);

begin

tmp_wr_rst <= wr_rst;

tmp_wr_clk <= wr_clk;

tmp_wr_en <= wr_en;

tmp_wr_data <= wr_data;

wr_busy <= tmp_wr_busy;

tmp_rd_rst <= rd_rst;

tmp_rd_clk <= rd_clk;

rd_valid <= tmp_rd_valid;

rd_data <= tmp_rd_data;



u1:   mia_simple_fifo_synch port map (
		wr_rst => tmp_wr_rst,
		wr_clk => tmp_wr_clk,
		wr_en => tmp_wr_en,
		wr_data => tmp_wr_data,
		wr_busy => tmp_wr_busy,
		rd_rst => tmp_rd_rst,
		rd_clk => tmp_rd_clk,
		rd_valid => tmp_rd_valid,
		rd_data => tmp_rd_data
       );
end rtl;
