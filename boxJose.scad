use<lasercutDrawer/box.scad>

materialThickness = 6;
drawerW = 150;
drawerH = 30;
drawerD = 100;
fingerLength = materialThickness;
marginBetweenCuts = 1;
dottedMargin = materialThickness;
boxNoLid(drawerW, drawerD, drawerH, materialThickness, fingerLength=fingerLength, dottedMargin=dottedMargin, marginBetweenCuts=marginBetweenCuts, laserRemoves=0.1, inside=true);