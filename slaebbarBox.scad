use <FanGuard.scad>
use <lasercutDrawer/box.scad>
use <honeycomb.scad>
use <cantor.scad>

$fn=64;
materialThickness = 3;
boxW = 190;
boxD = 180;
boxH = 50;

airVentY = boxH-materialThickness*9;

difference() {
	box(boxW,boxD,boxH, materialThickness, drawText=true, inside=true);
	translate([(boxD+1+materialThickness*2)*3+materialThickness+boxD/3/2,25+materialThickness]) {
		fanGuard(3, fanRadius=40, centerRadius=20, finRadius=20, finThickness=2, fins=12);
		translate([(boxD)/3, 0]) {
			fanGuard(3, fanRadius=40, centerRadius=20, finRadius=20, finThickness=2, fins=12);
			translate([(boxD)/3, 0]) {
				fanGuard(3, fanRadius=40, centerRadius=20, finRadius=20, finThickness=2, fins=12);
			}
		}
	}
	translate([(boxD+1+materialThickness*2)*2+materialThickness+5,materialThickness+airVentY]) {
		for(i=[0:3]) {
			translate([0, i*materialThickness*2])
				square([boxD-10, materialThickness]);
		}
	}
}
translate([(boxD+1+materialThickness*2)*2+materialThickness+5+boxD/3-materialThickness,materialThickness+airVentY])
	square([materialThickness, 8*materialThickness]);
translate([(boxD+1+materialThickness*2)*2+materialThickness+5+boxD/3*2-materialThickness,materialThickness+airVentY])
	square([materialThickness, 8*materialThickness]);


/*

TODO: 
	Cut hole for backpanel
	Fan-mount screws
	Mobo-mount screws
	Ball-catch holes for PSU?
	Ball-catch holes for netbook?
*/