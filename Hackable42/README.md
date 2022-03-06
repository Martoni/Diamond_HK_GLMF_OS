De la preuve formelle en VHDL, librement
----------------------------------------

Sources de l'article Hackable 41.

# Howto

Pour lancer le moteur de preuve il suffit de se rendre dans le répertoire
formal et faire `make cover` (par exemple):

```bash
$ make cover
sby --yosys "yosys -m /opt/ghdl-yosys-plugin/ghdl.so" -f fifo.sby cover 
SBY  8:41:46 [fifo_cover] Removing directory 'fifo_cover'.
SBY  8:41:46 [fifo_cover] Copy '../src/fifo.vhd' to 'fifo_cover/src/fifo.vhd'.
SBY  8:41:46 [fifo_cover] Copy 'fifo.psl' to 'fifo_cover/src/fifo.psl'.
SBY  8:41:46 [fifo_cover] engine_0: smtbmc
SBY  8:41:46 [fifo_cover] base: starting process "cd fifo_cover/src; yosys -m /opt/ghdl-yosys-plugin/ghdl.so -ql ../model/design.log ../model/design.ys"
SBY  8:41:46 [fifo_cover] base: fifo.vhd:29:12:note: found RAM "circbuf", width: 8 bits, depth: 8
SBY  8:41:46 [fifo_cover] base: signal circbuf : t_circbuf_array;
SBY  8:41:46 [fifo_cover] base: ^
SBY  8:41:46 [fifo_cover] base: finished (returncode=0)
SBY  8:41:46 [fifo_cover] smt2: starting process "cd fifo_cover/model; yosys -m /opt/ghdl-yosys-plugin/ghdl.so -ql design_smt2.log design_smt2.ys"
SBY  8:41:46 [fifo_cover] smt2: finished (returncode=0)
SBY  8:41:46 [fifo_cover] engine_0: starting process "cd fifo_cover; yosys-smtbmc --presat --unroll -c --noprogress -t 40  --append 0 --dump-vcd engine_0/trace%.vcd --dump-vlogtb engine_0/trace%_tb.v --dump-smtc engine_0/trace%.smtc model/design_smt2.smt2"
SBY  8:41:46 [fifo_cover] engine_0: ##   0:00:00  Solver: yices
SBY  8:41:46 [fifo_cover] engine_0: ##   0:00:00  Checking cover reachability in step 0..
SBY  8:41:46 [fifo_cover] engine_0: ##   0:00:00  Reached cover statement at i_fifo.f_fullempty.cover in step 0.
SBY  8:41:46 [fifo_cover] engine_0: ##   0:00:00  Writing trace to VCD file: engine_0/trace0.vcd
SBY  8:41:46 [fifo_cover] engine_0: ##   0:00:00  Writing trace to Verilog testbench: engine_0/trace0_tb.v
SBY  8:41:46 [fifo_cover] engine_0: ##   0:00:00  Writing trace to constraints file: engine_0/trace0.smtc
SBY  8:41:46 [fifo_cover] engine_0: ##   0:00:00  Checking cover reachability in step 0..
SBY  8:41:46 [fifo_cover] engine_0: ##   0:00:00  Checking cover reachability in step 1..
SBY  8:41:47 [fifo_cover] engine_0: ##   0:00:00  Reached cover statement at i_fifo.f_empty_o.cover in step 1.
SBY  8:41:47 [fifo_cover] engine_0: ##   0:00:00  Writing trace to VCD file: engine_0/trace1.vcd
SBY  8:41:47 [fifo_cover] engine_0: ##   0:00:00  Writing trace to Verilog testbench: engine_0/trace1_tb.v
SBY  8:41:47 [fifo_cover] engine_0: ##   0:00:00  Writing trace to constraints file: engine_0/trace1.smtc
SBY  8:41:47 [fifo_cover] engine_0: ##   0:00:00  Checking cover reachability in step 1..
SBY  8:41:47 [fifo_cover] engine_0: ##   0:00:00  Checking cover reachability in step 2..
SBY  8:41:47 [fifo_cover] engine_0: ##   0:00:00  Checking cover reachability in step 3..
SBY  8:41:47 [fifo_cover] engine_0: ##   0:00:00  Checking cover reachability in step 4..
SBY  8:41:47 [fifo_cover] engine_0: ##   0:00:00  Checking cover reachability in step 5..
SBY  8:41:47 [fifo_cover] engine_0: ##   0:00:00  Checking cover reachability in step 6..
SBY  8:41:47 [fifo_cover] engine_0: ##   0:00:00  Checking cover reachability in step 7..
SBY  8:41:47 [fifo_cover] engine_0: ##   0:00:00  Checking cover reachability in step 8..
SBY  8:41:47 [fifo_cover] engine_0: ##   0:00:00  Reached cover statement at i_fifo.f_emptyfull.cover in step 8.
SBY  8:41:47 [fifo_cover] engine_0: ##   0:00:00  Writing trace to VCD file: engine_0/trace2.vcd
SBY  8:41:47 [fifo_cover] engine_0: ##   0:00:00  Writing trace to Verilog testbench: engine_0/trace2_tb.v
SBY  8:41:47 [fifo_cover] engine_0: ##   0:00:00  Writing trace to constraints file: engine_0/trace2.smtc
SBY  8:41:47 [fifo_cover] engine_0: ##   0:00:00  Checking cover reachability in step 8..
SBY  8:41:47 [fifo_cover] engine_0: ##   0:00:00  Checking cover reachability in step 9..
SBY  8:41:47 [fifo_cover] engine_0: ##   0:00:00  Checking cover reachability in step 10..
SBY  8:41:47 [fifo_cover] engine_0: ##   0:00:00  Checking cover reachability in step 11..
SBY  8:41:47 [fifo_cover] engine_0: ##   0:00:00  Checking cover reachability in step 12..
SBY  8:41:47 [fifo_cover] engine_0: ##   0:00:00  Checking cover reachability in step 13..
SBY  8:41:47 [fifo_cover] engine_0: ##   0:00:00  Checking cover reachability in step 14..
SBY  8:41:47 [fifo_cover] engine_0: ##   0:00:00  Checking cover reachability in step 15..
SBY  8:41:47 [fifo_cover] engine_0: ##   0:00:00  Checking cover reachability in step 16..
SBY  8:41:47 [fifo_cover] engine_0: ##   0:00:00  Checking cover reachability in step 17..
SBY  8:41:47 [fifo_cover] engine_0: ##   0:00:00  Checking cover reachability in step 18..
SBY  8:41:47 [fifo_cover] engine_0: ##   0:00:00  Checking cover reachability in step 19..
SBY  8:41:47 [fifo_cover] engine_0: ##   0:00:00  Checking cover reachability in step 20..
SBY  8:41:47 [fifo_cover] engine_0: ##   0:00:00  Checking cover reachability in step 21..
SBY  8:41:47 [fifo_cover] engine_0: ##   0:00:00  Checking cover reachability in step 22..
SBY  8:41:47 [fifo_cover] engine_0: ##   0:00:00  Reached cover statement at i_fifo.fc_full in step 22.
SBY  8:41:47 [fifo_cover] engine_0: ##   0:00:00  Writing trace to VCD file: engine_0/trace3.vcd
SBY  8:41:47 [fifo_cover] engine_0: ##   0:00:00  Writing trace to Verilog testbench: engine_0/trace3_tb.v
SBY  8:41:47 [fifo_cover] engine_0: ##   0:00:00  Writing trace to constraints file: engine_0/trace3.smtc
SBY  8:41:47 [fifo_cover] engine_0: ##   0:00:00  Status: passed
SBY  8:41:47 [fifo_cover] engine_0: finished (returncode=0)
SBY  8:41:47 [fifo_cover] engine_0: Status returned by engine: pass
SBY  8:41:47 [fifo_cover] summary: Elapsed clock time [H:MM:SS (secs)]: 0:00:01 (1)
SBY  8:41:47 [fifo_cover] summary: Elapsed process time [H:MM:SS (secs)]: 0:00:01 (1)
SBY  8:41:47 [fifo_cover] summary: engine_0 (smtbmc) returned pass
SBY  8:41:47 [fifo_cover] summary: trace: fifo_cover/engine_0/trace0.vcd
SBY  8:41:47 [fifo_cover] summary: trace: fifo_cover/engine_0/trace1.vcd
SBY  8:41:47 [fifo_cover] summary: trace: fifo_cover/engine_0/trace2.vcd
SBY  8:41:47 [fifo_cover] summary: trace: fifo_cover/engine_0/trace3.vcd
SBY  8:41:47 [fifo_cover] DONE (PASS, rc=0)
$
```
