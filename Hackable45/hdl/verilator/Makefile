VERILATOR=verilator
GHDL_YOSYS_PLUGIN=/opt/ghdl-yosys-plugin/ghdl.so
GHDL=ghdl
YOSYS=yosys
TOP=RgbVideo
SRCDIR=../src
VHDLSRC=$(SRCDIR)/HVSync.vhd $(SRCDIR)/RgbVideo.vhd
VERILOGSRC=$(TOP).v
CPPSRC=sim_main.cpp

/tmp/verilator_img.ppm: obj_dir/$(TOP).cpp
	./obj_dir/V$(TOP)

obj_dir/$(TOP).cpp: $(VERILOGSRC) $(CPPSRC)
	$(VERILATOR) -cc $(VERILOGSRC) --exe --build -j $(CPPSRC)

$(VERILOGSRC): $(VHDLSRC)
	$(GHDL) -a $(VHDLSRC)
	$(YOSYS) -m $(GHDL_YOSYS_PLUGIN) -s vhdl2verilog.yosys

mrproper:
	-rm -rf obj_dir
	-rm work-obj93.cf
	-rm $(VERILOGSRC)
	-rm /tmp/verilator_img.ppm
