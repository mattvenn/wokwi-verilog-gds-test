# User config
set script_dir [file dirname [file normalize [info script]]]

# has to match the module name from wokwi
set ::env(DESIGN_NAME) user_module

# save some time
set ::env(RUN_KLAYOUT_XOR) 0
set ::env(RUN_KLAYOUT_DRC) 0

# don't put clock buffers on the outputs, need tristates to be the final cells
set ::env(PL_RESIZER_BUFFER_OUTPUT_PORTS) 0

# Change if needed
set ::env(VERILOG_FILES) "$::env(DESIGN_DIR)/wokwi.v \
    $::env(DESIGN_DIR)/cells.v"

set ::env(FP_SIZING) absolute
set ::env(DIE_AREA) "0 0 70 70"
set ::env(PL_TARGET_DENSITY) 0.75

# Fill this
set ::env(CLOCK_PERIOD) "100"
set ::env(CLOCK_PORT) "clk"

set ::env(DESIGN_IS_CORE) 0
set ::env(RT_MAX_LAYER) {met4}

set ::env(VDD_NETS) [list {vccd1}]
set ::env(GND_NETS) [list {vssd1}]
