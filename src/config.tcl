# User config
set script_dir [file dirname [file normalize [info script]]]

# has to match the module name from wokwi
set ::env(DESIGN_NAME) scan_wrapper_341176884318437971

# save some time
set ::env(RUN_KLAYOUT_XOR) 0
set ::env(RUN_KLAYOUT_DRC) 0

# don't put clock buffers on the outputs
set ::env(PL_RESIZER_BUFFER_OUTPUT_PORTS) 0

# allow use of specific sky130 cells
set ::env(SYNTH_READ_BLACKBOX_LIB) 1

# HACK: explicitly specify which files we are using, ignore TB etc.
set ::env(VERILOG_FILES) "$::env(DESIGN_DIR)/user_module_341176884318437971.v \
$::env(DESIGN_DIR)/scan_wrapper_341176884318437971.v"

# absolute die size
set ::env(FP_SIZING) absolute
set ::env(DIE_AREA) "0 0 105 105"
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
set ::env(CLOCK_PERIOD) "10"
set ::env(CLOCK_PORT) ""

set ::env(BASE_SDC_FILE) $::env(DESIGN_DIR)/base.sdc

set ::env(SYNTH_CLOCK_UNCERTAINITY) 0.20
set ::env(SYNTH_CLOCK_TRANSITION)   0.15

# don't use power rings or met5
set ::env(DESIGN_IS_CORE) 0
set ::env(RT_MAX_LAYER) {met4}

# connect to first digital rails
set ::env(VDD_NETS) [list {vccd1}]
set ::env(GND_NETS) [list {vssd1}]
