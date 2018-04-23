include <lasercutDrawer/box.scad>

materialThickness = 3;
//tabLength = 20;
//drawerW = 235;
//drawerH = 160;
//drawerD = 340;
tabLength = materialThickness*3;
tabMargin = 1;
drawerW = 50;
drawerH = 50;
drawerD = 50;

module klodskasse(w, h, d, materialThickness, tabLength=0,tabMargin=0) {
    fingerLength = materialThickness*2.5;
    marginBetweenCuts = 1;
    dottedMargin = materialThickness+tabLength ;
    difference() {
        boxNoLid(w, h+materialThickness, d, materialThickness, fingerLength, dottedMargin, marginBetweenCuts);
        translate([(d+materialThickness)*3+w/2-45, h-60]) {
            //handle();
            translate([w+marginBetweenCuts, 0]) {
                //handle();
            }
        }
        tabs(materialThickness, tabLength, drawerD, drawerW);

        tabLengthWithMargin = tabLength-tabMargin;
        
        translate([drawerD+marginBetweenCuts+tabLengthWithMargin, drawerH-materialThickness])
            square([drawerD-tabLengthWithMargin*2, materialThickness]);
        translate([(drawerD+marginBetweenCuts)*2+tabLengthWithMargin, drawerH-materialThickness])
            square([drawerD-tabLengthWithMargin*2, materialThickness]);
        translate([(drawerD+marginBetweenCuts)*3+tabLengthWithMargin, drawerH-materialThickness])
            square([drawerW-tabLengthWithMargin*2, materialThickness]);
        translate([(drawerD+marginBetweenCuts)*3+drawerW+marginBetweenCuts+tabLengthWithMargin, drawerH-materialThickness])
            square([drawerW-tabLengthWithMargin*2, materialThickness]);
    }
}

module tab(materialThickness, tabLength) {
        square([materialThickness, tabLength ]);
        square([tabLength , materialThickness]);
}

module tabs(materialThickness, tabLength, w, h) {
    tab(materialThickness, tabLength);
     translate([w, 0])
         rotate(90)
            tab(materialThickness, tabLength);
    translate([w, h])
    rotate(180) {
      tab(materialThickness, tabLength);
      translate([w, 0])
         rotate(90)
            tab(materialThickness, tabLength);
    }
}

module handle() {
    w = 90;
    h = 30;
    translate([h/2, h/2]) {
        hull() {
           circle(d=h);
           translate([w-h, 0])
              circle(d=h);
        }
    }
}
for(i = [0:3]){ 
    translate([255*i, 0])
        klodskasse(drawerW, drawerH, drawerD, materialThickness, tabLength, tabMargin=tabMargin);
}