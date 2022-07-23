VERILATOR=verilator
TOP=RgbVideo
SRCDIR=../src
VERILOGSRC=$(SRCDIR)/$(TOP).v $(SRCDIR)/HVSync.v
CPPSRC=sim_main.cpp


obj_dir/$(TOP).cpp: $(VERILOGSRC) $(CPPSRC)
	#$(VERILATOR) -O3 --x-assign fast --x-initial fast --noassert -Wall -cc $(VERILOGSRC) --exe --build -j $(CPPSRC)
	$(VERILATOR) --trace -Wall -cc $(VERILOGSRC) --exe --build -j $(CPPSRC)

mrproper:
	-rm -rf obj_dir
