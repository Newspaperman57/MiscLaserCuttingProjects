LEDspacing = 1640/99; // 5000mm 300led
LEDNUMW = 64;
LEDNUMH = 1;
LEDW = 4.8;
LEDH = 4.8;
margin=10;
resistorW = 0.6;
resistorH = 2;
solderW = 3.4;
solderH = 1.4;
solderSpace = 1.3;

/*translate([30, 110])
text("LED Matrix", size=40);
translate([90, 60])
text("20x10", size=40);
translate([13, 10])
text("Mathias Pihl", size=40);
*/
difference() {
    square([(LEDNUMW-1)*LEDspacing+margin*2, (LEDNUMH-1)*LEDspacing+margin*2]);
    for(i = [0:LEDNUMW-1]) {
        for(j = [0:LEDNUMH-1]) {
            translate([i*LEDspacing+margin-LEDW/2, j*LEDspacing+margin-LEDH/2]) {
                square([LEDW, LEDH]);
                translate([0, -0.5])
                    square([1, 0.5]);
                translate([LEDW-1, -0.5])
                    square([1, 0.5]);
                translate([LEDW-1, LEDH])
                    square([1, 0.5]);
                translate([0, LEDH])
                    square([1, 0.5]); // Solder on LED
                translate([(j%2==1)?(LEDW+1):(-1-resistorW), LEDH/2-(resistorH/2)])
                    square([resistorW, resistorH]);
                for(h = [0:2]) {
                    translate([(LEDspacing/2+LEDW/2-solderW/2), (LEDH/2-solderH*3/2-solderSpace)+h*(solderSpace+solderH)]) {
                        square([solderW, solderH]);
                    }
                    translate([LEDW-(LEDspacing/2+LEDW/2+solderW/2), (LEDH/2-solderH*3/2-solderSpace)+h*(solderSpace+solderH)]) {
                        square([solderW, solderH]);
                    }
                }
            }
        }
    }   
}

translate([0, (LEDNUMH-1)*LEDspacing+margin*2+2]) 
    square([(LEDNUMW-1)*LEDspacing+margin*2, (LEDNUMH-1)*LEDspacing+margin*2]);
