(Original readme for the template repository [here](https://github.com/mattvenn/wokwi-verilog-gds-test/blob/main/README.md))

This repo is an experiment in using Verilog source files instead of Wokwi diagrams for [TinyTapeout](tinytapeout.com). If you're interested in doing the same, make sure to edit the top level Makefile and replace `WOKWI_PROJECT_ID` with one that you generate so it doesn't clash with this repo.

Hardware used for testing this demo project is the TinyFPGA BX, install the [OSS CAD Suite](https://github.com/YosysHQ/oss-cad-suite-build) and issue `make` under `src/` to generate bitstream to load on hardware.

