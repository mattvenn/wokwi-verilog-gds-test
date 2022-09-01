#!/bin/sh
iverilog -gspecify -gstrict-ca-eval -Wall -Winfloop -D__SIM__ -o frog \
    frog_tb.v \
    ../src/user_module_341476989274686036.v \
    && ./frog -fst && gtkwave frog.vcd
