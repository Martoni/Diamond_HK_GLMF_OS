# Comment faire

Ce document donne des indications complémentaires à l'[article de
Hackable](https://connect.ed-diamond.com/hackable/hk-044/transformez-votre-vieille-game-boy-en-console-de-salon-hdmi)
pour réaliser son adaptateur «GameBoy Switch» à soit.

## Modification adaptation manette SNES

Le schéma électronique complet est disponible en [pdf](GbSwitchFp_v1.01.pdf).
La modification à apporter pour l'adaptation des niveaux de tension est
disponible en rouge.  Il faut ajouter un SN74LVC2G14 et déconnecter les signaux
SNES_LATCH et SNES_CLOCK du convertisseur TXS0108 (`U2`).
