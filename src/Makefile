# from: https://gist.github.com/DurandA/15c83f37ee64b185801f88fbe0a0f25c

PROJ = user_module_339898704941023827
PIN_DEF = pins.pcf
DEVICE = lp8k
PACKAGE = cm81

all: $(PROJ).bin

%.json: %.v
	yosys -p 'synth_ice40 -top $(PROJ) -json $@' $<

%.asc: %.json $(PIN_DEF)
	nextpnr-ice40 --$(DEVICE) --package $(PACKAGE) --json $< --pcf $(PIN_DEF) --asc $@ --ignore-loops

%.bin: %.asc
	icepack $< $@

%.rpt: %.asc
	icetime -d $(DEVICE) -mtr $@ $<

%_tb: %_tb.v %.v
	iverilog -o $@ $^

%_tb.vcd: %_tb
	vvp -N $< +vcd=$@

%_syn.v: %.blif
	yosys -p 'read_blif -wideports $^; write_verilog $@'

%_syntb: %_tb.v %_syn.v
	iverilog -o $@ $^ `yosys-config --datdir/ice40/cells_sim.v`

%_syntb.vcd: %_syntb
	vvp -N $< +vcd=$@

prog: $(PROJ).bin
	tinyprog -p $<

sudo-prog: $(PROJ).bin
	@echo 'Executing prog as root!!!'
	sudo tinyprog -p $<

clean:
	rm -f $(PROJ).blif $(PROJ).asc $(PROJ).rpt $(PROJ).bin $(PROJ).json $(PROJ)_tb.vvp $(PROJ)_tb.vcd

.SECONDARY:
.PHONY: all prog clean
