#include <assert.h>
#include <iostream>     // Pour std::cout
#include <fstream>      // pour enregistrer le fichier image
#include <verilated.h>  // (1) Routines Verilator
#include <verilated_vcd_c.h> // (15) dump VCD
#include "VRgbVideo.h"  // (2) Description des interfaces

using namespace std;

// chemin du fichier image (dans la RAM)
#define FIMAGENAME "/tmp/verilator_img.ppm"
#define VGA640X480
//#define VGA800X600
//(19)
//#define VCDDUMP

/* (3) */
class SimMain {
    public:
        VRgbVideo *top;           // (4) Le modèle
        vluint64_t main_time = 0; // (5) Temps de simulation
        int linecount = 0;
        int columncount = 0;

        void step(int n=1); // (6) pas

        SimMain(VRgbVideo *top, string fimagename);
        ~SimMain();
    private:
#ifdef VCDDUMP
	VerilatedVcdC* tfp; // (16) fichier de dump vcd
#endif

        ofstream *fimage;
        void low_cycle(void);
        void high_cycle(void);
        void half_cycle(int clk_value);
        void read_pixel(void);
        void write_img_header(void);
};

SimMain::SimMain(VRgbVideo *top, string fimagename)
    : top(top){

    // ouverture du fichier image
    // et écriture de l'entête ppm
    fimage = new ofstream(fimagename);
    write_img_header();

#ifdef VCDDUMP
    /* (17) ouverture du fichier de dump */
    Verilated::traceEverOn(true);
    tfp = new VerilatedVcdC;
    top->trace(tfp, 99);
    tfp->open("rgbvideo.vcd");
#endif
};

SimMain::~SimMain(){
    if(fimage != NULL)
        fimage->close();

#ifdef VCDDUMP
    if(tfp != NULL)
        tfp->close();
#endif
}

#ifdef VGA640X480
//H_DISPLAY + H_FRONT + H_BACK
#define HMAX 688
//V_DISPLAY + V_TOP + V_BOTTOM
#define VMAX 494
#endif
#ifdef VGA800X600
#define HMAX (800+53+61)
#define VMAX (600+21+35)
#endif

void
SimMain::write_img_header(void) {
    *fimage << "P3" << endl;
    *fimage << "# verilator_img.ppm" << endl;
    *fimage << HMAX << " " << VMAX << endl;
    *fimage << "1" << endl;
}

/* (9) Enregistrement des pixels de l'image */
void
SimMain::read_pixel(void) {
    if(top->vsync_o == 1 && top->hsync_o == 1) {
	if(linecount != 0) {
	    *fimage << " " << (int)top->red_o;
	    *fimage << " " << (int)top->green_o;
	    *fimage << " " << (int)top->blue_o;
	}
        columncount++;
    } else if(columncount != 0) {
        linecount++;
        columncount = 0;
        *fimage << endl;
    }
}

void
SimMain::low_cycle(void){
    half_cycle(0);
}

void
SimMain::high_cycle(void){
    half_cycle(1);
}

void
SimMain::half_cycle(int clk_value){
    assert(clk_value == 1 || clk_value == 0);
    top->clk_i = clk_value; // (8)
    top->eval();  // fonction d'évaluation
}

/* (7) */
void
SimMain::step(int n) {
    int i;
    for(i=0; i < n; i++){
        low_cycle();
        read_pixel();
        high_cycle();
#ifdef VCDDUMP
	tfp->dump(main_time); // (18) dump vcd des signaux
#endif
        main_time++;  // Incrémentation du temps
    }
}

/* (10) fonction principale */
int main(int argc, char** argv) {
    VRgbVideo top;  // Instantiation du module testé
    SimMain sm(&top, FIMAGENAME); // création de l'objet testbench

    /* (11) */
    top.rst_i = 1;// écriture de 1 dans le signal
    sm.step(5);   // 5 cycles de reset
    top.rst_i = 0;

    // (12) attente de la montée de vsync_o
    while(top.vsync_o != 1)
        sm.step();

    // (13)
    while(top.vsync_o == 1){
        sm.step();
    }
    // (14)
    cout << "Step " << sm.main_time << " : end of test" << endl;
    cout << "linecount " << sm.linecount << endl;
    top.final(); // Fin de la simulation
}
