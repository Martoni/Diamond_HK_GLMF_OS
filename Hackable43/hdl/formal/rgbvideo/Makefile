TOP_MODULE=rgbvideo
SBY=sby

SRC_DIR=../../src/

VERILOG_SRC=$(SRC_DIR)/$(TOP_MODULE).v

.PHONY: all bmc cover prove

all: bmc cover prove

bmc: $(TOP_MODULE)_bmc/PASS  

cover: $(TOP_MODULE)_cover/PASS

prove: $(TOP_MODULE)_prove/PASS
	
$(TOP_MODULE)_bmc/PASS:  $(TOP_MODULE).sby $(VERILOG_SRC)
	$(SBY) $(TOP_MODULE).sby bmc

$(TOP_MODULE)_cover/PASS:  $(TOP_MODULE).sby $(VERILOG_SRC)
	$(SBY) $(TOP_MODULE).sby cover 

$(TOP_MODULE)_prove/PASS:  $(TOP_MODULE).sby
	$(SBY) $(TOP_MODULE).sby prove

mrproper:
	-rm -r $(TOP_MODULE)
	-rm -r $(TOP_MODULE)_bmc
	-rm -r $(TOP_MODULE)_cover
	-rm -r $(TOP_MODULE)_prove
