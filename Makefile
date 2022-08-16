# HACK: We need a unique ID for the verilog files so they can exist harmoniously with the rest of the
# designs that are submitted. So, even if we're not using Wokwi, copy the template project and enter
# the ID below as the WOKWI_PROJECT_ID so we get a guaranteed unique ID:
WOKWI_PROJECT_ID=339898704941023827

fetch:
# HACK: we don't need to fetch this as we have our own verilog source, manually created: src/user_module_339898704941023827.v
#	curl https://wokwi.com/api/projects/$(WOKWI_PROJECT_ID)/verilog > src/user_module_$(WOKWI_PROJECT_ID).v
	sed -e 's/USER_MODULE_ID/$(WOKWI_PROJECT_ID)/g' template/scan_wrapper.v > src/scan_wrapper_$(WOKWI_PROJECT_ID).v
# HACK: instead of globbing the entire src directory, specify modules explicitly in custom config.tcl
#	sed -e 's/USER_MODULE_ID/$(WOKWI_PROJECT_ID)/g' template/config.tcl > src/config.tcl
	echo $(WOKWI_PROJECT_ID) > src/ID

# needs PDK_ROOT and OPENLANE_ROOT, OPENLANE_IMAGE_NAME set from your environment
harden:
	docker run --rm \
	-v $(OPENLANE_ROOT):/openlane \
	-v $(PDK_ROOT):$(PDK_ROOT) \
	-v $(CURDIR):/work \
	-e PDK_ROOT=$(PDK_ROOT) \
	-u $(shell id -u $(USER)):$(shell id -g $(USER)) \
	$(OPENLANE_IMAGE_NAME) \
	/bin/bash -c "./flow.tcl -overwrite -design /work/src -run_path /work/runs -tag wokwi"
