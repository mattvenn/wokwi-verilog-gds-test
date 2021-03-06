# User config
set script_dir [file dirname [file normalize [info script]]]

# has to match the module name from wokwi
set ::env(DESIGN_NAME) scan_wrapper

# save some time
set ::env(RUN_KLAYOUT_XOR) 0
set ::env(RUN_KLAYOUT_DRC) 0

# don't put clock buffers on the outputs
set ::env(PL_RESIZER_BUFFER_OUTPUT_PORTS) 0

# allow use of specific sky130 cells
set ::env(SYNTH_READ_BLACKBOX_LIB) 1

# Change if needed
set ::env(VERILOG_FILES) "$::env(DESIGN_DIR)/wokwi.v \
    $::env(DESIGN_DIR)/scan_wrapper.v \
    $::env(DESIGN_DIR)/cells.v"

set ::env(FP_SIZING) absolute
set ::env(DIE_AREA) "0 0 100 100"
set ::env(FP_CORE_UTIL) 45

# Fill this
set ::env(CLOCK_PERIOD) "100"
set ::env(CLOCK_PORT) "clk"

set ::env(DESIGN_IS_CORE) 0
set ::env(RT_MAX_LAYER) {met4}

set ::env(VDD_NETS) [list {vccd1}]
set ::env(GND_NETS) [list {vssd1}]
