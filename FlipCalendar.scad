/*
UNTESTED AS OF 2018-04-05
*/

use <lasercutDrawer/box.scad>
use <lasercutDrawer/dotted.scad>

materialThickness = 3;
brickSides = 32; // Print on both sides
margin=1;
lr = 0.1; // Laser removes
// 
// Skal have 50x50mm brikker
// difference() {
// 	box(50, (brickSides/4+1)*materialThickness, 103, materialThickness, fingerLength=materialThickness*2, marginBetweenCuts=1, laserRemoves=lr, drawText=false, inside=true);
// 	translate([((brickSides/4+1)*materialThickness+1+materialThickness*2)*4+25+materialThickness, 103-25+materialThickness])
// 		circle(d=40);
// 	translate([((brickSides/4+1)*materialThickness+1+materialThickness*2)*4+50+materialThickness*2+1+25+materialThickness, 25+materialThickness])
// 		circle(d=40);
// 	translate([((brickSides/4+1)*materialThickness+materialThickness*2+1)*2+materialThickness+materialThickness*1.5, 50+materialThickness])
// 		dotted((brickSides/4+1)*materialThickness-materialThickness*3, materialThickness, laserRemoves=lr, fingerLength=materialThickness*2, margin=0);
// 	translate([((brickSides/4+1)*materialThickness+materialThickness*2+1)*3+materialThickness+materialThickness*1.5, 50+materialThickness])
// 		dotted((brickSides/4+1)*materialThickness-materialThickness*3, materialThickness, laserRemoves=lr, fingerLength=materialThickness*2, margin=0);
// }
// translate([0, 50+materialThickness*2+1]) {
	difference() {
		square([(brickSides/4+1)*materialThickness-materialThickness*3, 50+materialThickness*2]);
		reverseDotted((brickSides/4+1)*materialThickness-materialThickness*3, materialThickness, laserRemoves=lr, fingerLength=materialThickness*2, margin=0);
		translate([0, 50+materialThickness])
			reverseDotted((brickSides/4+1)*materialThickness-materialThickness*3, materialThickness, laserRemoves=lr, fingerLength=materialThickness*2, margin=0);
	}
// }
// Cut and etch one side of bricks
// translate([(0*50)+1, 103+materialThickness*2+1+50-margin+51]) {
// 	square(0.01);
// }

// for(i=[0:(brickSides/2)-1]) {
// 	translate([(i*50)+1, 103+materialThickness*2+1]) {
// 		difference() {
// 			// square(50-margin);
// 			translate([25,25])
// 				text(str(i+1), size=20, halign="center", valign="center");
// 		}
// 	}
// }

// Flip all the bricks (on short side, so when flipped over, number is right side up) and etch this side
// for(i=[(brickSides/2):brickSides-1]) {
// 	translate([((i-(brickSides/2))*50)+1, 103+materialThickness*2+1+51]) {
// 		translate([25,25])
// 			text(str(i+1), size=20, halign="center", valign="center");
// 	}
// }