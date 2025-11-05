# Auto-detect all Verilog and SystemVerilog files
SRCS := $(wildcard *.v *.sv)

# Automatically guess the top module = testbench (last file alphabetically)
TOP ?= $(basename $(notdir $(word $(words $(SRCS)), $(SRCS))))

# Tools
VLIB = vlib
VMAP = vmap
VLOG = vlog
VSIM = vsim

# Default target
all: compile simulate

compile:
	$(VLIB) work
	$(VMAP) work work
	$(VLOG) $(SRCS)

simulate:
	$(VSIM) -c $(TOP) -do "run -all; quit"

gui:
	$(VSIM) $(TOP) -voptargs=+acc -do "add wave *; run -all"

clean:
	rm -rf work transcript vsim.wlf *.log
