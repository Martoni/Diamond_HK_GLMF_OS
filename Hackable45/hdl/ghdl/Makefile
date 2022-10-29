GHDL=ghdl
SRC_DIR=../src
VHDL_STD=08
DUT=RgbVideo

VHDL_SRC= $(SRC_DIR)/HVSync.vhd \
		  $(SRC_DIR)/$(DUT).vhd \
		  $(SRC_DIR)/$(DUT)_tb.vhd

simuwave: $(DUT)_tb.vcd 

work-obj$(VHDL_STD).cf: $(VHDL_SRC)
	$(GHDL) -a --std=08 $(VHDL_SRC) 

$(DUT)_tb.vcd: work-obj$(VHDL_STD).cf
	$(GHDL) -r --std=08 RgbVideo_tb --vcd=$(DUT)_tb.vcd

clean:
	-rm work-*
	-rm *.vcd
