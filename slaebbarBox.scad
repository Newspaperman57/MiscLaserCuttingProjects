use <FanGuard.scad>
use <lasercutDrawer/box.scad>
use <honeycomb.scad>
use <cantor.scad>

$fn=64;
materialThickness = 3;
boxW = 185;
boxD = 185;
boxH = 50;

airVentY = boxH-materialThickness*9;

moboRiserScrewHoleSize = 3;
fanMountSpacing = 32;
FanMountScrew = 5;
speakonDiameter = 23.5;
speakonWidth = 26;
DATUMX = INCH(-.650+12);
DATUMY = 0;
DATUMZ = INCH(.400); // From face of mobo
moboRiserHeight = 6;
moboSpaceX = 12; // Fan width
function INCH(x) = x*25.4; 

difference() {
	box(boxW,boxD,boxH, materialThickness, drawText=false, inside=true, laserRemoves=0.1);
	translate([(boxD+1+materialThickness*2)*3+materialThickness+boxD/3/2,25+materialThickness]) {
		fanGuard(3, fanRadius=40, screwSpacing=fanMountSpacing, screwMountSize=FanMountScrew, centerRadius=20, finRadius=20, finThickness=2, fins=12);
		translate([(boxD)/3, 0]) {
			fanGuard(3, fanRadius=40,  screwSpacing=fanMountSpacing, screwMountSize=FanMountScrew, centerRadius=20, finRadius=20, finThickness=2, fins=12);
			translate([(boxD)/3, 0]) {
				fanGuard(3, fanRadius=40, screwSpacing=fanMountSpacing, screwMountSize=FanMountScrew, centerRadius=20, finRadius=20, finThickness=2, fins=12);
			}
		}
	}
	translate([(boxD+1+materialThickness*2)*2+materialThickness+5,materialThickness+airVentY]) {
		for(i=[0:3]) {
			translate([0, i*materialThickness*2])
				square([boxD-10, materialThickness]);
		}
	}
	translate([moboSpaceX+768+materialThickness, materialThickness]) {
		translate([DATUMX-INCH(5.196+6.250), moboRiserHeight+DATUMY-INCH(0.150-0.062)/*From bottom of mobo*/]) {
			square([INCH(6.250), INCH(1.750)]);
		}
	}
	translate([953+(speakonWidth-speakonDiameter/2)-materialThickness, materialThickness+boxH-speakonDiameter/2]) {
		square([speakonDiameter, 25+speakonDiameter/2]);
		translate([speakonDiameter/2, 0])
			circle(d=speakonDiameter);
	}
	translate([953+(speakonWidth-speakonDiameter/2)-materialThickness+speakonWidth, materialThickness+boxH-speakonDiameter/2]) {
		square([speakonDiameter, 25+speakonDiameter/2]);
		translate([speakonDiameter/2, 0])
			circle(d=speakonDiameter);
	}
	translate([DATUMX+materialThickness-INCH(11.1)+moboSpaceX, DATUMZ+materialThickness+INCH(0.900)])
		circle(d=moboRiserScrewHoleSize);
	translate([DATUMX+materialThickness-INCH(11.1)+moboSpaceX, DATUMZ+materialThickness+INCH(6.100)])
		circle(d=moboRiserScrewHoleSize);
	translate([DATUMX+materialThickness-INCH(4.900)+moboSpaceX, DATUMZ+materialThickness])
		circle(d=moboRiserScrewHoleSize);
	translate([DATUMX+materialThickness-INCH(4.900)+moboSpaceX, DATUMZ+materialThickness+INCH(6.100)])
		circle(d=moboRiserScrewHoleSize);
}
translate([(boxD+1+materialThickness*2)*2+materialThickness+5+boxD/3-materialThickness,materialThickness+airVentY])
	square([materialThickness, 8*materialThickness]);
translate([(boxD+1+materialThickness*2)*2+materialThickness+5+boxD/3*2-materialThickness,materialThickness+airVentY])
	square([materialThickness, 8*materialThickness]);


/*

TODO: 
DON	Cut hole for backpanel
DON	Fan-mount screws
DON	Mobo-mount screws
	Ball-catch holes for PSU?
	Ball-catch holes for netbook?
*/