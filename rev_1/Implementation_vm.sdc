# Written by Synplify Pro version map202003act, Build 160R. Synopsys Run ID: sid1616262084 
# Top Level Design Parameters 

# Clocks 
create_clock -period 6.667 -waveform {0.000 3.333} -name {mia_simple_fifo_synch|rd_clk} [get_ports {rd_clk}] 
create_clock -period 6.667 -waveform {0.000 3.333} -name {FSM_Address_0|PS_inferred_clock[1]} [get_pins {Read_FSM/PS[0]/Q}] 
create_clock -period 6.667 -waveform {0.000 3.333} -name {mia_simple_fifo_synch|wr_clk} [get_ports {wr_clk}] 
create_clock -period 6.667 -waveform {0.000 3.333} -name {FSM_Address_1|PS_inferred_clock[1]} [get_pins {Write_FSM/PS[0]/Q}] 

# Virtual Clocks 

# Generated Clocks 

# Paths Between Clocks 

# Multicycle Constraints 

# Point-to-point Delay Constraints 

# False Path Constraints 

# Output Load Constraints 

# Driving Cell Constraints 

# Input Delay Constraints 

# Output Delay Constraints 

# Wire Loads 

# Other Constraints 

# syn_hier Attributes 

# set_case Attributes 

# Clock Delay Constraints 
set Inferred_clkgroup_0 [list mia_simple_fifo_synch|rd_clk]
set Inferred_clkgroup_1 [list FSM_Address_0|PS_inferred_clock\[1\]]
set Inferred_clkgroup_2 [list mia_simple_fifo_synch|wr_clk]
set Inferred_clkgroup_3 [list FSM_Address_1|PS_inferred_clock\[1\]]
set_clock_groups -asynchronous -group $Inferred_clkgroup_0
set_clock_groups -asynchronous -group $Inferred_clkgroup_1
set_clock_groups -asynchronous -group $Inferred_clkgroup_2
set_clock_groups -asynchronous -group $Inferred_clkgroup_3


# syn_mode Attributes 

# Cells 

# Port DRC Rules 

# Input Transition Constraints 

# Unused constraints (intentionally commented out) 


# Non-forward-annotatable constraints (intentionally commented out) 

# Block Path constraints 

