# Set the project ID for Wokwi, some examples:
#  - 334445762078310996: Logic puzzle and muxes
#  - 334348818476696146: Four inverters
#  - 334335179919196756: Clock divider
#
WOKWI_PROJECT_ID = 334445762078310996

# ======== In most cases, changes don't need to be made below this line ========

# ==============================================================================
# Flow Setup
# ==============================================================================

# NOTE: GDS & lint stages require 'PDK_ROOT' to be set

SRC_DIR        ?= src
USER_MOD_PATH  ?= $(SRC_DIR)/user_module_$(WOKWI_PROJECT_ID).v
SCAN_WRAP_PATH ?= $(SRC_DIR)/scan_wrapper_$(WOKWI_PROJECT_ID).v
CFG_TCL_PATH   ?= $(SRC_DIR)/config.tcl
PROJ_ID_PATH   ?= $(SRC_DIR)/ID

# Verilator (for lint)
VERILATOR_TAG        ?= 4.106
VERILATOR_IMAGE_NAME ?= verilator/verilator:$(LINT_DOCKER_TAG)

# Openlane (for generating GDS)
# NOTE: These variables are overridden by the Github action (in wokwi.yaml)
OPENLANE_TAG        ?= 2022.02.23_02.50.41
OPENLANE_IMAGE_NAME ?= efabless/openlane:$(OPENLANE_TAG)
OPENLANE_ROOT       ?= /home/runner/openlane

# ==============================================================================
# Fetch: Grab RTL from the Wokwi Project
# ==============================================================================

.PHONY: fetch
fetch:
	curl https://wokwi.com/api/projects/$(WOKWI_PROJECT_ID)/verilog > $(USER_MOD_PATH)
	sed -e 's/USER_MODULE_ID/$(WOKWI_PROJECT_ID)/g' template/scan_wrapper.v > $(SCAN_WRAP_PATH)
	sed -e 's/USER_MODULE_ID/$(WOKWI_PROJECT_ID)/g' template/config.tcl > $(CFG_TCL_PATH)
	echo $(WOKWI_PROJECT_ID) > $(PROJ_ID_PATH)

$(USER_MOD_PATH) $(SCAN_WRAP_PATH) $(CFG_TCL_PATH) $(PROJ_ID_PATH): fetch

# ==============================================================================
# Verilator Lint
# ==============================================================================

# Docker configuration
LINT_LAUNCH += docker run --rm
LINT_LAUNCH += -v $(PDK_ROOT):$(PDK_ROOT):ro
LINT_LAUNCH += -v $(CURDIR):$(CURDIR):ro
LINT_LAUNCH += -e PDK_ROOT=$(PDK_ROOT)
LINT_LAUNCH += -u $(shell id -u $(USER)):$(shell id -g $(USER))
LINT_LAUNCH += $(VERILATOR_IMAGE_NAME)

# Run in lint mode
LINT_ARGS += --lint-only
# Enable all warnings
LINT_ARGS += -Wall
# Blackbox unsupported syntax (required as Verilator doesn't support primitive 'table')
LINT_ARGS += --bbox-unsup
# Lint configuration (switch off some warnings)
LINT_ARGS += $(abspath resources/lint.cfg)
# Setup the cell library
LINT_ARGS += -DFUNCTIONAL
LINT_ARGS += -DUSE_POWER_PINS
LINT_ARGS += -DUNIT_DELAY=#1
LINT_ARGS += $(PDK_ROOT)/sky130A/libs.ref/sky130_fd_sc_hd/verilog/primitives.v
LINT_ARGS += $(PDK_ROOT)/sky130A/libs.ref/sky130_fd_sc_hd/verilog/sky130_fd_sc_hd.v
LINT_ARGS += $(abspath src/cells.v)

.PHONY: lint
lint: | $(USER_MOD_PATH) $(SCAN_WRAP_PATH)
	@echo "# Running Verilator lint on $(USER_MOD_PATH)"
	$(LINT_LAUNCH) $(LINT_ARGS) \
	               $(abspath $(USER_MOD_PATH)) \
	               $(abspath $(SCAN_WRAP_PATH)) \
	               --top-module scan_wrapper_$(WOKWI_PROJECT_ID)

# ==============================================================================
# Harden: Use the Openlane flow to generate a GDS
# ==============================================================================

.PHONY: harden
harden:
	docker run --rm \
	           -v $(OPENLANE_ROOT):/openlane \
	           -v $(PDK_ROOT):$(PDK_ROOT) \
	           -v $(CURDIR):/work \
	           -e PDK_ROOT=$(PDK_ROOT) \
	           -u $(shell id -u $(USER)):$(shell id -g $(USER)) \
	           $(OPENLANE_IMAGE_NAME) \
	           /bin/bash -c "./flow.tcl -overwrite -design /work/src -run_path /work/runs -tag wokwi"
