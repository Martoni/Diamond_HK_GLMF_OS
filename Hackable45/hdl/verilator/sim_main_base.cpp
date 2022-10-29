#include <verilated.h>  // Routines Verilator
#include <iostream>     // Pour std::cout
#include "VRgbVideo.h"  // Description des interfaces

using namespace std;
VRgbVideo *top;           // Le modèle
vluint64_t main_time = 0; // Temps de simulation

int main(int argc, char** argv) {

    top = new VRgbVideo; // Création de l'objet
    top->rst_i = 1;        // écriture de 1 dans le signal
    for(int i=0; i < 100; i++){
        if (main_time > 2) {
            top->rst_i = 0;   // Deassert reset
        }
        if ((main_time % 10) == 1) {
            top->clk_i = 1;       // Toggle clk_i
            cout << "Step " << main_time;
            cout << ": rst_i -> ";
            cout << (int)top->rst_i;
            cout << " : vsync -> ";
            cout << (int)top->vsync_o;
            cout << " : hsync -> ";
            cout << (int)top->hsync_o;
            cout << " : hpos_count -> ";
            cout << (int)top->RgbVideo__DOT__hvs__DOT__hpos_count;
            cout << " : vpos_count -> ";
            cout << (int)top->RgbVideo__DOT__hvs__DOT__vpos_count;
            cout << endl;
        }
        if ((main_time % 10) == 6) {
            top->clk_i = 0;
        }
        top->eval();  // fonction d'évaluation
        main_time++;  // Incrémentation du temps
    }
    cout << "Step " << main_time << " : end of test";
    top->final(); // Fin de la simulation
    delete top;
}
