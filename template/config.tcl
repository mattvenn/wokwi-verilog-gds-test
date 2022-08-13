# User config
set script_dir [file dirname [file normalize [info script]]]

# has to match the module name from wokwi
set ::env(DESIGN_NAME) scan_wrapper_USER_MODULE_ID

# save some time
set ::env(RUN_KLAYOUT_XOR) 0
set ::env(RUN_KLAYOUT_DRC) 0

# don't put clock buffers on the outputs
set ::env(PL_RESIZER_BUFFER_OUTPUT_PORTS) 0

# allow use of specific sky130 cells
set ::env(SYNTH_READ_BLACKBOX_LIB) 1

# read all verilog files
set ::env(VERILOG_FILES) [glob $::env(DESIGN_DIR)/*.v]

# absolute die size
set ::env(FP_SIZING) absolute
set ::env(DIE_AREA) "0 0 100 100"
set ::env(FP_CORE_UTIL) 45
set ::env(PL_BASIC_PLACEMENT) {1}

# use alternative efabless decap cells to solve LI density issue
set ::env(DECAP_CELL) "\
    sky130_fd_sc_hd__decap_3 \
    sky130_fd_sc_hd__decap_4 \
    sky130_fd_sc_hd__decap_6 \
    sky130_fd_sc_hd__decap_8 \
    sky130_ef_sc_hd__decap_12"

# clock
set ::env(CLOCK_PERIOD) "100"
set ::env(CLOCK_PORT) "clk"

# don't use power rings or met5
set ::env(DESIGN_IS_CORE) 0
set ::env(RT_MAX_LAYER) {met4}

# connect to first digital rails
set ::env(VDD_NETS) [list {vccd1}]
set ::env(GND_NETS) [list {vssd1}]
