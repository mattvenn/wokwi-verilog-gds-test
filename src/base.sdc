# Create a clock for the scan chain @ 200 MHz
create_clock -name clk_scan_in -period 5 [get_ports {clk_in}]
create_generated_clock -name clk_scan_out -source clk_in -combinational [get_ports {clk_out}]

# Scan chain input  1.9 ns setup time, -0.1 ns hold time
set_input_delay  -min -0.1 -clock [get_clocks clk_scan_in]  [get_ports {data_in}] 
set_input_delay  -max  1.9 -clock [get_clocks clk_scan_in]  [get_ports {data_in}] 

# Scan chain output 2.1 ns setup time, 0.1 ns hold time
set_output_delay -min -0.1 -clock [get_clocks clk_scan_out] [get_ports {data_out}]
set_output_delay -max  2.1 -clock [get_clocks clk_scan_out] [get_ports {data_out}]

# Misc
set_max_fanout $::env(SYNTH_MAX_FANOUT) [current_design]

if { ![info exists ::env(SYNTH_CLK_DRIVING_CELL)] } {
    set ::env(SYNTH_CLK_DRIVING_CELL) $::env(SYNTH_DRIVING_CELL)
}

if { ![info exists ::env(SYNTH_CLK_DRIVING_CELL_PIN)] } {
    set ::env(SYNTH_CLK_DRIVING_CELL_PIN) $::env(SYNTH_DRIVING_CELL_PIN)
}

set_driving_cell -lib_cell $::env(SYNTH_DRIVING_CELL) -pin $::env(SYNTH_DRIVING_CELL_PIN) [get_ports {data_in scan_select_in latch_enable_in}]
set_driving_cell -lib_cell $::env(SYNTH_CLK_DRIVING_CELL) -pin $::env(SYNTH_CLK_DRIVING_CELL_PIN) [get_ports {clk_in}]

set cap_load [expr $::env(SYNTH_CAP_LOAD) / 1000.0]
puts "\[INFO\]: Setting load to: $cap_load"
set_load  $cap_load [all_outputs]

puts "\[INFO\]: Setting clock uncertainity to: $::env(SYNTH_CLOCK_UNCERTAINITY)"
set_clock_uncertainty $::env(SYNTH_CLOCK_UNCERTAINITY) [get_clocks {clk_sys clk_scan_in clk_scan_out}]

puts "\[INFO\]: Setting clock transition to: $::env(SYNTH_CLOCK_TRANSITION)"
set_clock_transition $::env(SYNTH_CLOCK_TRANSITION) [get_clocks {clk_sys clk_scan_in clk_scan_out}]

puts "\[INFO\]: Setting timing derate to: [expr {$::env(SYNTH_TIMING_DERATE) * 100}] %"
set_timing_derate -early [expr {1-$::env(SYNTH_TIMING_DERATE)}]
set_timing_derate -late [expr {1+$::env(SYNTH_TIMING_DERATE)}]
