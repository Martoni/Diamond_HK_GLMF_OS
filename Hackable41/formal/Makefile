TOP_MODULE=fifo
GHDL_PLUGIN=/opt/ghdl-yosys-plugin/ghdl.so
SBY=sby

SRC_DIR=../src/
VHDL_SRC=$(SRC_DIR)/fifo.vhd

.PHONY: all bmc cover prove

all: bmc cover prove

bmc: $(TOP_MODULE)_bmc/PASS  

cover: $(TOP_MODULE)_cover/PASS

prove: $(TOP_MODULE)_prove/PASS
	
$(TOP_MODULE)_bmc/PASS:  $(TOP_MODULE).sby $(VHDL_SRC) $(TOP_MODULE).psl
	$(SBY) --yosys "yosys -m $(GHDL_PLUGIN)" -f $(TOP_MODULE).sby bmc

$(TOP_MODULE)_cover/PASS:  $(TOP_MODULE).sby $(VHDL_SRC) $(TOP_MODULE).psl
	$(SBY) --yosys "yosys -m $(GHDL_PLUGIN)" -f $(TOP_MODULE).sby cover 

$(TOP_MODULE)_prove/PASS:  $(TOP_MODULE).sby $(VHDL_SRC) $(TOP_MODULE).psl
	$(SBY) --yosys "yosys -m $(GHDL_PLUGIN)" -f $(TOP_MODULE).sby prove

mrproper:
	-rm -r $(TOP_MODULE)
	-rm -r $(TOP_MODULE)_bmc
	-rm -r $(TOP_MODULE)_cover
	-rm -r $(TOP_MODULE)_prove
