NVC=nvc
SRC_DIR=../src
VHDL_STD=08
DUT=RgbVideo

VHDL_SRC= $(SRC_DIR)/HVSync.vhd \
		  $(SRC_DIR)/$(DUT).vhd \
		  $(SRC_DIR)/$(DUT)_tb.vhd

simuwave: $(DUT)_tb.vcd

work-obj$(VHDL_STD).cf: $(VHDL_SRC)
	time $(NVC) --std=2008 -a $(VHDL_SRC)

$(DUT)_tb.vcd: work-obj$(VHDL_STD).cf
	time $(NVC) --std=2008 -e RgbVideo_tb
	time $(NVC) --std=2008 -r RgbVideo_tb

clean:
	-rm -r work
