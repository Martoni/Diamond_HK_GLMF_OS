Verilator, le simulateur Verilog le plus rapide du monde
--------------------------------------------------------

Sources pour l'article de [Hackable43](https://connect.ed-diamond.com/hackable/hk-043/verilator-le-simulateur-verilog-le-plus-rapide-du-monde)

* Pour lancer la simulation icarus :

```bash
cd hdl/icarus/
make
```
On peut ensuite visualiser les chronogrammes avec gtkwave :

```bash
gtkwave -a icarus_wave_cfg.gtkw
```

* Pour lancer la simulation verilator :

```bash
cd hdl/verilator
make
./obj_dir/VRgbVideo
```

Pour visualiser les chronogrammes il faut activer les traces dans `sim_main.cpp`:

```
#define VCDDUMP
```

Et recompiler puis exécuter le programme. Le fichier de traces se nomme `rgbvideo.vcd` et se visualise également avec gtkwave.


```bash
gtkwave rgbvideo.vcd
```
